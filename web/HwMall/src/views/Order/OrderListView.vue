<template>
  <div class="order-list-view">
    <Navbar />
    <div class="order-list-header">
      <h1 class="page-title">我的订单</h1>
    </div>

    <div class="order-list-content">
      <OrderList
        v-if="!loading"
        :orders="orders"
        @view-detail="handleViewDetail"
        @go-shopping="goShopping"
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
import { useRouter } from 'vue-router'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
import OrderList from '@/components/Order/OrderList.vue'
import { getOrderList } from '@/api/order.js'

const router = useRouter()
const orders = ref([])
const loading = ref(false)

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

const loadOrderList = async () => {
  loading.value = true
  try {
    const userId = getUserId()
    if (!userId) {
      alert('请先登录')
      router.push('/login')
      return
    }

    const response = await getOrderList(userId)
    if (response && response.code === 200) {
      // 处理返回的数据
      let orderList = []
      if (Array.isArray(response.data)) {
        orderList = response.data
      } else if (response.data && Array.isArray(response.data.orders)) {
        orderList = response.data.orders
      }

      // 规范化订单数据
      orders.value = orderList.map(order => ({
        orderId: order.orderId || order.order_id || order.id,
        userId: order.userId || order.user_id,
        orderDate: order.orderDate || order.order_date || order.createTime || order.create_time,
        totalAmount: Number(order.totalAmount || order.total_amount || 0),
        status: order.status || '待支付',
        address: order.address || '',
        orderItems: order.orderItems || order.order_items || []
      }))
    } else {
      console.error('获取订单列表失败:', response?.message)
      if (response?.code !== 200) {
        alert('获取订单列表失败: ' + (response?.message || '未知错误'))
      }
    }
  } catch (error) {
    console.error('获取订单列表错误:', error)
    alert('获取订单列表失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

const handleViewDetail = (orderId) => {
  router.push(`/order/${orderId}`)
}

const goShopping = () => {
  router.push('/home')
}

onMounted(() => {
  loadOrderList()
})
</script>

<style scoped>
.order-list-view {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.order-list-header {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.order-list-content {
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

