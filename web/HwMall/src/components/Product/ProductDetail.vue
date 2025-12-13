<template>
  <div class="product-detail">
    <div class="detail-left">
      <img v-if="product.image || product.image_url" :src="product.image || product.image_url" alt="商品图片" />
      <div v-else class="image-placeholder">暂无图片</div>
    </div>
    <div class="detail-right">
      <h2 class="title">{{ product.name }}</h2>
      <div class="price">￥{{ (product.price || 0).toFixed(2) }}</div>
      <div class="desc">{{ product.description || product.detail || '暂无描述' }}</div>

      <div class="actions">
        <button class="btn btn-primary" @click="addToCart">加入购物车</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { toRefs } from 'vue'
import { useRouter } from 'vue-router'
import { addToCart as apiAddToCart } from '@/api/cart.js'

const props = defineProps({
  product: {
    type: Object,
    default: () => ({})
  }
})

const { product: prod } = toRefs(props)
const router = useRouter()

const handleAddToCart = async () => {
  try {
    const rawUserId = localStorage.getItem('userId') || '1'
    const userId = Number(rawUserId)
    const response = await apiAddToCart(userId, prod.value.product_id || prod.value.id, 1)
    if (response && response.code === 200) {
      const cartCount = response.data?.cartCount
      if (cartCount != null) localStorage.setItem('cartCount', String(cartCount))
      try { window.dispatchEvent(new Event('cart-updated')) } catch (e) {}
      alert('已加入购物车')
    } else {
      alert('加入购物车失败: ' + (response?.message || '未知错误'))
    }
  } catch (err) {
    console.error('加入购物车错误', err)
    alert('加入购物车失败')
  }
}
</script>

<style scoped>
.product-detail {
  display: flex;
  gap: 24px;
  padding: 24px;
}
.detail-left img {
  width: 420px;
  height: 420px;
  object-fit: cover;
  border-radius: 8px;
}
.image-placeholder {
  width: 420px;
  height: 420px;
  background: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #6b7280;
  border-radius: 8px;
}
.detail-right {
  flex: 1;
}
.title { font-size: 24px; margin-bottom: 12px; }
.price { font-size: 20px; color: #ef4444; margin-bottom: 12px; }
.desc { margin-bottom: 16px; color: #374151 }
.actions { margin-top: 20px }
.btn { padding: 10px 18px; border-radius: 6px }
.btn-primary { background: #2563eb; color: white; border: none }
</style>