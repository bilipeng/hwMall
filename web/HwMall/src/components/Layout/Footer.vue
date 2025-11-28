<template>
  <footer class="footer">
    <div class="footer-inner">
      <div>© 2025 简易商城系统 · 课程设计示例首页</div>
      <div>前端：Vue 3 + TypeScript + Vite · 后端：Spring Boot + MyBatis</div>
    </div>
  </footer>
</template>

<script setup>
// Footer 组件无需逻辑
</script>

<style scoped>
.footer {
  border-top: 1px solid #e5e7eb;
  background-color: #f9fafb;
  margin-top: auto;
}

.footer-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 12px 16px 18px;
  font-size: 12px;
  color: #6b7280;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  gap: 8px;
}
</style>

