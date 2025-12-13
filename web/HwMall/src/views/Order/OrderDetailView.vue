<template>
  <div class="order-detail-view">
    <Navbar />
    <div class="order-detail-content-wrapper">
      <OrderDetail
        v-if="!loading && order"
        :order="order"
        @go-back="handleGoBack"
      />

      <div v-if="loading" class="loading-container">
        <div class="loading-spinner">加载中...</div>
      </div>

      <div v-if="!loading && !order" class="error-container">
        <div class="error-icon">❌</div>
        <div class="error-text">订单不存在</div>
        <button class="btn btn-secondary" @click="handleGoBack">返回订单列表</button>
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
import OrderDetail from '@/components/Order/OrderDetail.vue'
import { getOrderDetail } from '@/api/order.js'

const router = useRouter()
const route = useRoute()
const order = ref(null)
const loading = ref(false)

const loadOrderDetail = async () => {
  loading.value = true
  try {
    const orderId = route.params.id || route.params.orderId
    if (!orderId) {
      alert('订单ID不能为空')
      router.push('/order')
      return
    }

    const response = await getOrderDetail(orderId)
    if (response && response.code === 200) {
      const orderData = response.data
      // 规范化订单数据
      order.value = {
        orderId: orderData.orderId || orderData.order_id || orderData.id,
        userId: orderData.userId || orderData.user_id,
        orderDate: orderData.orderDate || orderData.order_date || orderData.createTime || orderData.create_time,
        totalAmount: Number(orderData.totalAmount || orderData.total_amount || 0),
        status: orderData.status || '待支付',
        address: orderData.address || '',
        orderItems: (orderData.orderItems || orderData.order_items || []).map(item => ({
          orderProductId: item.orderProductId || item.order_product_id || item.id,
          orderId: item.orderId || item.order_id,
          productId: item.productId || item.product_id,
          productName: item.productName || item.product_name || '',
          productImage: item.productImage || item.product_image || '',
          price: Number(item.price || 0),
          quantity: Number(item.quantity || 0),
          totalPrice: Number(item.totalPrice || item.total_price || (item.price || 0) * (item.quantity || 0))
        }))
      }
    } else {
      console.error('获取订单详情失败:', response?.message)
      alert('获取订单详情失败: ' + (response?.message || '未知错误'))
    }
  } catch (error) {
    console.error('获取订单详情错误:', error)
    alert('获取订单详情失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

const handleGoBack = () => {
  router.push('/order')
}

onMounted(() => {
  loadOrderDetail()
})
</script>

<style scoped>
.order-detail-view {
  min-height: 100vh;
  background-color: #f5f5f5;
}

.order-detail-content-wrapper {
  max-width: 1120px;
  margin: 0 auto;
  padding: 20px 16px 40px;
}

.loading-container,
.error-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 400px;
  background-color: #fff;
  border-radius: 8px;
  gap: 16px;
}

.loading-spinner {
  font-size: 16px;
  color: #6b7280;
}

.error-icon {
  font-size: 48px;
}

.error-text {
  font-size: 18px;
  color: #6b7280;
}

.btn {
  padding: 12px 24px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s ease;
}

.btn-secondary {
  background-color: #fff;
  color: #2563eb;
  border: 1px solid #2563eb;
}

.btn-secondary:hover {
  background-color: #2563eb;
  color: #fff;
}
</style>

