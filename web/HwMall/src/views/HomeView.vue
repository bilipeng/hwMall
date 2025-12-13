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
    <Banner 
      :slides="bannerSlides" 
      @slide-click="handleBannerClick" 
    />

    <!-- 分类导航 -->
    <CategoryNav 
      :active-category-id="Number(filterOptions.category) || 0" 
      @category-click="handleCategoryClick" 
    />

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
            <div class="loading-spinner">
              <div class="spinner-circle"></div>
              <p>加载中...</p>
            </div>
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

        <!-- 精选商品 -->
        <section id="products" class="product-section">
          <SectionHeader
            :title="searchKeyword ? '搜索结果' : '精选商品'"
            :subtitle="searchKeyword 
              ? `找到 ${filteredProducts.length} 件相关商品` 
              : '精选好物，品质保证'"
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

          <!-- 无搜索关键词时，显示精选商品（从不同分类随机选择） -->
          <div v-else-if="featuredProducts.length > 0" class="product-grid">
            <ProductCard
              v-for="product in featuredProducts"
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
            <div class="loading-spinner">
              <div class="spinner-circle"></div>
              <p>加载中...</p>
            </div>
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
import { 
  getAllProducts, 
  getAllProductsWithPage,
  getProductsByCategoryWithPage
} from '@/api/product.js'

const router = useRouter()

// 商品数据（从后端获取）
const products = ref([])
// 加载状态
const loading = ref(false)
// 错误信息
const error = ref(null)
// 数据缓存
const productsCache = ref(new Map())

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
  // 确保 categoryId 是数字类型
  const categoryId = backendProduct.category_id != null 
    ? Number(backendProduct.category_id) 
    : (backendProduct.categoryId != null ? Number(backendProduct.categoryId) : 0)
  
  // 处理图片URL，支持多种可能的字段名
  // 注意：后端返回的字段名是 image_url（下划线格式）
  let imageUrl = backendProduct.image_url || 
                 backendProduct.image || 
                 backendProduct.imageUrl || 
                 backendProduct.product_image || 
                 ''
  
  // 去除首尾空格
  imageUrl = imageUrl ? String(imageUrl).trim() : ''
  
  // 如果图片URL是相对路径，可能需要添加baseURL
  // 如果已经是完整URL（http://或https://开头），则直接使用
  if (imageUrl && !imageUrl.startsWith('http://') && !imageUrl.startsWith('https://') && !imageUrl.startsWith('/')) {
    // 如果是相对路径，可能需要添加前缀
    // 这里可以根据实际情况调整
  }
  
  // 如果图片URL为空，记录警告（包含原始数据用于调试）
  if (!imageUrl) {
    console.warn('商品缺少图片URL:', {
      productId: backendProduct.product_id || backendProduct.id,
      name: backendProduct.name,
      allFields: Object.keys(backendProduct),
      image_url: backendProduct.image_url,
      image: backendProduct.image,
      originalData: backendProduct
    })
  }
  
  return {
    id: backendProduct.product_id || backendProduct.id,
    name: backendProduct.name || '',
    description: backendProduct.description || '',
    price: parseFloat(backendProduct.price || 0),
    category: categoryMap[categoryId] || '其他',
    categoryId: categoryId, // 确保是数字类型
    image: imageUrl,
    stock: backendProduct.stock || 0,
    // 暂时随机设置热门和新品标识（后续可以从后端获取）
    isHot: Math.random() > 0.5,
    isNew: Math.random() > 0.5
  }
}

/**
 * 加载商品数据
 * @param {number} categoryId - 分类ID，0表示全部
 * @param {boolean} forceRefresh - 是否强制刷新
 */
