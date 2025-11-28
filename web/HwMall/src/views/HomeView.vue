<template>
  <div class="page-wrapper">
    <Navbar />
    
    <!-- 搜索栏 -->
    <div class="search-bar-section">
      <div class="search-container">
        <SearchFilter @search="handleSearch" @filter="handleFilter" />
      </div>
    </div>

    <!-- 轮播图和侧边栏 -->
    <Banner @slide-click="handleBannerClick" />

    <!-- 分类导航 -->
    <CategoryNav @category-click="handleCategoryClick" />

    <main class="main">
      <div class="content-inner">
        <!-- 热门推荐 -->
        <section class="product-section">
          <SectionHeader
            title="热门推荐"
            subtitle="精选好物，品质保证"
            more-link="/products?sort=hot"
          />
          <div v-if="loading" class="loading-state">
            <div class="loading-spinner">加载中...</div>
          </div>
          <div v-else-if="error" class="error-state">
            <div class="error-icon">⚠️</div>
            <p>{{ error }}</p>
            <button class="retry-btn" @click="loadProducts">重试</button>
          </div>
          <div v-else-if="hotProducts.length > 0" class="product-grid">
            <ProductCard
              v-for="product in hotProducts"
              :key="product.id"
              :product="product"
              @add-to-cart="handleAddToCart"
            />
          </div>
          <div v-else class="empty-state">
            <div class="empty-icon">📦</div>
            <p>暂无热门商品</p>
          </div>
        </section>

        <!-- 搜索结果或全部商品 -->
        <section id="products" class="product-section">
          <SectionHeader
            :title="searchKeyword ? '搜索结果' : '精选商品'"
            :subtitle="searchKeyword 
              ? `找到 ${filteredProducts.length} 件相关商品` 
              : '以下为静态示例数据，后续可由后端接口返回真实商品信息。'"
            :more-link="searchKeyword ? '' : '/products'"
          />

          <!-- 当有搜索关键词时，使用 SearchResult 组件 -->
          <SearchResult
            v-if="searchKeyword"
            :products="formattedSearchProducts"
            :total="filteredProducts.length"
            :keyword="searchKeyword"
            :page="currentPage"
            :page-size="pageSize"
            @page-change="handlePageChange"
            @product-click="handleProductClick"
          />

          <!-- 无搜索关键词时，使用 ProductCard 网格展示 -->
          <div v-else-if="filteredProducts.length > 0" class="product-grid">
            <ProductCard
              v-for="product in filteredProducts"
              :key="product.id"
              :product="product"
              @add-to-cart="handleAddToCart"
            />
          </div>
          <div v-else class="empty-state">
            <div class="empty-icon">📦</div>
            <p>暂无商品数据</p>
          </div>
        </section>

        <!-- 新品上市 -->
        <section class="product-section">
          <SectionHeader
            title="新品上市"
            subtitle="最新上架，抢先体验"
            more-link="/products?tag=new"
          />
          <div v-if="loading" class="loading-state">
            <div class="loading-spinner">加载中...</div>
          </div>
          <div v-else-if="newProducts.length > 0" class="product-grid">
            <ProductCard
              v-for="product in newProducts"
              :key="product.id"
              :product="product"
              @add-to-cart="handleAddToCart"
            />
          </div>
          <div v-else class="empty-state">
            <div class="empty-icon">📦</div>
            <p>暂无新品</p>
          </div>
        </section>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
import SearchFilter from '@/components/Search/SearchFilter.vue'
import Banner from '@/components/Product/Banner.vue'
import CategoryNav from '@/components/Product/CategoryNav.vue'
import SectionHeader from '@/components/Product/SectionHeader.vue'
import ProductCard from '@/components/Product/ProductCard.vue'
import SearchResult from '@/components/Search/SearchResult.vue'
import { getAllProducts } from '@/api/product.js'
import { getAllProductsWithPage } from '@/api/product.js'

const router = useRouter()

// 商品数据（从后端获取）
const products = ref([])
// 加载状态
const loading = ref(false)
// 错误信息
const error = ref(null)

// 分类ID到名称的映射（根据你的数据库实际情况调整）
const categoryMap = {
  1: '数码电子',
  2: '家居生活',
  3: '服饰鞋包',
  4: '美食零食'
}

/**
 * 转换后端数据格式为前端需要的格式
 * @param {Object} backendProduct - 后端返回的商品数据
 * @returns {Object} 前端需要的商品数据格式
 */
const transformProduct = (backendProduct) => {
  return {
    id: backendProduct.product_id || backendProduct.id,
    name: backendProduct.name || '',
    description: backendProduct.description || '',
    price: parseFloat(backendProduct.price || 0),
    category: categoryMap[backendProduct.category_id] || '其他',
    categoryId: backendProduct.category_id,
    image: backendProduct.image_url || '',
    stock: backendProduct.stock || 0,
    // 暂时随机设置热门和新品标识（后续可以从后端获取）
    isHot: Math.random() > 0.5,
    isNew: Math.random() > 0.5
  }
}

