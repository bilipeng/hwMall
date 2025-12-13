<template>
  <section class="search-filter">
    <div class="search-box">
      <SearchBox @search="handleSearch" />
    </div>
    <div class="filter-group">
      <select v-model.number="selectedCategory" class="filter-select" @change="handleFilter">
        <option v-for="cat in categories" :key="cat.value" :value="cat.value">
          {{ cat.label }}
        </option>
      </select>
      <div class="price-range">
        <input
          type="number"
          v-model.number="minPrice"
          class="price-input"
          placeholder="最低价"
          min="0"
          @input="handleFilter"
        />
        <span>-</span>
        <input
          type="number"
          v-model.number="maxPrice"
          class="price-input"
          placeholder="最高价"
          min="0"
          @input="handleFilter"
        />
      </div>
      <button class="btn btn-outline btn-sm" @click="handleFilter">筛选</button>
      <button class="btn btn-outline btn-sm" @click="handleReset">重置</button>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import SearchBox from './SearchBox.vue'
import { getCategories } from '@/api/product.js'

const emit = defineEmits(['search', 'filter'])

// 从后端获取分类数据
const categories = ref([
  { value: 0, label: '全部分类' }
])
const selectedCategory = ref(0)
const minPrice = ref(null)
const maxPrice = ref(null)

// 默认图标映射
const defaultIcons = {
  1: '🏠',
  2: '🏃',
  3: '💻',
  4: '📱',
  5: '📚'
}

// 加载分类数据
const loadCategories = async () => {
  try {
    const res = await getCategories()
    
    if (res && res.code === 200 && Array.isArray(res.data)) {
      const mapped = res.data.map(c => ({
        value: Number(c.category_id || c.id),
        label: c.category_name || c.name || ''
      }))
      categories.value = [
        { value: 0, label: '全部分类' },
        ...mapped
      ]
    } else {
      console.warn('分类数据格式不正确，使用默认分类')
      // 使用默认分类
      categories.value = [
        { value: 0, label: '全部分类' },
        { value: 1, label: '智能家居' },
        { value: 2, label: '户外运动' },
        { value: 3, label: '电脑主板' },
        { value: 4, label: '手机' },
        { value: 5, label: '图书影像' }
      ]
    }
  } catch (e) {
    console.error('加载分类失败:', e)
    // 使用默认分类
    categories.value = [
      { value: 0, label: '全部分类' },
      { value: 1, label: '智能家居' },
      { value: 2, label: '户外运动' },
      { value: 3, label: '电脑主板' },
      { value: 4, label: '手机' },
      { value: 5, label: '图书影像' }
    ]
  }
}

onMounted(() => {
  loadCategories()
})

const handleSearch = (keyword) => {
  emit('search', keyword)
}

const handleFilter = () => {
  emit('filter', {
    category: Number(selectedCategory.value) || 0,
    minPrice: minPrice.value,
    maxPrice: maxPrice.value
  })
}

const handleReset = () => {
  selectedCategory.value = 0
  minPrice.value = null
  maxPrice.value = null
  handleFilter()
}
</script>

<style scoped>
.search-filter {
  background-color: #fff;
  padding: 14px 16px 12px;
  border-radius: 10px;
  box-shadow: 0 1px 2px rgba(15, 23, 42, 0.08);
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  align-items: center;
  margin-bottom: 18px;
}

.search-box {
  flex: 1 1 220px;
}

.filter-group {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  font-size: 13px;
  align-items: center;
}

.filter-select,
.price-input {
  padding: 4px 8px;
  border-radius: 6px;
  border: 1px solid #d1d5db;
  font-size: 13px;
}

.price-range {
  display: flex;
  align-items: center;
  gap: 4px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 4px 8px;
  font-size: 12px;
  border-radius: 5px;
  border: none;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease;
}

.btn-sm {
  padding: 4px 8px;
  font-size: 12px;
}

.btn-outline {
  background-color: #fff;
  border: 1px solid #d1d5db;
  color: #374151;
}

.btn-outline:hover {
  background-color: #f3f4f6;
}
</style>

