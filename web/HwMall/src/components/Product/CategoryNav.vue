<template>
  <section class="category-nav">
    <div class="category-container">
      <div
        v-for="category in categories"
        :key="category.id"
        class="category-item"
        :class="{ active: activeCategoryIdNum === category.id }"
        @click="handleCategoryClick(category)"
      >
        <div class="category-icon-wrapper">
          <div class="category-icon">{{ category.icon }}</div>
        </div>
        <div class="category-name">{{ category.name }}</div>
      </div>
      <!-- 加载状态 -->
      <div v-if="loading" class="category-loading">
        <div class="loading-spinner-small"></div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { getCategories } from '@/api/product.js'

const props = defineProps({
  activeCategoryId: {
    type: [Number, String],
    default: 0,
    validator: (value) => {
      // 允许数字或可以转换为数字的字符串
      return !isNaN(Number(value))
    }
  }
})

// 计算属性：确保 activeCategoryId 始终是数字
const activeCategoryIdNum = computed(() => {
  return Number(props.activeCategoryId) || 0
})

const emit = defineEmits(['category-click'])

const categories = ref([
  { id: 0, name: '全部', icon: '📦' }
])
const loading = ref(false)

// 默认图标映射（如果后端没有提供图标）
const defaultIcons = {
  1: '🏠',
  2: '🏃',
  3: '💻',
  4: '📱',
  5: '📚'
}

const loadCategories = async () => {
  loading.value = true
  try {
    const res = await getCategories()
    console.log('分类接口原始返回:', res)
    
    // 后端返回格式: { code: 200, message: "success", data: [...] }
    // 响应拦截器返回 response.data，所以 res 就是 { code, message, data }
    let list = null
    
    if (res && res.code === 200 && Array.isArray(res.data)) {
      // 标准格式：{ code: 200, data: [...] }
      list = res.data
      console.log('解析到分类列表:', list)
    } else if (Array.isArray(res)) {
      // 如果直接是数组（兼容处理）
      list = res
      console.log('直接是数组格式:', list)
    } else if (res && Array.isArray(res.data)) {
      // 其他可能的格式
      list = res.data
      console.log('从res.data获取:', list)
    } else {
      console.warn('无法解析分类数据，res:', res)
    }
    
    if (Array.isArray(list) && list.length > 0) {
      // map backend fields to frontend
      // 后端字段: category_id, category_name, parent_id
      const mapped = list.map(c => {
        const categoryId = c.category_id != null ? c.category_id : (c.id != null ? c.id : null)
        const categoryName = c.category_name || c.name || ''
        if (categoryId == null) {
          console.warn('分类数据缺少ID:', c)
          return null
        }
        return {
          id: Number(categoryId),
          name: String(categoryName),
          icon: c.icon || defaultIcons[categoryId] || '📦'
        }
      }).filter(c => c != null) // 过滤掉无效数据
      
      console.log('映射后的分类:', mapped)
      
      if (mapped.length > 0) {
        categories.value = [{ id: 0, name: '全部', icon: '📦' }, ...mapped]
        console.log('最终分类数据:', categories.value)
      } else {
        throw new Error('分类数据映射后为空')
      }
    } else {
      console.warn('分类数据为空或格式不正确，使用默认分类')
      // 使用默认分类
      categories.value = [
        { id: 0, name: '全部', icon: '📦' },
        { id: 1, name: '智能家居', icon: '🏠' },
        { id: 2, name: '户外运动', icon: '🏃' },
        { id: 3, name: '电脑主板', icon: '💻' },
        { id: 4, name: '手机', icon: '📱' },
        { id: 5, name: '图书影像', icon: '📚' }
      ]
    }
  } catch (e) {
    // 如果获取失败，使用默认分类
    console.error('加载分类失败:', e)
    console.error('错误详情:', e.message)
    // 使用默认分类作为fallback
    categories.value = [
      { id: 0, name: '全部', icon: '📦' },
      { id: 1, name: '智能家居', icon: '🏠' },
      { id: 2, name: '户外运动', icon: '🏃' },
      { id: 3, name: '电脑主板', icon: '💻' },
      { id: 4, name: '手机', icon: '📱' },
      { id: 5, name: '图书影像', icon: '📚' }
    ]
  } finally {
    loading.value = false
  }
}

const handleCategoryClick = (category) => {
  console.log('分类被点击:', category)
  console.log('分类ID:', category.id, '类型:', typeof category.id)
  emit('category-click', category)
}

onMounted(() => {
  loadCategories()
})
</script>

<style scoped>
.category-nav {
  background-color: #fff;
  padding: 24px 0;
  border-bottom: 1px solid #e5e7eb;
}

.category-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
  display: grid;
  grid-template-columns: repeat(8, 1fr);
  gap: 16px;
}

.category-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 16px 8px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  border: 2px solid transparent;
}

.category-item:hover {
  background-color: #f3f4f6;
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.category-item.active {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  border-color: #2563eb;
  box-shadow: 0 4px 16px rgba(37, 99, 235, 0.3);
}

.category-item.active .category-name {
  color: #fff;
  font-weight: 600;
}

.category-item.active .category-icon-wrapper {
  transform: scale(1.1);
}

.category-icon-wrapper {
  transition: transform 0.3s ease;
}

.category-icon {
  font-size: 36px;
  margin-bottom: 4px;
  display: block;
  transition: transform 0.3s ease;
}

.category-item:hover .category-icon {
  transform: scale(1.1);
}

.category-name {
  font-size: 14px;
  color: #374151;
  font-weight: 500;
  transition: color 0.3s ease;
}

.category-loading {
  grid-column: 1 / -1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.loading-spinner-small {
  width: 24px;
  height: 24px;
  border: 3px solid #e5e7eb;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

@media (max-width: 1024px) {
  .category-container {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (max-width: 640px) {
  .category-container {
    grid-template-columns: repeat(4, 1fr);
    gap: 8px;
  }

  .category-icon {
    font-size: 24px;
  }

  .category-name {
    font-size: 12px;
  }
}
</style>

