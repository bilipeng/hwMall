<template>
  <div class="section-header">
    <div class="header-left">
      <h2 class="section-title">{{ title }}</h2>
      <p v-if="subtitle" class="section-subtitle">{{ subtitle }}</p>
    </div>
    <div class="header-right">
      <slot name="action">
        <router-link v-if="moreLink" :to="moreLink" class="more-link">
          查看更多 <span>→</span>
        </router-link>
      </slot>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  subtitle: {
    type: String,
    default: ''
  },
  moreLink: {
    type: String,
    default: ''
  }
})
</script>

<style scoped>
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 20px;
  padding-bottom: 12px;
  border-bottom: 2px solid #e5e7eb;
}

.header-left {
  flex: 1;
}

.section-title {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
  margin-bottom: 4px;
}

.section-subtitle {
  font-size: 14px;
  color: #6b7280;
}

.header-right {
  display: flex;
  align-items: center;
}

.more-link {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 14px;
  color: #2563eb;
  text-decoration: none;
  transition: color 0.2s ease;
}

.more-link:hover {
  color: #1d4ed8;
}

.more-link span {
  transition: transform 0.2s ease;
}

.more-link:hover span {
  transform: translateX(4px);
}

@media (max-width: 640px) {
  .section-title {
    font-size: 20px;
  }

  .section-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
  }
}
</style>

