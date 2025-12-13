<template>
  <div class="product-list-view">
    <Navbar />
    
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-container">
        <h1 class="page-title">{{ pageTitle }}</h1>
        <p class="page-subtitle" v-if="selectedCategoryName">
          当前分类：{{ selectedCategoryName }}
        </p>
      </div>
    </div>

    <!-- 筛选栏 -->
    <div class="filter-section">
      <div class="filter-container">
        <div class="filter-left">
          <!-- 分类筛选 -->
          <div class="filter-group">
            <label class="filter-label">分类：</label>
            <select 
              v-model.number="selectedCategoryId" 
              class="filter-select"
              @change="handleCategoryChange"
            >
              <option :value="0">全部分类</option>
              <option 
                v-for="cat in categories" 
                :key="cat.id" 
                :value="cat.id"
              >
                {{ cat.name }}
              </option>
            </select>
          </div>

          <!-- 价格筛选 -->
          <div class="filter-group">
            <label class="filter-label">价格：</label>
            <input
              type="number"
              v-model.number="minPrice"
              class="price-input"
              placeholder="最低价"
              min="0"
              @input="handlePriceFilter"
            />
            <span class="price-separator">-</span>
            <input
              type="number"
              v-model.number="maxPrice"
              class="price-input"
              placeholder="最高价"
              min="0"
              @input="handlePriceFilter"
            />
          </div>
        </div>

        <div class="filter-right">
          <!-- 排序 -->
          <div class="filter-group">
            <label class="filter-label">排序：</label>
            <select v-model="sortBy" class="filter-select" @change="handleSortChange">
              <option value="default">默认排序</option>
              <option value="price_asc">价格从低到高</option>
              <option value="price_desc">价格从高到低</option>
              <option value="name_asc">名称A-Z</option>
              <option value="name_desc">名称Z-A</option>
            </select>
          </div>

          <button class="btn-reset" @click="handleReset">重置筛选</button>
        </div>
      </div>
    </div>

    <!-- 商品列表 -->
    <div class="content-section">
      <div class="content-container">
        <!-- 加载状态 -->
        <div v-if="loading" class="loading-state">
          <div class="loading-spinner">
            <div class="spinner-circle"></div>
            <p>加载中...</p>
          </div>
        </div>

        <!-- 错误状态 -->
        <div v-else-if="error" class="error-state">
          <div class="error-icon">⚠️</div>
          <p>{{ error }}</p>
          <button class="retry-btn" @click="loadProducts">重试</button>
        </div>

        <!-- 商品网格 -->
        <div v-else-if="displayProducts.length > 0" class="product-grid">
          <ProductCard
            v-for="product in displayProducts"
            :key="product.id"
            :product="product"
            @add-to-cart="handleAddToCart"
          />
        </div>

        <!-- 空状态 -->
        <div v-else class="empty-state">
          <div class="empty-icon">📦</div>
          <p>暂无商品</p>
          <button class="btn-primary" @click="handleReset">查看全部商品</button>
        </div>

        <!-- 分页 -->
        <div v-if="!loading && !error && totalPages > 1" class="pagination">
          <button 
            class="page-btn" 
            :disabled="currentPage === 1"
            @click="goToPage(currentPage - 1)"
          >
            上一页
          </button>
          
          <div class="page-numbers">
            <button
              v-for="page in visiblePages"
              :key="page"
              class="page-number"
              :class="{ active: page === currentPage }"
              @click="goToPage(page)"
            >
              {{ page }}
            </button>
          </div>

          <button 
            class="page-btn" 
            :disabled="currentPage === totalPages"
            @click="goToPage(currentPage + 1)"
          >
            下一页
          </button>
        </div>

        <!-- 分页信息 -->
        <div v-if="!loading && !error && total > 0" class="pagination-info">
          显示第 {{ (currentPage - 1) * pageSize + 1 }} - {{ Math.min(currentPage * pageSize, total) }} 条，
          共 {{ total }} 条商品
        </div>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
import ProductCard from '@/components/Product/ProductCard.vue'
import {
  getAllProductsWithPage,
  getProductsByCategoryWithPage,
  getCategories
} from '@/api/product.js'
import { addToCart } from '@/api/cart.js'

const route = useRoute()
const router = useRouter()

// 分类数据
const categories = ref([])
const selectedCategoryId = ref(0)
const selectedCategoryName = computed(() => {
  if (selectedCategoryId.value === 0) return ''
  const category = categories.value.find(c => c.id === selectedCategoryId.value)
  return category ? category.name : ''
})

// 商品数据
const products = ref([])
const loading = ref(false)
const error = ref(null)

