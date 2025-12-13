<template>
  <article class="product-card" @click="handleCardClick">
    <div class="product-image-wrapper">
      <div class="product-image-placeholder">
        <img 
          v-if="product.image && product.image.trim()" 
          :src="product.image" 
          :alt="product.name"
          @error="handleImageError"
          @load="handleImageLoad"
          loading="lazy"
        />
        <div v-else class="image-placeholder-text">
          <span>暂无图片</span>
        </div>
      </div>
      <div class="product-overlay">
        <button class="btn-overlay btn-overlay-primary" @click.stop="handleAddToCart">
          加入购物车
        </button>
        <button class="btn-overlay btn-overlay-secondary" @click.stop="handleViewDetail">
          查看详情
        </button>
      </div>
      <div v-if="product.stock <= 0" class="stock-badge out-of-stock">缺货</div>
      <div v-else-if="product.stock < 10" class="stock-badge low-stock">仅剩{{ product.stock }}件</div>
    </div>
    <div class="product-body">
      <div class="product-name" :title="product.name">{{ product.name }}</div>
      <div class="product-desc">{{ product.description || '暂无描述' }}</div>
      <div class="product-meta">
        <div class="product-price">￥{{ formatPrice(product.price) }}</div>
        <div class="product-category">{{ product.category }}</div>
      </div>
      <div class="product-actions">
        <button class="btn btn-primary btn-sm" @click.stop="handleAddToCart">加入购物车</button>
        <button class="btn btn-outline btn-sm" @click.stop="handleViewDetail">查看详情</button>
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

const handleCardClick = () => {
  // 点击卡片也可以跳转到详情页
  handleViewDetail()
}

const handleImageError = (e) => {
  // 图片加载失败时显示占位符
  console.warn('图片加载失败:', props.product.image, '商品:', props.product.name)
  e.target.style.display = 'none'
  const placeholder = e.target.nextElementSibling
  if (placeholder) {
    placeholder.style.display = 'flex'
  }
}

const handleImageLoad = (e) => {
  // 图片加载成功
  console.log('图片加载成功:', props.product.image)
}
</script>

<style scoped>
.product-card {
  background-color: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
  display: flex;
  flex-direction: column;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
  position: relative;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(15, 23, 42, 0.15);
}

.product-image-wrapper {
  position: relative;
  overflow: hidden;
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
}

.product-image-placeholder {
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: #4b5563;
  position: relative;
  overflow: hidden;
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
}

.product-image-placeholder img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card:hover .product-image-placeholder img {
  transform: scale(1.05);
}

.image-placeholder-text {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
}

.product-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.product-card:hover .product-overlay {
  opacity: 1;
}

.btn-overlay {
  padding: 8px 16px;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.btn-overlay-primary {
  background-color: #2563eb;
  color: #fff;
}

.btn-overlay-primary:hover {
  background-color: #1d4ed8;
  transform: scale(1.05);
}

.btn-overlay-secondary {
  background-color: #fff;
  color: #111827;
}

.btn-overlay-secondary:hover {
  background-color: #f3f4f6;
  transform: scale(1.05);
}

.stock-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  z-index: 2;
}

.stock-badge.out-of-stock {
  background-color: #ef4444;
  color: #fff;
}

.stock-badge.low-stock {
  background-color: #f59e0b;
  color: #fff;
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

