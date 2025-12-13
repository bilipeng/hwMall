<template>
  <div class="order-detail-container" v-if="order">
    <div class="order-detail-header">
      <h2 class="detail-title">订单详情</h2>
      <div class="order-status-badge" :class="getStatusClass(order.status)">
        {{ order.status }}
      </div>
    </div>

    <div class="order-detail-content">
      <!-- 订单基本信息 -->
      <div class="detail-section">
        <h3 class="section-title">订单信息</h3>
        <div class="info-grid">
          <div class="info-item">
            <span class="info-label">订单号：</span>
            <span class="info-value">{{ order.orderId }}</span>
          </div>
          <div class="info-item">
            <span class="info-label">下单时间：</span>
            <span class="info-value">{{ formatDate(order.orderDate) }}</span>
          </div>
          <div class="info-item">
            <span class="info-label">订单状态：</span>
            <span class="info-value">{{ order.status }}</span>
          </div>
          <div class="info-item">
            <span class="info-label">订单总额：</span>
            <span class="info-value total-price">￥{{ order.totalAmount.toFixed(2) }}</span>
          </div>
        </div>
      </div>

      <!-- 收货地址 -->
      <div class="detail-section">
        <h3 class="section-title">收货信息</h3>
        <div class="address-box">
          <div class="address-content">{{ order.address }}</div>
        </div>
      </div>

      <!-- 商品列表 -->
      <div class="detail-section">
        <h3 class="section-title">商品清单</h3>
        <div class="products-list">
          <div 
            class="product-detail-item" 
            v-for="item in order.orderItems" 
            :key="item.orderProductId"
          >
            <img 
              :src="item.productImage || '/placeholder.png'" 
              :alt="item.productName"
              class="product-detail-image"
              @error="handleImageError"
            />
            <div class="product-detail-info">
              <div class="product-detail-name">{{ item.productName }}</div>
              <div class="product-detail-spec">
                <span>商品ID：{{ item.productId }}</span>
                <span>单价：￥{{ item.price.toFixed(2) }}</span>
                <span>数量：{{ item.quantity }}</span>
              </div>
            </div>
            <div class="product-detail-total">
              <div class="subtotal-label">小计</div>
              <div class="subtotal-amount">￥{{ item.totalPrice.toFixed(2) }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 订单金额明细 -->
      <div class="detail-section">
        <h3 class="section-title">金额明细</h3>
        <div class="amount-detail">
          <div class="amount-row">
            <span>商品总价：</span>
            <span>￥{{ order.totalAmount.toFixed(2) }}</span>
          </div>
          <div class="amount-row total-row">
            <span>实付金额：</span>
            <span class="final-amount">￥{{ order.totalAmount.toFixed(2) }}</span>
          </div>
        </div>
      </div>
    </div>

    <div class="order-detail-footer">
      <button class="btn btn-secondary" @click="$emit('go-back')">返回订单列表</button>
    </div>
  </div>

  <div v-else class="loading-container">
    <div class="loading-text">加载中...</div>
  </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue'

const props = defineProps({
  order: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['go-back'])

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return d.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

const getStatusClass = (status) => {
  const statusMap = {
    '待支付': 'status-pending',
    '已支付': 'status-paid',
    '已发货': 'status-shipped',
    '已完成': 'status-completed',
    '已取消': 'status-cancelled'
  }
  return statusMap[status] || 'status-default'
}

const handleImageError = (event) => {
  event.target.src = '/placeholder.png'
}
</script>

<style scoped>
.order-detail-container {
  background-color: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.order-detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 20px;
  border-bottom: 2px solid #e5e7eb;
  margin-bottom: 24px;
}

.detail-title {
  font-size: 24px;
  font-weight: 600;
  color: #111827;
}

.order-status-badge {
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
}

.status-pending {
  background-color: #fef3c7;
  color: #92400e;
}

.status-paid {
  background-color: #dbeafe;
  color: #1e40af;
}

.status-shipped {
  background-color: #e0e7ff;
  color: #3730a3;
}

.status-completed {
  background-color: #d1fae5;
  color: #065f46;
}

.status-cancelled {
  background-color: #fee2e2;
  color: #991b1b;
}

.order-detail-content {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.detail-section {
  padding: 20px;
  background-color: #f9fafb;
  border-radius: 8px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #111827;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #e5e7eb;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.info-item {
  display: flex;
  gap: 8px;
}

.info-label {
  color: #6b7280;
  font-size: 14px;
}

.info-value {
  color: #111827;
  font-size: 14px;
  font-weight: 500;
}

.total-price {
  color: #ef4444;
  font-size: 18px;
  font-weight: 600;
}

.address-box {
  padding: 16px;
  background-color: #fff;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
}

.address-content {
  color: #111827;
  font-size: 14px;
  line-height: 1.6;
}

.products-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.product-detail-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #fff;
  border-radius: 6px;
  border: 1px solid #e5e7eb;
}

.product-detail-image {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 6px;
  background-color: #f3f4f6;
}

.product-detail-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.product-detail-name {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
}

.product-detail-spec {
  display: flex;
  gap: 16px;
  font-size: 14px;
  color: #6b7280;
}

.product-detail-total {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 4px;
  min-width: 120px;
}

.subtotal-label {
  font-size: 12px;
  color: #6b7280;
}

.subtotal-amount {
  font-size: 18px;
  font-weight: 600;
  color: #ef4444;
}

.amount-detail {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 16px;
  background-color: #fff;
  border-radius: 6px;
}

.amount-row {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #6b7280;
}

.total-row {
  margin-top: 8px;
  padding-top: 12px;
  border-top: 2px solid #e5e7eb;
  font-size: 18px;
  font-weight: 600;
  color: #111827;
}

.final-amount {
  color: #ef4444;
  font-size: 24px;
}

.order-detail-footer {
  display: flex;
  justify-content: flex-end;
  padding-top: 24px;
  margin-top: 24px;
  border-top: 1px solid #e5e7eb;
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

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
  background-color: #fff;
  border-radius: 8px;
}

.loading-text {
  font-size: 16px;
  color: #6b7280;
}

@media (max-width: 768px) {
  .info-grid {
    grid-template-columns: 1fr;
  }

  .product-detail-item {
    flex-wrap: wrap;
  }

  .product-detail-image {
    width: 80px;
    height: 80px;
  }
}
</style>

