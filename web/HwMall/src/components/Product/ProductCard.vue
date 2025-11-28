<template>
  <article class="product-card">
    <div class="product-image-placeholder">
      <img v-if="product.image" :src="product.image" :alt="product.name" />
      <span v-else>商品图片占位</span>
    </div>
    <div class="product-body">
      <div class="product-name">{{ product.name }}</div>
      <div class="product-desc">{{ product.description }}</div>
      <div class="product-meta">
        <div class="product-price">￥{{ formatPrice(product.price) }}</div>
        <div class="product-category">{{ product.category }}</div>
      </div>
      <div class="product-actions">
        <button class="btn btn-primary btn-sm" @click="handleAddToCart">加入购物车</button>
        <button class="btn btn-outline btn-sm" @click="handleViewDetail">查看详情</button>
      </div>
    </div>
  </article>
</template>

<script setup>
import { useRouter } from 'vue-router'

const props = defineProps({
  product: {
    type: Object,
    required: true,
    default: () => ({
      id: null,
      name: '',
      description: '',
      price: 0,
      category: '',
      image: ''
    })
  }
})

const emit = defineEmits(['add-to-cart'])

const router = useRouter()

const formatPrice = (price) => {
  return Number(price).toLocaleString('zh-CN', { minimumFractionDigits: 2, maximumFractionDigits: 2 })
}

const handleAddToCart = () => {
  emit('add-to-cart', props.product)
}

const handleViewDetail = () => {
  router.push(`/product/${props.product.id}`)
}
</script>

<style scoped>
.product-card {
  background-color: #fff;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
  display: flex;
  flex-direction: column;
  transition: transform 0.12s ease, box-shadow 0.12s ease;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 14px rgba(15, 23, 42, 0.12);
}

.product-image-placeholder {
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
  height: 150px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: #4b5563;
}

.product-image-placeholder img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-body {
  padding: 10px 12px 12px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}

.product-name {
  font-size: 14px;
  font-weight: 500;
  color: #111827;
}

.product-desc {
  font-size: 12px;
  color: #6b7280;
  height: 32px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.product-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 4px;
}

.product-price {
  font-size: 16px;
  font-weight: 600;
  color: #ef4444;
}

.product-category {
  font-size: 12px;
  color: #6b7280;
}

.product-actions {
  display: flex;
  gap: 8px;
  margin-top: 8px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 4px 8px;
  font-size: 12px;
  border-radius: 5px;
  border: none;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease;
}

.btn-sm {
  padding: 4px 8px;
  font-size: 12px;
}

.btn-primary {
  background-color: #2563eb;
  color: #fff;
  font-weight: 500;
}

.btn-primary:hover {
  background-color: #1d4ed8;
}

.btn-outline {
  background-color: #fff;
  border: 1px solid #d1d5db;
  color: #374151;
}

.btn-outline:hover {
  background-color: #f3f4f6;
}
</style>

