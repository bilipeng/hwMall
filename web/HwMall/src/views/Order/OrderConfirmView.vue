<template>
  <div class="order-confirm-view">
    <Navbar />
    <div class="order-confirm-header">
      <h1 class="page-title">确认订单</h1>
    </div>

    <div class="order-confirm-content">
      <OrderConfirm
        v-if="!loading"
        :items="cartItems"
        :addresses="addresses"
        :submitting="submitting"
        @submit="handleSubmit"
        @add-address="handleAddAddress"
        @edit-address="handleEditAddress"
      />

      <div v-if="loading" class="loading-container">
        <div class="loading-spinner">加载中...</div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
import OrderConfirm from '@/components/Order/OrderConfirm.vue'
import { createOrder } from '@/api/order.js'
import { getAddresses } from '@/api/user.js'

const router = useRouter()
const route = useRoute()
const cartItems = ref([])
const addresses = ref([])
const loading = ref(false)
const submitting = ref(false)

// 从localStorage获取用户ID
const getUserId = () => {
  const userId = localStorage.getItem('userId')
  if (userId) {
    return parseInt(userId)
  }
  
  const userStr = localStorage.getItem('user')
  if (userStr) {
    try {
      const user = JSON.parse(userStr)
      const id = user.user_id || user.userId || user.id
      if (id) {
        localStorage.setItem('userId', id.toString())
        return parseInt(id)
      }
    } catch (error) {
      console.error('解析用户信息失败:', error)
    }
  }
  
  return null
}

// 加载购物车商品（从路由参数或localStorage获取）
const loadCartItems = () => {
  // 尝试从路由参数获取
  if (route.params.items) {
    try {
      cartItems.value = JSON.parse(decodeURIComponent(route.params.items))
      return
    } catch (error) {
      console.error('解析路由参数失败:', error)
    }
  }

  // 尝试从localStorage获取
  const savedItems = localStorage.getItem('checkoutItems')
  if (savedItems) {
    try {
      cartItems.value = JSON.parse(savedItems)
      return
    } catch (error) {
      console.error('解析localStorage数据失败:', error)
    }
  }

  // 如果没有数据，提示用户
  if (cartItems.value.length === 0) {
    alert('没有要结算的商品，请先选择商品')
    router.push('/cart')
  }
}

// 加载收货地址
const loadAddresses = async () => {
  const userId = getUserId()
  if (!userId) {
    alert('请先登录')
    router.push('/login')
    return
  }

  try {
    const response = await getAddresses(userId)
    if (response && response.code === 200) {
      const list = Array.isArray(response.data) ? response.data : []
      addresses.value = list.map(item => ({
        id: item.id || item.address_id,
        name: item.name,
        tel: item.tel,
        address: item.address
      }))
    }
  } catch (error) {
    console.error('获取地址列表失败:', error)
  }
}

// 提交订单
const handleSubmit = async (orderData) => {
  const userId = getUserId()
  if (!userId) {
    alert('请先登录')
    router.push('/login')
    return
  }

  submitting.value = true
  try {
    const response = await createOrder(userId, orderData)
    if (response && response.code === 200) {
      alert('订单创建成功！')
      // 清除购物车中的已下单商品（这里可以调用清空购物车API）
      localStorage.removeItem('checkoutItems')
      // 跳转到订单列表
      router.push('/order')
    } else {
      alert('订单创建失败: ' + (response?.message || '未知错误'))
    }
  } catch (error) {
    console.error('创建订单错误:', error)
    alert('订单创建失败，请稍后重试')
  } finally {
    submitting.value = false
  }
}

const handleAddAddress = () => {
  router.push('/profile')
}

const handleEditAddress = (address) => {
  router.push('/profile')
}

onMounted(() => {
  loading.value = true
  loadCartItems()
  loadAddresses().finally(() => {
    loading.value = false
  })
})
</script>

<style scoped>
.order-confirm-view {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.order-confirm-header {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.order-confirm-content {
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
</style>

