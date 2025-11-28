<template>
  <section class="search-filter">
    <div class="search-box">
      <SearchBox @search="handleSearch" />
    </div>
    <div class="filter-group">
      <select v-model="selectedCategory" class="filter-select" @change="handleFilter">
        <option value="">全部分类</option>
        <option v-for="cat in categories" :key="cat.value" :value="cat.value">
          {{ cat.label }}
        </option>
      </select>
      <div class="price-range">
        <input
          type="number"
          v-model.number="minPrice"
          class="price-input"
          placeholder="最低价"
          min="0"
          @input="handleFilter"
        />
        <span>-</span>
        <input
          type="number"
          v-model.number="maxPrice"
          class="price-input"
          placeholder="最高价"
          min="0"
          @input="handleFilter"
        />
      </div>
      <button class="btn btn-outline btn-sm" @click="handleFilter">筛选</button>
      <button class="btn btn-outline btn-sm" @click="handleReset">重置</button>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import SearchBox from './SearchBox.vue'

const emit = defineEmits(['search', 'filter'])

const categories = [
  { value: 'digital', label: '数码电子' },
  { value: 'home', label: '家居生活' },
  { value: 'clothes', label: '服饰鞋包' },
  { value: 'food', label: '美食零食' }
]

const selectedCategory = ref('')
const minPrice = ref(null)
const maxPrice = ref(null)

const handleSearch = (keyword) => {
  emit('search', keyword)
}

const handleFilter = () => {
  emit('filter', {
    category: selectedCategory.value,
    minPrice: minPrice.value,
    maxPrice: maxPrice.value
  })
}

const handleReset = () => {
  selectedCategory.value = ''
  minPrice.value = null
  maxPrice.value = null
  handleFilter()
}
</script>

<style scoped>
.search-filter {
  background-color: #fff;
  padding: 14px 16px 12px;
  border-radius: 10px;
  box-shadow: 0 1px 2px rgba(15, 23, 42, 0.08);
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  align-items: center;
  margin-bottom: 18px;
}

.search-box {
  flex: 1 1 220px;
}

.filter-group {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  font-size: 13px;
  align-items: center;
}

.filter-select,
.price-input {
  padding: 4px 8px;
  border-radius: 6px;
  border: 1px solid #d1d5db;
  font-size: 13px;
}

.price-range {
  display: flex;
  align-items: center;
  gap: 4px;
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

.btn-outline {
  background-color: #fff;
  border: 1px solid #d1d5db;
  color: #374151;
}

.btn-outline:hover {
  background-color: #f3f4f6;
}
</style>

