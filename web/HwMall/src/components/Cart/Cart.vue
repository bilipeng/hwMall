<template>
  <div class="cart-container">
    <div class="cart-header">
      <div class="cart-header-checkbox">
        <input
          type="checkbox"
          :checked="isAllSelected"
          @change="handleSelectAll"
        />
        <span>全选</span>
      </div>
      <div class="cart-header-info">商品信息</div>
      <div class="cart-header-quantity">数量</div>
      <div class="cart-header-subtotal">小计</div>
      <div class="cart-header-actions">操作</div>
    </div>

    <div class="cart-items" v-if="cartItems.length > 0">
      <CartItem
        v-for="item in cartItems"
        :key="item.cartId"
        :item="item"
        @update-quantity="handleUpdateQuantity"
        @delete="handleDelete"
        @select-change="handleSelectChange"
      />
    </div>

    <div class="cart-empty" v-else>
      <div class="empty-icon">🛒</div>
      <div class="empty-text">购物车是空的</div>
      <button class="empty-btn" @click="$emit('go-shopping')">去逛逛</button>
    </div>

    <div class="cart-footer" v-if="cartItems.length > 0">
      <div class="cart-footer-left">
        <button class="clear-btn" @click="handleClearCart">清空购物车</button>
      </div>
      <div class="cart-footer-right">
        <div class="cart-summary">
          <div class="summary-item">
            <span>已选商品：</span>
            <span class="summary-value">{{ selectedCount }} 件</span>
          </div>
          <div class="summary-item">
            <span>合计：</span>
            <span class="summary-total">￥{{ totalAmount.toFixed(2) }}</span>
          </div>
        </div>
        <button
          class="checkout-btn"
          @click="handleCheckout"
          :disabled="selectedCount === 0"
        >
          去结算
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import CartItem from './CartItem.vue'

const props = defineProps({
  cartItems: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['update-quantity', 'delete', 'clear-cart', 'checkout', 'go-shopping'])

// 为每个商品添加选中状态
const itemsWithSelection = ref(
  props.cartItems.map(item => ({
    ...item,
    selected: false
  }))
)

watch(() => props.cartItems, (newItems) => {
  itemsWithSelection.value = newItems.map(item => {
    const existing = itemsWithSelection.value.find(i => i.cartId === item.cartId)
    return {
      ...item,
      selected: existing ? existing.selected : false
    }
  })
}, { deep: true })

const isAllSelected = computed(() => {
  if (itemsWithSelection.value.length === 0) return false
  return itemsWithSelection.value.every(item => item.selected)
})

const selectedCount = computed(() => {
  return itemsWithSelection.value.filter(item => item.selected).length
})

const totalAmount = computed(() => {
  return itemsWithSelection.value
    .filter(item => item.selected)
    .reduce((sum, item) => sum + parseFloat(item.subtotal), 0)
})

const handleSelectAll = (event) => {
  itemsWithSelection.value.forEach(item => {
    item.selected = event.target.checked
  })
}

const handleSelectChange = (cartId, selected) => {
  const item = itemsWithSelection.value.find(i => i.cartId === cartId)
  if (item) {
    item.selected = selected
  }
}

const handleUpdateQuantity = (cartId, quantity) => {
  emit('update-quantity', cartId, quantity)
}

const handleDelete = (cartId) => {
  emit('delete', cartId)
}

const handleClearCart = () => {
  if (confirm('确定要清空购物车吗？')) {
    emit('clear-cart')
  }
}

const handleCheckout = () => {
  if (selectedCount.value === 0) {
    alert('请至少选择一件商品')
    return
  }
  const selectedItems = itemsWithSelection.value.filter(item => item.selected)
  emit('checkout', selectedItems)
}
</script>

<style scoped>
.cart-container {
  background-color: #f5f5f5;
  min-height: 100vh;
  padding: 20px;
}

.cart-header {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #fff;
  border-radius: 8px;
  margin-bottom: 12px;
  font-size: 14px;
  font-weight: 600;
  color: #111827;
}

.cart-header-checkbox {
  display: flex;
  align-items: center;
  gap: 8px;
  min-width: 80px;
}

.cart-header-checkbox input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
}

.cart-header-info {
  flex: 1;
}

.cart-header-quantity {
  min-width: 120px;
  text-align: center;
}

.cart-header-subtotal {
  min-width: 100px;
  text-align: right;
}

.cart-header-actions {
  min-width: 80px;
  text-align: center;
}

.cart-items {
  margin-bottom: 20px;
}

.cart-empty {
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

.cart-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.cart-footer-left {
  display: flex;
  align-items: center;
}

.clear-btn {
  padding: 8px 16px;
  border: 1px solid #d1d5db;
  background-color: #fff;
  color: #6b7280;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.15s ease;
}

.clear-btn:hover {
  border-color: #ef4444;
  color: #ef4444;
}

.cart-footer-right {
  display: flex;
  align-items: center;
  gap: 24px;
}

.cart-summary {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 8px;
}

.summary-item {
  font-size: 14px;
  color: #6b7280;
}

.summary-value {
  color: #111827;
  font-weight: 500;
}

.summary-total {
  font-size: 24px;
  font-weight: 600;
  color: #ef4444;
}

.checkout-btn {
  padding: 12px 32px;
  background-color: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.checkout-btn:hover:not(:disabled) {
  background-color: #1d4ed8;
}

.checkout-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

@media (max-width: 768px) {
  .cart-header {
    display: none;
  }

  .cart-footer {
    flex-direction: column;
    gap: 16px;
  }

  .cart-footer-right {
    width: 100%;
    justify-content: space-between;
  }
}
</style>


