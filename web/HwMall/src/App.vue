<template>
  <div class="page-wrapper">
    <!-- 导航栏 -->
    <header class="navbar">
      <div class="navbar-inner">
        <div class="logo">简易商城系统</div>
        <nav class="nav-links">
          <a href="#" class="nav-link" @click.prevent="currentView = 'home'">首页</a>
          <a href="#" class="nav-link" @click.prevent="currentView = 'search'">搜索</a>
          <a href="#" class="nav-link" @click.prevent="currentView = 'cart'">
            购物车
            <span v-if="cartCount > 0" class="cart-badge">{{ cartCount }}</span>
          </a>
          <a href="#" class="nav-link nav-link-primary">登录 / 注册</a>
        </nav>
      </div>
    </header>

    <!-- 主要内容区域 -->
    <main class="main">
      <!-- 首页视图 -->
      <div v-if="currentView === 'home'" class="content-inner">
        <section class="hero">
          <div class="hero-inner">
            <div>
              <h1 class="hero-title">购物车功能测试</h1>
              <p class="hero-subtitle">
                这是一个购物车模块的测试页面。你可以添加测试商品到购物车，然后查看购物车列表。
              </p>
              <div class="hero-actions">
                <button class="btn btn-primary" @click="addTestProduct">添加测试商品</button>
                <button class="btn btn-ghost" @click="currentView = 'cart'">查看购物车</button>
              </div>
            </div>
          </div>
        </section>

        <section class="test-section">
          <div class="test-card">
            <h2 class="test-title">快速测试</h2>
            <div class="test-form">
              <div class="form-group">
                <label>用户ID：</label>
                <input type="number" v-model.number="testUserId" class="form-input" />
              </div>
              <div class="form-group">
                <label>商品ID：</label>
                <input type="number" v-model.number="testProductId" class="form-input" />
              </div>
              <div class="form-group">
                <label>数量：</label>
                <input type="number" v-model.number="testQuantity" class="form-input" min="1" />
              </div>
              <button class="btn btn-primary" @click="handleAddToCart">添加到购物车</button>
            </div>
            <div v-if="addResult" class="result-message" :class="addResult.type">
              {{ addResult.message }}
            </div>
          </div>
        </section>
      </div>

      <!-- 搜索视图 -->
      <div v-if="currentView === 'search'" class="search-view-wrapper">
        <SearchView />
      </div>

      <!-- 购物车视图 -->
      <div v-if="currentView === 'cart'" class="cart-view">
        <div class="cart-view-header">
          <h1 class="page-title">购物车</h1>
        </div>

        <div class="cart-view-content">
          <Cart
            v-if="!loading"
            :cart-items="cartItems"
            @update-quantity="handleUpdateQuantity"
            @delete="handleDelete"
            @clear-cart="handleClearCart"
            @checkout="handleCheckout"
            @go-shopping="goShopping"
          />

          <div v-if="loading" class="loading-container">
            <div class="loading-spinner">加载中...</div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import Cart from '@/components/Cart/Cart.vue'
import SearchView from '@/views/Search/SearchView.vue'
import {
  addToCart,
  getCartList,
  updateCartItemQuantity,
  removeCartItem,
  clearCart,
  getCartCount
} from '@/api/cart.js'

const currentView = ref('home')
const cartItems = ref([])
const loading = ref(false)
const cartCount = ref(0)

// 测试表单数据
const testUserId = ref(1)
const testProductId = ref(1)
const testQuantity = ref(1)
const addResult = ref(null)

// 从localStorage获取用户ID
const getUserId = () => {
  const userInfo = localStorage.getItem('userInfo')
  if (userInfo) {
    const user = JSON.parse(userInfo)
    return user.userId || user.user_id || testUserId.value
  }
  return testUserId.value
}

// 加载购物车列表
const loadCartList = async () => {
  loading.value = true
  try {
    const userId = getUserId()
    const response = await getCartList(userId)
    if (response.code === 200) {
      cartItems.value = response.data.cartItems || []
    } else {
      console.error('获取购物车列表失败:', response.message)
    }
  } catch (error) {
    console.error('获取购物车列表错误:', error)
  } finally {
    loading.value = false
  }
}

// 加载购物车数量
const loadCartCount = async () => {
  try {
    const userId = getUserId()
    const response = await getCartCount(userId)
    if (response.code === 200) {
      cartCount.value = response.data.count || 0
    }
  } catch (error) {
    console.error('获取购物车数量错误:', error)
  }
}

// 添加测试商品
const addTestProduct = async () => {
  await handleAddToCart()
}

// 添加到购物车
const handleAddToCart = async () => {
  addResult.value = null
  try {
    const response = await addToCart(testUserId.value, testProductId.value, testQuantity.value)
    if (response.code === 200) {
      addResult.value = {
        type: 'success',
        message: `添加成功！购物车商品数量：${response.data.cartCount}`
      }
      // 更新购物车数量
      await loadCartCount()
      // 如果当前在购物车页面，刷新列表
      if (currentView.value === 'cart') {
        await loadCartList()
      }
    } else {
      addResult.value = {
        type: 'error',
        message: `添加失败：${response.message}`
      }
    }
  } catch (error) {
    addResult.value = {
      type: 'error',
      message: `添加失败：${error.message || '网络错误'}`
    }
  }
}