const loadProducts = async (categoryId = 0, forceRefresh = false) => {
  // 检查缓存
  const cacheKey = categoryId === 0 ? 'all_products' : `category_${categoryId}`
  if (!forceRefresh && productsCache.value.has(cacheKey)) {
    products.value = productsCache.value.get(cacheKey)
    return
  }

  loading.value = true
  error.value = null
  try {
    let response
    
    if (categoryId === 0) {
      // 加载全部商品（使用分页接口）
      response = await getAllProductsWithPage(1, 20)
    } else {
      // 加载指定分类的商品
      // 注意：根据后端实现，分页接口返回 { data: { list: [...] } }
      // 非分页接口返回 { data: [...] }
      // 这里使用分页接口
      response = await getProductsByCategoryWithPage(categoryId, 1, 20)
    }
    
    console.log('接口响应:', response)
    
    // 检查响应格式
    if (response.code === 200 && response.data) {
      console.log('接口返回的原始数据:', response)
      console.log('response.data类型:', Array.isArray(response.data) ? '数组' : typeof response.data)
      
      // 分页查询返回的 data 是对象，包含 list 属性
      // 非分页查询返回的 data 是数组
      let productList = null
      
      if (Array.isArray(response.data)) {
        // 直接是数组（非分页接口，如 /api/product/category/{categoryId}）
        productList = response.data
        console.log('使用数组格式，商品数量:', productList.length)
      } else if (response.data && Array.isArray(response.data.list)) {
        // 分页结果，包含 list 属性（分页接口，如 /api/product/category/{categoryId}/page）
        productList = response.data.list
        console.log('使用分页格式，商品数量:', productList.length)
      } else {
        console.error('无法解析数据格式:', response.data)
        throw new Error('返回的数据格式不正确')
      }
      
      if (productList && productList.length > 0) {
        console.log('原始商品数据（第一个）:', productList[0])
        console.log('第一个商品的image_url字段:', productList[0]?.image_url)
        console.log('第一个商品的所有字段:', Object.keys(productList[0] || {}))
      }
      
      // 确保 productList 是数组
      if (Array.isArray(productList) && productList.length > 0) {
        // 转换数据格式
        const transformedProducts = productList.map(transformProduct)
        console.log('转换后的商品数据（第一个）:', transformedProducts[0])
        console.log('第一个商品的image字段:', transformedProducts[0]?.image)
        products.value = transformedProducts
        // 缓存数据（5分钟过期）
        productsCache.value.set(cacheKey, transformedProducts)
        setTimeout(() => {
          productsCache.value.delete(cacheKey)
        }, 5 * 60 * 1000)
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
  category: 0, // 默认0表示全部，使用数字类型
  minPrice: null,
  maxPrice: null
})

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)

// 随机选择商品函数
const getRandomProducts = (productList, count) => {
  if (!productList || productList.length === 0) return []
  const shuffled = [...productList].sort(() => Math.random() - 0.5)
  return shuffled.slice(0, Math.min(count, shuffled.length))
}

// 从不同分类中随机选择商品
const getRandomProductsFromDifferentCategories = (productList, count) => {
  if (!productList || productList.length === 0) return []
  
  // 按分类分组
  const productsByCategory = {}
  productList.forEach(product => {
    const categoryId = product.categoryId || 0
    if (!productsByCategory[categoryId]) {
      productsByCategory[categoryId] = []
    }
    productsByCategory[categoryId].push(product)
  })
  
  // 获取所有分类ID并随机排序
  const categoryIds = Object.keys(productsByCategory).sort(() => Math.random() - 0.5)
  
  const selectedProducts = []
  let categoryIndex = 0
  
  // 从不同分类中轮流选择商品
  while (selectedProducts.length < count && categoryIds.length > 0) {
    const categoryId = categoryIds[categoryIndex % categoryIds.length]
    const categoryProducts = productsByCategory[categoryId]
    
    if (categoryProducts && categoryProducts.length > 0) {
      // 从该分类中随机选择一个商品
      const randomIndex = Math.floor(Math.random() * categoryProducts.length)
      const selectedProduct = categoryProducts[randomIndex]
      
      // 检查是否已选择（避免重复）
      if (!selectedProducts.find(p => p.id === selectedProduct.id)) {
        selectedProducts.push(selectedProduct)
        // 从分类列表中移除已选择的商品
        categoryProducts.splice(randomIndex, 1)
        // 如果该分类没有商品了，移除该分类
        if (categoryProducts.length === 0) {
          const index = categoryIds.indexOf(categoryId)
          if (index > -1) {
            categoryIds.splice(index, 1)
          }
        }
      }
    }
    
    categoryIndex++
    
    // 防止无限循环
    if (categoryIndex > 100) break
  }
  
  // 如果还需要更多商品，从剩余商品中随机选择
  if (selectedProducts.length < count) {
    const remainingProducts = productList.filter(
      p => !selectedProducts.find(sp => sp.id === p.id)
    )
    const additionalProducts = getRandomProducts(remainingProducts, count - selectedProducts.length)
    selectedProducts.push(...additionalProducts)
  }
  
  return selectedProducts
}

// 轮播图商品（从不同分类随机选择3个商品）
const bannerSlides = computed(() => {
  if (products.value.length === 0) {
    // 如果没有商品数据，使用默认轮播图
    return [
      {
        title: '新品上市',
        description: '精选好物，限时优惠',
        color1: '#2563eb',
        color2: '#4f46e5',
        link: '/products?tag=new'
      },
      {
        title: '限时抢购',
        description: '每日特价，不容错过',
        color1: '#ef4444',
        color2: '#dc2626',
        link: '/products?tag=flash'
      },
      {
        title: '品质生活',
        description: '精选商品，品质保证',
        color1: '#10b981',
        color2: '#059669',
        link: '/products?tag=quality'
      }
    ]
  }
  
  // 从不同分类中随机选择3个商品作为轮播图
  const randomProducts = getRandomProductsFromDifferentCategories(products.value, 3)
  const colors = [
    { color1: '#2563eb', color2: '#4f46e5' },
    { color1: '#ef4444', color2: '#dc2626' },
    { color1: '#10b981', color2: '#059669' }
  ]
  
  return randomProducts.map((product, index) => ({
    title: product.name.length > 20 ? product.name.substring(0, 20) + '...' : product.name,
    description: product.description || '精选好物，品质保证',
    image: product.image,
    link: `/product/${product.id}`,
    productId: product.id,
    ...colors[index % colors.length]
  }))
})

// 热门商品（从不同分类随机选择4个）
const hotProducts = computed(() => {
  if (products.value.length === 0) return []
  return getRandomProductsFromDifferentCategories(products.value, 4)
})

// 精选商品（从不同分类随机选择4个，排除热门推荐中的商品）
const featuredProducts = computed(() => {
  if (products.value.length === 0) return []
  // 排除已经在热门推荐中的商品
  const hotProductIds = new Set(hotProducts.value.map(p => p.id))
  const availableProducts = products.value.filter(p => !hotProductIds.has(p.id))
  return getRandomProductsFromDifferentCategories(availableProducts, 4)
})

// 新品（从不同分类随机选择4个，排除热门推荐和精选商品中的商品）
const newProducts = computed(() => {
  if (products.value.length === 0) return []
  // 排除已经在热门推荐和精选商品中的商品
  const hotProductIds = new Set(hotProducts.value.map(p => p.id))
  const featuredProductIds = new Set(featuredProducts.value.map(p => p.id))
  const excludedIds = new Set([...hotProductIds, ...featuredProductIds])
  const availableProducts = products.value.filter(p => !excludedIds.has(p.id))
  return getRandomProductsFromDifferentCategories(availableProducts, 4)
})

// 过滤后的商品列表
const filteredProducts = computed(() => {
  let result = products.value
  console.log('开始筛选，原始商品数:', result.length)

  // 关键词搜索
  if (searchKeyword.value) {
    const keyword = searchKeyword.value.toLowerCase()
    result = result.filter(
      product =>
        product.name.toLowerCase().includes(keyword) ||
        product.description.toLowerCase().includes(keyword)
    )
    console.log('搜索后商品数:', result.length)
  }

  // 注意：分类筛选现在由后端接口处理，这里不再需要前端筛选
  // 因为点击分类时会调用 loadProducts(categoryId) 重新加载数据
  // 这里保留逻辑是为了兼容搜索和价格筛选

  // 价格区间筛选
  if (filterOptions.value.minPrice !== null && filterOptions.value.minPrice > 0) {
    result = result.filter(product => product.price >= filterOptions.value.minPrice)
  }
  if (filterOptions.value.maxPrice !== null && filterOptions.value.maxPrice > 0) {
    result = result.filter(product => product.price <= filterOptions.value.maxPrice)
  }

  console.log('最终筛选结果数量:', result.length)
  return result
})

// 处理搜索
const handleSearch = (keyword) => {
  searchKeyword.value = keyword
  currentPage.value = 1
}

// 处理筛选
const handleFilter = async (options) => {
  // 确保 category 是数字类型
  let category = options.category
  if (typeof category === 'string') {
    // 如果是字符串，尝试映射到数字ID
    const categoryMap = {
      'digital': 1,
      'home': 2,
      'clothes': 3,
      'food': 4,
      '': 0,
      'all': 0
    }
    category = categoryMap[category] !== undefined ? categoryMap[category] : 0
  }
  
  const categoryId = Number(category) || 0
  
  filterOptions.value = {
    ...options,
    category: categoryId
  }
  
  // 如果分类改变了，重新加载商品
  await loadProducts(categoryId, true)
  
  console.log('handleFilter 更新筛选条件:', filterOptions.value)
}

// 处理轮播图点击
const handleBannerClick = (slide) => {
  if (slide.link) {
    router.push(slide.link)
  } else if (slide.productId) {
    router.push(`/product/${slide.productId}`)
  }
}

// 处理分类点击
const handleCategoryClick = async (category) => {
  console.log('处理分类点击:', category)
  // 确保 category.id 是数字类型
  const categoryId = Number(category.id) || 0
  console.log('设置分类ID:', categoryId)
  
  // 更新筛选条件
  filterOptions.value = {
    ...filterOptions.value,
    category: categoryId
  }
  
  // 调用后端接口加载该分类的商品
  await loadProducts(categoryId, true)
  
  // 平滑滚动到商品区域
  setTimeout(() => {
    const section = document.getElementById('products')
    if (section) {
      section.scrollIntoView({ 
        behavior: 'smooth',
        block: 'start'
      })
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
    const rawUserId = localStorage.getItem('userId') || '1'
    const userId = Number(rawUserId)
    const { addToCart } = await import('@/api/cart.js')
    const response = await addToCart(userId, product.id, 1)

    if (response && response.code === 200) {
      // 如果后端返回 cartCount，保存以便页面显示
      const cartCount = response.data?.cartCount
      if (cartCount != null) {
        localStorage.setItem('cartCount', String(cartCount))
      }
      // 通知同页其他组件（例如购物车页面）刷新
      try {
        window.dispatchEvent(new Event('cart-updated'))
      } catch (e) {}

      // 触发刷新并提示（不做跳转）
      alert(`已将 ${product.name} 添加到购物车`)
    } else {
      console.error('添加到购物车失败:', response)
      alert('添加到购物车失败: ' + (response?.message || '未知错误'))
    }
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
  // 加载商品数据（默认加载全部商品）
  loadProducts(0)
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
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  font-size: 16px;
  color: #6b7280;
}

.loading-spinner .spinner-circle {
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
