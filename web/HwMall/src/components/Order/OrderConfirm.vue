<template>
  <div class="order-confirm-container">
    <!-- 收货地址选择 -->
    <div class="confirm-section">
      <h3 class="section-title">选择收货地址</h3>
      <div class="address-list" v-if="addresses.length > 0">
        <div 
          class="address-item"
          v-for="address in addresses"
          :key="address.id"
          :class="{ 'selected': selectedAddressId === address.id }"
          @click="selectAddress(address)"
        >
          <div class="address-radio">
            <input 
              type="radio" 
              :id="'address-' + address.id"
              :value="address.id"
              v-model="selectedAddressId"
            />
            <label :for="'address-' + address.id"></label>
          </div>
          <div class="address-content">
            <div class="address-name-phone">
              <span class="address-name">{{ address.name }}</span>
              <span class="address-phone">{{ address.tel }}</span>
            </div>
            <div class="address-detail">{{ address.address }}</div>
          </div>
          <button class="btn-edit" @click.stop="editAddress(address)">编辑</button>
        </div>
      </div>
      <div v-else class="no-address">
        <p>暂无收货地址，请先添加</p>
        <button class="btn btn-primary" @click="$emit('add-address')">添加地址</button>
      </div>
    </div>

    <!-- 商品信息 -->
    <div class="confirm-section">
      <h3 class="section-title">商品信息</h3>
      <div class="products-list">
        <div 
          class="product-confirm-item" 
          v-for="item in items" 
          :key="item.productId"
        >
          <img 
            :src="item.productImage || '/placeholder.png'" 
            :alt="item.productName"
            class="product-confirm-image"
            @error="handleImageError"
          />
          <div class="product-confirm-info">
            <div class="product-confirm-name">{{ item.productName }}</div>
            <div class="product-confirm-spec">
              <span>单价：￥{{ item.price.toFixed(2) }}</span>
              <span>数量：{{ item.quantity }}</span>
            </div>
          </div>
          <div class="product-confirm-total">
            ￥{{ (item.price * item.quantity).toFixed(2) }}
          </div>
        </div>
      </div>
    </div>

    <!-- 订单金额 -->
    <div class="confirm-section">
      <h3 class="section-title">订单金额</h3>
      <div class="amount-summary">
        <div class="amount-row">
          <span>商品总价：</span>
          <span>￥{{ totalAmount.toFixed(2) }}</span>
        </div>
        <div class="amount-row total-row">
          <span>实付金额：</span>
          <span class="final-amount">￥{{ totalAmount.toFixed(2) }}</span>
        </div>
      </div>
    </div>

    <!-- 提交按钮 -->
    <div class="confirm-footer">
      <button 
        class="btn btn-primary btn-submit" 
        @click="handleSubmit"
        :disabled="!canSubmit || submitting"
      >
        {{ submitting ? '提交中...' : '提交订单' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  items: {
    type: Array,
    required: true
  },
  addresses: {
    type: Array,
    default: () => []
  },
  submitting: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['submit', 'add-address', 'edit-address'])

const selectedAddressId = ref(null)

const totalAmount = computed(() => {
  return props.items.reduce((sum, item) => {
    return sum + (item.price * item.quantity)
  }, 0)
})

const canSubmit = computed(() => {
  return selectedAddressId.value !== null && props.items.length > 0
})

const selectAddress = (address) => {
  selectedAddressId.value = address.id
}

const editAddress = (address) => {
  emit('edit-address', address)
}

const handleSubmit = () => {
  if (!canSubmit.value) {
    alert('请选择收货地址')
    return
  }

  const selectedAddress = props.addresses.find(addr => addr.id === selectedAddressId.value)
  if (!selectedAddress) {
    alert('请选择有效的收货地址')
    return
  }

  emit('submit', {
    receiverName: selectedAddress.name,
    receiverPhone: selectedAddress.tel,
    receiverAddress: selectedAddress.address,
    items: props.items.map(item => ({
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      price: item.price,
      quantity: item.quantity
    }))
  })
}

const handleImageError = (event) => {
  event.target.src = '/placeholder.png'
}
</script>

<style scoped>
.order-confirm-container {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.confirm-section {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #111827;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #e5e7eb;
}

.address-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.address-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.15s ease;
}

.address-item:hover {
  border-color: #2563eb;
}

.address-item.selected {
  border-color: #2563eb;
  background-color: #eff6ff;
}

.address-radio {
  display: flex;
  align-items: center;
}

.address-radio input[type="radio"] {
  width: 20px;
  height: 20px;
  cursor: pointer;
}

.address-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.address-name-phone {
  display: flex;
  gap: 16px;
  align-items: center;
}

.address-name {
  font-weight: 600;
  color: #111827;
  font-size: 16px;
}

.address-phone {
  color: #6b7280;
  font-size: 14px;
}

.address-detail {
  color: #6b7280;
  font-size: 14px;
  line-height: 1.5;
}

.btn-edit {
  padding: 6px 12px;
  background-color: #fff;
  color: #2563eb;
  border: 1px solid #2563eb;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.15s ease;
}

.btn-edit:hover {
  background-color: #2563eb;
  color: #fff;
}

.no-address {
  text-align: center;
  padding: 40px;
  color: #6b7280;
}

.products-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.product-confirm-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #f9fafb;
  border-radius: 6px;
}

.product-confirm-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
  background-color: #fff;
}

.product-confirm-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.product-confirm-name {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
}

.product-confirm-spec {
  display: flex;
  gap: 16px;
  font-size: 14px;
  color: #6b7280;
}

.product-confirm-total {
  font-size: 18px;
  font-weight: 600;
  color: #ef4444;
  min-width: 100px;
  text-align: right;
}

.amount-summary {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 16px;
  background-color: #f9fafb;
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

.confirm-footer {
  display: flex;
  justify-content: flex-end;
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn {
  padding: 12px 24px;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s ease;
  border: none;
}

.btn-primary {
  background-color: #2563eb;
  color: #fff;
}

.btn-primary:hover:not(:disabled) {
  background-color: #1d4ed8;
}

.btn-primary:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-submit {
  padding: 14px 48px;
  font-size: 18px;
  font-weight: 600;
}

@media (max-width: 768px) {
  .address-item {
    flex-wrap: wrap;
  }

  .product-confirm-item {
    flex-wrap: wrap;
  }

  .product-confirm-image {
    width: 60px;
    height: 60px;
  }
}
</style>