// 更新商品数量
const handleUpdateQuantity = async (cartId, quantity) => {
  try {
    const response = await updateCartItemQuantity(cartId, quantity)
    if (response.code === 200) {
      // 更新本地数据
      const item = cartItems.value.find(item => item.cartId === cartId)
      if (item) {
        item.quantity = quantity
        item.subtotal = item.price * quantity
      }
      await loadCartCount()
    } else {
      alert('更新数量失败: ' + response.message)
      await loadCartList()
    }
  } catch (error) {
    console.error('更新数量错误:', error)
    alert('更新数量失败，请稍后重试')
    await loadCartList()
  }
}

// 删除商品
const handleDelete = async (cartId) => {
  try {
    const response = await removeCartItem(cartId)
    if (response.code === 200) {
      cartItems.value = cartItems.value.filter(item => item.cartId !== cartId)
      await loadCartCount()
      alert('删除成功')
    } else {
      alert('删除失败: ' + response.message)
    }
  } catch (error) {
    console.error('删除错误:', error)
    alert('删除失败，请稍后重试')
  }
}

// 清空购物车
const handleClearCart = async () => {
  try {
    const userId = getUserId()
    const response = await clearCart(userId)
    if (response.code === 200) {
      cartItems.value = []
      await loadCartCount()
      alert('清空购物车成功')
    } else {
      alert('清空购物车失败: ' + response.message)
    }
  } catch (error) {
    console.error('清空购物车错误:', error)
    alert('清空购物车失败，请稍后重试')
  }
}

// 去结算
const handleCheckout = (selectedItems) => {
  console.log('选中的商品:', selectedItems)
  alert(`准备结算 ${selectedItems.length} 件商品（功能待实现）`)
}

// 去逛逛
const goShopping = () => {
  currentView.value = 'home'
}

// 监听视图切换，如果是购物车页面则加载数据
watch(currentView, (newView) => {
  if (newView === 'cart') {
    loadCartList()
  }
})

// 初始化
onMounted(() => {
  loadCartCount()
})
</script>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.page-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f5f5;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif;
}

.navbar {
  position: sticky;
  top: 0;
  z-index: 100;
  background-color: #1f2933;
  color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.navbar-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
}

.logo {
  font-size: 20px;
  font-weight: 600;
  letter-spacing: 0.5px;
  white-space: nowrap;
}

.nav-links {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 16px;
  font-size: 14px;
}

.nav-link {
  padding: 4px 8px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease;
  position: relative;
}

.nav-link:hover {
  background-color: #e5e7eb;
  color: #111827;
}

.nav-link-primary {
  background-color: #2563eb;
  color: #fff;
}

.nav-link-primary:hover {
  background-color: #1d4ed8;
  color: #fff;
}

.cart-badge {
  display: inline-block;
  background-color: #ef4444;
  color: #fff;
  border-radius: 10px;
  padding: 2px 6px;
  font-size: 12px;
  margin-left: 4px;
  min-width: 18px;
  text-align: center;
}

.main {
  flex: 1;
}

.content-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px 40px;
}

.hero {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  margin: 0 -16px 20px;
  border-radius: 0;
}

.hero-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 32px 16px 28px;
}

.hero-title {
  font-size: 32px;
  line-height: 1.2;
  font-weight: 700;
  margin-bottom: 12px;
}

.hero-subtitle {
  font-size: 14px;
  line-height: 1.6;
  color: #e5e7eb;
  margin-bottom: 20px;
}

.hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  border: none;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease, box-shadow 0.15s ease;
}

.btn-primary {
  background-color: #fbbf24;
  color: #111827;
  font-weight: 600;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
}

.btn-primary:hover {
  background-color: #f59e0b;
}

.btn-ghost {
  background-color: transparent;
  border: 1px solid rgba(255, 255, 255, 0.6);
  color: #e5e7eb;
}

.btn-ghost:hover {
  background-color: rgba(15, 23, 42, 0.4);
}

.test-section {
  margin-top: 20px;
}

.test-card {
  background-color: #fff;
  border-radius: 10px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
}

.test-title {
  font-size: 20px;
  font-weight: 600;
  color: #111827;
  margin-bottom: 20px;
}

.test-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-size: 14px;
  font-weight: 500;
  color: #374151;
}

.form-input {
  padding: 8px 12px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.15s ease, box-shadow 0.15s ease;
}

.form-input:focus {
  outline: none;
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.result-message {
  margin-top: 16px;
  padding: 12px 16px;
  border-radius: 6px;
  font-size: 14px;
}

.result-message.success {
  background-color: #ecfdf5;
  color: #166534;
  border: 1px solid #bbf7d0;
}

.result-message.error {
  background-color: #fef2f2;
  color: #991b1b;
  border: 1px solid #fecaca;
}

.cart-view {
  min-height: calc(100vh - 60px);
  background-color: #f5f5f5;
}

.cart-view-header {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.cart-view-content {
  max-width: 1120px;
  margin: 0 auto;
  padding: 0 16px 40px;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
  background-color: #fff;
  border-radius: 8px;
}

.loading-spinner {
  font-size: 16px;
  color: #6b7280;
}

@media (max-width: 768px) {
  .hero-title {
    font-size: 24px;
  }

  .navbar-inner {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
