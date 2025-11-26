<template>
  <div class="search-view">
    <div class="search-view-header">
      <h1 class="page-title">商品搜索</h1>
    </div>

    <div class="search-view-content">
      <!-- 搜索框 -->
      <div class="search-section">
        <SearchBox
          :placeholder="'搜索商品名称，例如：手机、耳机、电脑'"
          @search="handleSearch"
        />
      </div>

      <!-- 搜索结果 -->
      <div v-if="hasSearched" class="result-section">
        <SearchResult
          :products="products"
          :total="total"
          :keyword="currentKeyword"
          :page="page"
          :pageSize="pageSize"
          @page-change="handlePageChange"
          @product-click="handleProductClick"
        />
      </div>

      <!-- 初始状态提示 -->
      <div v-else class="empty-state">
        <div class="empty-icon">🔍</div>
        <div class="empty-text">请输入关键词搜索商品</div>
      </div>

      <!-- 加载状态 -->
      <div v-if="loading" class="loading-container">
        <div class="loading-spinner">搜索中...</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import SearchBox from '@/components/Search/SearchBox.vue'
import SearchResult from '@/components/Search/SearchResult.vue'
import { searchProducts } from '@/api/search.js'

const products = ref([])
const total = ref(0)
const currentKeyword = ref('')
const page = ref(1)
const pageSize = ref(10)
const hasSearched = ref(false)
const loading = ref(false)

// 处理搜索
const handleSearch = async (keyword) => {
  if (!keyword || keyword.trim() === '') {
    alert('请输入搜索关键词')
    return
  }

  loading.value = true
  hasSearched.value = true
  currentKeyword.value = keyword
  page.value = 1 // 重置到第一页

  try {
    const response = await searchProducts(keyword, page.value, pageSize.value)
    if (response.code === 200) {
      products.value = response.data.list || []
      total.value = response.data.total || 0
    } else {
      alert('搜索失败: ' + response.message)
      products.value = []
      total.value = 0
    }
  } catch (error) {
    console.error('搜索错误:', error)
    alert('搜索失败，请稍后重试')
    products.value = []
    total.value = 0
  } finally {
    loading.value = false
  }
}

// 处理分页
const handlePageChange = async (newPage) => {
  if (newPage < 1 || !currentKeyword.value) return

  loading.value = true
  page.value = newPage

  try {
    const response = await searchProducts(currentKeyword.value, page.value, pageSize.value)
    if (response.code === 200) {
      products.value = response.data.list || []
      total.value = response.data.total || 0
      // 滚动到顶部
      window.scrollTo({ top: 0, behavior: 'smooth' })
    } else {
      alert('加载失败: ' + response.message)
    }
  } catch (error) {
    console.error('加载错误:', error)
    alert('加载失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

// 处理商品点击
const handleProductClick = (productId) => {
  // 跳转到商品详情页（功能待实现）
  console.log('点击商品:', productId)
  alert(`跳转到商品详情页（商品ID: ${productId}）功能待实现`)
  // 实际项目中应该使用路由跳转
  // router.push({ name: 'ProductDetail', params: { id: productId } })
}
</script>

<style scoped>
.search-view {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.search-view-header {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.search-view-content {
  max-width: 1120px;
  margin: 0 auto;
  padding: 0 16px 40px;
}

.search-section {
  background-color: #fff;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  margin-bottom: 20px;
}

.result-section {
  background-color: #fff;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
}

.empty-state {
  text-align: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.empty-text {
  font-size: 16px;
  color: #6b7280;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
}

.loading-spinner {
  font-size: 16px;
  color: #6b7280;
}
</style>

