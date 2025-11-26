<template>
  <div class="search-result">
    <!-- 搜索结果头部 -->
    <div class="result-header">
      <div class="result-info">
        <span class="result-count">找到 <strong>{{ total }}</strong> 个商品</span>
        <span class="result-keyword" v-if="keyword">关键词：{{ keyword }}</span>
      </div>
    </div>

    <!-- 商品列表 -->
    <div v-if="products.length > 0" class="product-list">
      <div
        v-for="product in products"
        :key="product.product_id"
        class="product-card"
        @click="handleProductClick(product.product_id)"
      >
        <div class="product-image">
          <div class="image-placeholder">商品图片</div>
        </div>
        <div class="product-info">
          <div class="product-name">{{ product.name }}</div>
          <div class="product-desc">{{ product.description || '暂无描述' }}</div>
          <div class="product-meta">
            <div class="product-price">￥{{ formatPrice(product.price) }}</div>
            <div class="product-stock">库存：{{ product.stock }}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 无搜索结果 -->
    <div v-else class="no-result">
      <div class="no-result-icon">🔍</div>
      <div class="no-result-text">没有找到相关商品</div>
      <div class="no-result-tip">试试其他关键词吧</div>
    </div>

    <!-- 分页（如果有） -->
    <div v-if="total > pageSize" class="pagination">
      <button
        class="page-btn"
        :disabled="page <= 1"
        @click="handlePageChange(page - 1)"
      >
        上一页
      </button>
      <span class="page-info">
        第 {{ page }} / {{ totalPages }} 页
      </span>
      <button
        class="page-btn"
        :disabled="page >= totalPages"
        @click="handlePageChange(page + 1)"
      >
        下一页
      </button>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  products: {
    type: Array,
    default: () => []
  },
  total: {
    type: Number,
    default: 0
  },
  keyword: {
    type: String,
    default: ''
  },
  page: {
    type: Number,
    default: 1
  },
  pageSize: {
    type: Number,
    default: 10
  }
})

const emit = defineEmits(['page-change', 'product-click'])

const totalPages = computed(() => {
  return Math.ceil(props.total / props.pageSize)
})

const formatPrice = (price) => {
  if (typeof price === 'number') {
    return price.toFixed(2)
  }
  return parseFloat(price || 0).toFixed(2)
}

const handlePageChange = (newPage) => {
  emit('page-change', newPage)
}

const handleProductClick = (productId) => {
  emit('product-click', productId)
}
</script>

<style scoped>
.search-result {
  width: 100%;
}

.result-header {
  padding: 16px 0;
  border-bottom: 1px solid #e5e7eb;
  margin-bottom: 20px;
}

.result-info {
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: 14px;
  color: #6b7280;
}

.result-count {
  font-weight: 500;
}

.result-count strong {
  color: #2563eb;
  font-size: 16px;
}

.result-keyword {
  color: #111827;
}

.product-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.product-card {
  background-color: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
}

.product-image {
  width: 100%;
  height: 200px;
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
  display: flex;
  align-items: center;
  justify-content: center;
}

.image-placeholder {
  font-size: 14px;
  color: #6b7280;
}

.product-info {
  padding: 16px;
}

.product-name {
  font-size: 16px;
  font-weight: 600;
  color: #111827;
  margin-bottom: 8px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-desc {
  font-size: 13px;
  color: #6b7280;
  margin-bottom: 12px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  line-height: 1.5;
}

.product-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.product-price {
  font-size: 20px;
  font-weight: 600;
  color: #ef4444;
}

.product-stock {
  font-size: 12px;
  color: #6b7280;
}

.no-result {
  text-align: center;
  padding: 80px 20px;
}

.no-result-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.no-result-text {
  font-size: 18px;
  font-weight: 500;
  color: #111827;
  margin-bottom: 8px;
}

.no-result-tip {
  font-size: 14px;
  color: #6b7280;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 16px;
  padding: 20px 0;
}

.page-btn {
  padding: 8px 16px;
  background-color: #fff;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.15s ease;
}

.page-btn:hover:not(:disabled) {
  background-color: #f3f4f6;
  border-color: #2563eb;
}

.page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.page-info {
  font-size: 14px;
  color: #6b7280;
}

@media (max-width: 768px) {
  .product-list {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    gap: 12px;
  }
}
</style>

