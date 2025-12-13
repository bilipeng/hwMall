<template>
  <div class="order-list-container">
    <div v-if="orders.length > 0" class="order-list">
      <OrderItem
        v-for="order in orders"
        :key="order.orderId"
        :order="order"
        @view-detail="handleViewDetail"
      />
    </div>

    <div v-else class="empty-orders">
      <div class="empty-icon">📦</div>
      <div class="empty-text">暂无订单</div>
      <button class="empty-btn" @click="$emit('go-shopping')">去逛逛</button>
    </div>
  </div>
</template>

<script setup>
import OrderItem from './OrderItem.vue'

const props = defineProps({
  orders: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['view-detail', 'go-shopping'])

const handleViewDetail = (orderId) => {
  emit('view-detail', orderId)
}
</script>

<style scoped>
.order-list-container {
  width: 100%;
}

.order-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.empty-orders {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 80px 20px;
  background-color: #fff;
  border-radius: 8px;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
}

.empty-text {
  font-size: 18px;
  color: #6b7280;
  margin-bottom: 24px;
}

.empty-btn {
  padding: 12px 24px;
  background-color: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.empty-btn:hover {
  background-color: #1d4ed8;
}
</style>

