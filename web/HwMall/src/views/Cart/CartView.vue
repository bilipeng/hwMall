<template>
  <div class="cart-view">
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
</template>

<script setup>
import { ref, onMounted } from 'vue'
import Cart from '@/components/Cart/Cart.vue'
import {
  getCartList,
  updateCartItemQuantity,
  removeCartItem,
  clearCart
} from '@/api/cart.js'

const cartItems = ref([])
const loading = ref(false)

// 从localStorage获取用户ID（实际项目中应该从登录状态获取）
const getUserId = () => {
  // 优先从userId键获取
  const userId = localStorage.getItem('userId')
  if (userId) {
    return parseInt(userId)
  }
  
  // 其次从user键获取
  const userStr = localStorage.getItem('user')
  if (userStr) {
    const user = JSON.parse(userStr)
    return user.user_id || user.userId || 1 // 默认使用1作为测试
  }
  return 1 // 默认用户ID，实际应该要求用户登录
}

const loadCartList = async () => {
  loading.value = true
  try {
    const userId = getUserId()
    const response = await getCartList(userId)
    if (response.code === 200) {
      cartItems.value = response.data.cartItems || []
    } else {
      console.error('获取购物车列表失败:', response.message)
      alert('获取购物车列表失败: ' + response.message)
    }
  } catch (error) {
    console.error('获取购物车列表错误:', error)
    alert('获取购物车列表失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

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
    } else {
      alert('更新数量失败: ' + response.message)
      // 重新加载购物车列表
      loadCartList()
    }
  } catch (error) {
    console.error('更新数量错误:', error)
    alert('更新数量失败，请稍后重试')
    loadCartList()
  }
}

const handleDelete = async (cartId) => {
  try {
    const response = await removeCartItem(cartId)
    if (response.code === 200) {
      // 从列表中移除
      cartItems.value = cartItems.value.filter(item => item.cartId !== cartId)
      alert('删除成功')
    } else {
      alert('删除失败: ' + response.message)
    }
  } catch (error) {
    console.error('删除错误:', error)
    alert('删除失败，请稍后重试')
  }
}

const handleClearCart = async () => {
  try {
    const userId = getUserId()
    const response = await clearCart(userId)
    if (response.code === 200) {
      cartItems.value = []
      alert('清空购物车成功')
    } else {
      alert('清空购物车失败: ' + response.message)
    }
  } catch (error) {
    console.error('清空购物车错误:', error)
    alert('清空购物车失败，请稍后重试')
  }
}

const handleCheckout = (selectedItems) => {
  // 跳转到订单确认页
  // 这里可以将选中的商品信息传递给订单页面
  console.log('选中的商品:', selectedItems)
  // 实际项目中应该使用路由跳转
  // router.push({ name: 'OrderConfirm', params: { items: selectedItems } })
  alert('跳转到订单确认页（功能待实现）')
}

const goShopping = () => {
  // 跳转到商品列表页
  // router.push({ name: 'ProductList' })
  alert('跳转到商品列表页（功能待实现）')
}

onMounted(() => {
  loadCartList()
})
</script>

<style scoped>
.cart-view {
  min-height: 100vh;
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
</style>