// 筛选条件
const minPrice = ref(null)
const maxPrice = ref(null)
const sortBy = ref('default')

// 分页
const currentPage = ref(1)
const pageSize = ref(20)
const total = ref(0)
const totalPages = computed(() => Math.ceil(total.value / pageSize.value))

// 页面标题
const pageTitle = computed(() => {
  if (route.query.sort === 'hot') return '热门推荐'
  if (route.query.tag === 'new') return '新品上市'
  if (selectedCategoryId.value > 0) return selectedCategoryName.value
  return '商品选购'
})

// 加载分类数据
const loadCategories = async () => {
  try {
    const res = await getCategories()
    if (res && res.code === 200 && Array.isArray(res.data)) {
      const mapped = res.data.map(c => ({
        id: Number(c.category_id || c.id),
        name: c.category_name || c.name || ''
      }))
      categories.value = mapped
    }
  } catch (e) {
    console.error('加载分类失败:', e)
  }
}

// 转换商品数据
const transformProduct = (backendProduct) => {
  const categoryId = backendProduct.category_id != null 
    ? Number(backendProduct.category_id) 
    : (backendProduct.categoryId != null ? Number(backendProduct.categoryId) : 0)
  
  let imageUrl = backendProduct.image_url || 
                 backendProduct.image || 
                 backendProduct.imageUrl || 
                 ''
  imageUrl = imageUrl ? String(imageUrl).trim() : ''
  
  return {
    id: backendProduct.product_id || backendProduct.id,
    name: backendProduct.name || '',
    description: backendProduct.description || '',
    price: parseFloat(backendProduct.price || 0),
    categoryId: categoryId,
    image: imageUrl,
    stock: backendProduct.stock || 0,
    isHot: Math.random() > 0.5,
    isNew: Math.random() > 0.5
  }
}

// 加载商品数据
const loadProducts = async () => {
  loading.value = true
  error.value = null
  
  try {
    let response
    
    if (selectedCategoryId.value === 0) {
      response = await getAllProductsWithPage(currentPage.value, pageSize.value)
    } else {
      response = await getProductsByCategoryWithPage(selectedCategoryId.value, currentPage.value, pageSize.value)
    }
    
    if (response.code === 200 && response.data) {
      let productList = null
      
      if (Array.isArray(response.data)) {
        productList = response.data
        total.value = productList.length
      } else if (response.data.list && Array.isArray(response.data.list)) {
        productList = response.data.list
        total.value = response.data.total || productList.length
      } else {
        throw new Error('返回的数据格式不正确')
      }
      
      if (Array.isArray(productList)) {
        products.value = productList.map(transformProduct)
      } else {
        throw new Error('返回的数据格式不正确')
      }
    } else {
      throw new Error(response.message || '获取商品数据失败')
    }
  } catch (err) {
    console.error('加载商品数据失败:', err)
    error.value = err.message || '加载商品数据失败，请稍后重试'
    products.value = []
  } finally {
    loading.value = false
  }
}

// 过滤和排序后的商品
const displayProducts = computed(() => {
  let result = [...products.value]
  
  // 价格筛选
  if (minPrice.value !== null && minPrice.value > 0) {
    result = result.filter(p => p.price >= minPrice.value)
  }
  if (maxPrice.value !== null && maxPrice.value > 0) {
    result = result.filter(p => p.price <= maxPrice.value)
  }
  
  // 排序
  switch (sortBy.value) {
    case 'price_asc':
      result.sort((a, b) => a.price - b.price)
      break
    case 'price_desc':
      result.sort((a, b) => b.price - a.price)
      break
    case 'name_asc':
      result.sort((a, b) => a.name.localeCompare(b.name))
      break
    case 'name_desc':
      result.sort((a, b) => b.name.localeCompare(a.name))
      break
    default:
      // 默认排序保持原样
      break
  }
  
  return result
})

// 处理分类变化
const handleCategoryChange = () => {
  currentPage.value = 1
  loadProducts()
}

// 处理价格筛选
const handlePriceFilter = () => {
  // 价格筛选在前端进行，不需要重新加载
}

// 处理排序变化
const handleSortChange = () => {
  // 排序在前端进行，不需要重新加载
}

// 重置筛选
const handleReset = () => {
  selectedCategoryId.value = 0
  minPrice.value = null
  maxPrice.value = null
  sortBy.value = 'default'
  currentPage.value = 1
  loadProducts()
}

