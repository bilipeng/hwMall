<template>
  <div class="order-item">
    <div class="order-item-header">
      <div class="order-info">
        <span class="order-id">订单号：{{ order.orderId }}</span>
        <span class="order-date">{{ formatDate(order.orderDate) }}</span>
      </div>
      <div class="order-status" :class="getStatusClass(order.status)">
        {{ order.status }}
      </div>
    </div>

    <div class="order-item-content">
      <div class="order-products">
        <div 
          class="product-item" 
          v-for="item in order.orderItems" 
          :key="item.orderProductId"
        >
          <img 
            :src="item.productImage || '/placeholder.png'" 
            :alt="item.productName"
            class="product-image"
            @error="handleImageError"
          />
          <div class="product-info">
            <div class="product-name">{{ item.productName }}</div>
            <div class="product-spec">
              <span>单价：￥{{ item.price.toFixed(2) }}</span>
              <span>数量：{{ item.quantity }}</span>
            </div>
          </div>
          <div class="product-total">
            ￥{{ item.totalPrice.toFixed(2) }}
          </div>
        </div>
      </div>

      <div class="order-summary">
        <div class="summary-row">
          <span>收货地址：</span>
          <span class="address-text">{{ order.address }}</span>
        </div>
        <div class="summary-row total-row">
          <span>订单总额：</span>
          <span class="total-amount">￥{{ order.totalAmount.toFixed(2) }}</span>
        </div>
      </div>
    </div>

    <div class="order-item-footer">
      <button class="btn btn-secondary" @click="$emit('view-detail', order.orderId)">
        查看详情
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  order: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['view-detail'])

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  return d.toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
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
.order-item {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 16px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.order-item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 16px;
  border-bottom: 1px solid #e5e7eb;
  margin-bottom: 16px;
}

.order-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.order-id {
  font-weight: 600;
  color: #111827;
  font-size: 16px;
}

.order-date {
  font-size: 14px;
  color: #6b7280;
}

.order-status {
  padding: 6px 12px;
  border-radius: 4px;
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

.order-item-content {
  margin-bottom: 16px;
}

.order-products {
  margin-bottom: 16px;
}

.product-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 12px 0;
  border-bottom: 1px solid #f3f4f6;
}

.product-item:last-child {
  border-bottom: none;
}

.product-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
  background-color: #f3f4f6;
}

.product-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.product-name {
  font-size: 14px;
  color: #111827;
  font-weight: 500;
}

.product-spec {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: #6b7280;
}

.product-total {
  font-size: 16px;
  font-weight: 600;
  color: #ef4444;
  min-width: 100px;
  text-align: right;
}

.order-summary {
  padding: 16px;
  background-color: #f9fafb;
  border-radius: 6px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #6b7280;
}

.address-text {
  flex: 1;
  text-align: right;
  color: #111827;
}

.total-row {
  margin-top: 8px;
  padding-top: 8px;
  border-top: 1px solid #e5e7eb;
  font-size: 16px;
  font-weight: 600;
  color: #111827;
}

.total-amount {
  color: #ef4444;
  font-size: 20px;
}

.order-item-footer {
  display: flex;
  justify-content: flex-end;
  padding-top: 16px;
  border-top: 1px solid #e5e7eb;
}

.btn {
  padding: 8px 16px;
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

@media (max-width: 768px) {
  .product-item {
    flex-wrap: wrap;
  }

  .product-image {
    width: 60px;
    height: 60px;
  }

  .order-item-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }
}
</style>

