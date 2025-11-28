<template>
  <section class="category-nav">
    <div class="category-container">
      <div
        v-for="category in categories"
        :key="category.id"
        class="category-item"
        @click="handleCategoryClick(category)"
      >
        <div class="category-icon">{{ category.icon }}</div>
        <div class="category-name">{{ category.name }}</div>
      </div>
    </div>
  </section>
</template>

<script setup>
const emit = defineEmits(['category-click'])

const categories = [
  { id: 'digital', name: '数码电子', icon: '📱' },
  { id: 'home', name: '家居生活', icon: '🏠' },
  { id: 'clothes', name: '服饰鞋包', icon: '👔' },
  { id: 'food', name: '美食零食', icon: '🍔' },
  { id: 'sports', name: '运动户外', icon: '⚽' },
  { id: 'beauty', name: '美妆护肤', icon: '💄' },
  { id: 'books', name: '图书文具', icon: '📚' },
  { id: 'toys', name: '玩具乐器', icon: '🎮' }
]

const handleCategoryClick = (category) => {
  emit('category-click', category)
}
</script>

<style scoped>
.category-nav {
  background-color: #fff;
  padding: 24px 0;
  border-bottom: 1px solid #e5e7eb;
}

.category-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
  display: grid;
  grid-template-columns: repeat(8, 1fr);
  gap: 16px;
}

.category-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 16px 8px;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s ease, transform 0.2s ease;
}

.category-item:hover {
  background-color: #f3f4f6;
  transform: translateY(-2px);
}

.category-icon {
  font-size: 32px;
  margin-bottom: 4px;
}

.category-name {
  font-size: 14px;
  color: #374151;
  font-weight: 500;
}

@media (max-width: 1024px) {
  .category-container {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (max-width: 640px) {
  .category-container {
    grid-template-columns: repeat(4, 1fr);
    gap: 8px;
  }

  .category-icon {
    font-size: 24px;
  }

  .category-name {
    font-size: 12px;
  }
}
</style>