// 分页
const visiblePages = computed(() => {
  const pages = []
  const maxVisible = 5
  let start = Math.max(1, currentPage.value - Math.floor(maxVisible / 2))
  let end = Math.min(totalPages.value, start + maxVisible - 1)
  
  if (end - start < maxVisible - 1) {
    start = Math.max(1, end - maxVisible + 1)
  }
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})

const goToPage = (page) => {
  if (page >= 1 && page <= totalPages.value) {
    currentPage.value = page
    loadProducts()
    // 滚动到顶部
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

// 添加到购物车
const handleAddToCart = async (product) => {
  try {
    const userId = Number(localStorage.getItem('userId') || '1')
    const response = await addToCart(userId, product.id, 1)
    
    if (response && response.code === 200) {
      const cartCount = response.data?.cartCount
      if (cartCount != null) {
        localStorage.setItem('cartCount', String(cartCount))
      }
      window.dispatchEvent(new Event('cart-updated'))
      alert(`已将 ${product.name} 添加到购物车`)
    } else {
      alert('添加到购物车失败: ' + (response?.message || '未知错误'))
    }
  } catch (error) {
    console.error('添加到购物车失败:', error)
    alert('添加到购物车失败，请稍后重试')
  }
}

// 初始化
onMounted(() => {
  // 从路由参数获取分类ID
  if (route.query.category) {
    selectedCategoryId.value = Number(route.query.category) || 0
  }
  
  // 加载分类和商品
  loadCategories()
  loadProducts()
})

// 监听路由变化
watch(() => route.query, (newQuery) => {
  if (newQuery.category) {
    selectedCategoryId.value = Number(newQuery.category) || 0
    currentPage.value = 1
    loadProducts()
  }
}, { immediate: true })
</script>

<style scoped>
.product-list-view {
  min-height: 100vh;
  background-color: #f5f5f5;
  display: flex;
  flex-direction: column;
}

.page-header {
  background-color: #fff;
  border-bottom: 1px solid #e5e7eb;
  padding: 24px 0;
}

.header-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #111827;
  margin-bottom: 8px;
}

.page-subtitle {
  font-size: 14px;
  color: #6b7280;
}

.filter-section {
  background-color: #fff;
  border-bottom: 1px solid #e5e7eb;
  padding: 16px 0;
}

.filter-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.filter-left,
.filter-right {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.filter-group {
  display: flex;
  align-items: center;
  gap: 8px;
}

.filter-label {
  font-size: 14px;
  color: #374151;
  white-space: nowrap;
}

.filter-select,
.price-input {
  padding: 6px 12px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  background-color: #fff;
}

.filter-select {
  min-width: 120px;
}

.price-input {
  width: 80px;
}

.price-separator {
  color: #6b7280;
}

.btn-reset {
  padding: 6px 16px;
  background-color: #f3f4f6;
  color: #374151;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-reset:hover {
  background-color: #e5e7eb;
}

.content-section {
  flex: 1;
  padding: 32px 0;
}

.content-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
}

.loading-state,
.error-state,
.empty-state {
  text-align: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 12px;
}

.loading-spinner {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.spinner-circle {
  width: 40px;
  height: 40px;
  border: 4px solid #e5e7eb;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.error-icon,
.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.error-state p,
.empty-state p {
  font-size: 16px;
  color: #6b7280;
  margin-bottom: 16px;
}

.retry-btn,
.btn-primary {
  padding: 8px 16px;
  background-color: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.retry-btn:hover,
.btn-primary:hover {
  background-color: #1d4ed8;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 20px;
  margin-bottom: 32px;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  margin: 32px 0;
  flex-wrap: wrap;
}

.page-btn,
.page-number {
  padding: 8px 12px;
  border: 1px solid #d1d5db;
  background-color: #fff;
  color: #374151;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s ease;
  min-width: 40px;
}

.page-btn:hover:not(:disabled),
.page-number:hover {
  background-color: #f3f4f6;
  border-color: #2563eb;
}

.page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.page-number.active {
  background-color: #2563eb;
  color: #fff;
  border-color: #2563eb;
}

.page-numbers {
  display: flex;
  gap: 4px;
}

.pagination-info {
  text-align: center;
  color: #6b7280;
  font-size: 14px;
  margin-top: 16px;
}

@media (max-width: 1024px) {
  .product-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 16px;
  }
}

@media (max-width: 768px) {
  .product-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 12px;
  }

  .filter-container {
    flex-direction: column;
    align-items: stretch;
  }

  .filter-left,
  .filter-right {
    width: 100%;
    justify-content: space-between;
  }
}

@media (max-width: 480px) {
  .product-grid {
    grid-template-columns: minmax(0, 1fr);
  }

  .page-title {
    font-size: 24px;
  }
}
</style>
