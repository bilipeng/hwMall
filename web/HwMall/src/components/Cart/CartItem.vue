<template>
  <div class="cart-item">
    <div class="cart-item-checkbox">
      <input
        type="checkbox"
        :checked="item.selected || false"
        @change="handleSelectChange"
      />
    </div>
    <div class="cart-item-image">
      <img v-if="item.productImage" :src="item.productImage" alt="商品图片" class="product-image" />
      <div v-else class="image-placeholder">商品图片</div>
    </div>
    <div class="cart-item-info">
      <div class="cart-item-name">{{ item.productName }}</div>
      <div class="cart-item-price">￥{{ item.price.toFixed(2) }}</div>
    </div>
    <div class="cart-item-quantity">
      <button
        class="quantity-btn"
        @click="decreaseQuantity"
        :disabled="item.quantity <= 1"
      >
        -
      </button>
      <input
        type="number"
        class="quantity-input"
        v-model.number="localQuantity"
        @blur="handleQuantityChange"
        :min="1"
        :max="item.stock"
      />
      <button
        class="quantity-btn"
        @click="increaseQuantity"
        :disabled="item.quantity >= item.stock"
      >
        +
      </button>
    </div>
    <div class="cart-item-subtotal">
      <div class="subtotal-amount">￥{{ item.subtotal.toFixed(2) }}</div>
      <div class="subtotal-label">小计</div>
    </div>
    <div class="cart-item-actions">
      <button class="delete-btn" @click="handleDelete">删除</button>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  item: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['update-quantity', 'delete', 'select-change'])

const localQuantity = ref(props.item.quantity)

watch(() => props.item.quantity, (newVal) => {
  localQuantity.value = newVal
})

const handleQuantityChange = () => {
  if (localQuantity.value < 1) {
    localQuantity.value = 1
  } else if (localQuantity.value > props.item.stock) {
    localQuantity.value = props.item.stock
  }
  if (localQuantity.value !== props.item.quantity) {
    emit('update-quantity', props.item.cartId, localQuantity.value)
  }
}

const increaseQuantity = () => {
  if (localQuantity.value < props.item.stock) {
    localQuantity.value++
    emit('update-quantity', props.item.cartId, localQuantity.value)
  }
}

const decreaseQuantity = () => {
  if (localQuantity.value > 1) {
    localQuantity.value--
    emit('update-quantity', props.item.cartId, localQuantity.value)
  }
}

const handleDelete = () => {
  if (confirm('确定要删除这个商品吗？')) {
    emit('delete', props.item.cartId)
  }
}

const handleSelectChange = (event) => {
  emit('select-change', props.item.cartId, event.target.checked)
}
</script>

<style scoped>
.cart-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  margin-bottom: 12px;
}

.cart-item-checkbox {
  display: flex;
  align-items: center;
}

.cart-item-checkbox input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
}

.cart-item-image {
  width: 100px;
  height: 100px;
  flex-shrink: 0;
}

.image-placeholder {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #e5e7eb, #d1d5db);
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  color: #6b7280;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 6px;
}

.cart-item-info {
  flex: 1;
  min-width: 0;
}

.cart-item-name {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
  margin-bottom: 8px;
}

.cart-item-price {
  font-size: 14px;
  color: #ef4444;
  font-weight: 600;
}

.cart-item-quantity {
  display: flex;
  align-items: center;
  gap: 8px;
}

.quantity-btn {
  width: 32px;
  height: 32px;
  border: 1px solid #d1d5db;
  background-color: #fff;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.15s ease;
}

.quantity-btn:hover:not(:disabled) {
  background-color: #f3f4f6;
  border-color: #2563eb;
}

.quantity-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.quantity-input {
  width: 60px;
  height: 32px;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  text-align: center;
  font-size: 14px;
}

.quantity-input:focus {
  outline: none;
  border-color: #2563eb;
  box-shadow: 0 0 0 1px rgba(37, 99, 235, 0.25);
}

.cart-item-subtotal {
  text-align: right;
  min-width: 100px;
}

.subtotal-amount {
  font-size: 18px;
  font-weight: 600;
  color: #ef4444;
  margin-bottom: 4px;
}

.subtotal-label {
  font-size: 12px;
  color: #6b7280;
}

.cart-item-actions {
  display: flex;
  align-items: center;
}

.delete-btn {
  padding: 6px 12px;
  border: 1px solid #ef4444;
  background-color: #fff;
  color: #ef4444;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.15s ease;
}

.delete-btn:hover {
  background-color: #ef4444;
  color: #fff;
}

@media (max-width: 768px) {
  .cart-item {
    flex-wrap: wrap;
    gap: 12px;
  }

  .cart-item-info {
    flex: 1 1 100%;
  }

  .cart-item-subtotal {
    min-width: auto;
  }
}
</style>