/**
 * 加载商品数据
 */
const loadProducts = async () => {
  loading.value = true
  error.value = null
  try {
    // 分页查询，默认第1页，每页20条
    const response = await getAllProductsWithPage(1, 20)
    
    // 检查响应格式
    if (response.code === 200 && response.data) {
      // 分页查询返回的 data 是对象，包含 list 属性
      // 普通查询返回的 data 是数组
      const productList = response.data.list || response.data
      
      // 确保 productList 是数组
      if (Array.isArray(productList)) {
        // 转换数据格式
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
    // 如果加载失败，使用空数组，避免页面崩溃
    products.value = []
  } finally {
    loading.value = false
  }
}

// 筛选条件
const searchKeyword = ref('')
const filterOptions = ref({
  category: '',
  minPrice: null,
  maxPrice: null
})

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)

// 热门商品
const hotProducts = computed(() => {
  return products.value.filter(p => p.isHot).slice(0, 4)
})

// 新品
const newProducts = computed(() => {
  return products.value.filter(p => p.isNew).slice(0, 4)
})

// 过滤后的商品列表
const filteredProducts = computed(() => {
  let result = products.value

  // 关键词搜索
  if (searchKeyword.value) {
    const keyword = searchKeyword.value.toLowerCase()
    result = result.filter(
      product =>
        product.name.toLowerCase().includes(keyword) ||
        product.description.toLowerCase().includes(keyword)
    )
  }

  // 分类筛选
  if (filterOptions.value.category) {
    const categoryMap = {
      digital: '数码电子',
      home: '家居生活',
      clothes: '服饰鞋包',
      food: '美食零食'
    }
    const categoryName = categoryMap[filterOptions.value.category]
    if (categoryName) {
      result = result.filter(product => product.category === categoryName)
    }
  }

  // 价格区间筛选
  if (filterOptions.value.minPrice !== null && filterOptions.value.minPrice > 0) {
    result = result.filter(product => product.price >= filterOptions.value.minPrice)
  }
  if (filterOptions.value.maxPrice !== null && filterOptions.value.maxPrice > 0) {
    result = result.filter(product => product.price <= filterOptions.value.maxPrice)
  }

  return result
})

// 处理搜索
const handleSearch = (keyword) => {
  searchKeyword.value = keyword
  currentPage.value = 1
}

// 处理筛选
const handleFilter = (options) => {
  filterOptions.value = { ...options }
}

// 处理轮播图点击
const handleBannerClick = (slide) => {
  if (slide.link) {
    router.push(slide.link)
  }
}

// 处理分类点击
const handleCategoryClick = (category) => {
  filterOptions.value.category = category.id
  handleFilter(filterOptions.value)
  // 滚动到商品区域
  setTimeout(() => {
    const section = document.getElementById('products')
    if (section) {
      section.scrollIntoView({ behavior: 'smooth' })
    }
  }, 100)
}

// 格式化商品数据以适配 SearchResult 组件
const formattedSearchProducts = computed(() => {
  return filteredProducts.value.map(product => ({
    product_id: product.id,
    name: product.name,
    description: product.description,
    price: product.price,
    stock: 100,
    category: product.category
  }))
})

// 添加到购物车
const handleAddToCart = async (product) => {
  try {
    const userId = localStorage.getItem('userId') || 1
    const { addToCart } = await import('@/api/cart.js')
    await addToCart(userId, product.id, 1)
    alert(`已将 ${product.name} 添加到购物车`)
  } catch (error) {
    console.error('添加到购物车失败:', error)
    alert('添加到购物车失败，请稍后重试')
  }
}

// 处理分页变化
const handlePageChange = (page) => {
  currentPage.value = page
}

// 处理商品点击（来自 SearchResult）
const handleProductClick = (productId) => {
  router.push(`/product/${productId}`)
}

onMounted(() => {
  // 加载商品数据
  loadProducts()
})
</script>

<style scoped>
.page-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f5f5;
}

.search-bar-section {
  background-color: #fff;
  border-bottom: 1px solid #e5e7eb;
  padding: 16px 0;
}

.search-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
}

.main {
  flex: 1;
}

.content-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 16px;
}

.product-section {
  margin-bottom: 48px;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 20px;
}

.empty-state {
  text-align: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 12px;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.empty-state p {
  font-size: 16px;
  color: #6b7280;
}

.loading-state {
  text-align: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 12px;
}

.loading-spinner {
  font-size: 16px;
  color: #6b7280;
}

.error-state {
  text-align: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 12px;
}

.error-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.error-state p {
  font-size: 16px;
  color: #ef4444;
  margin-bottom: 16px;
}

.retry-btn {
  padding: 8px 16px;
  background-color: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.retry-btn:hover {
  background-color: #1d4ed8;
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

  .content-inner {
    padding: 24px 16px;
  }

  .product-section {
    margin-bottom: 32px;
  }
}

@media (max-width: 480px) {
  .product-grid {
    grid-template-columns: minmax(0, 1fr);
  }
}
</style>
