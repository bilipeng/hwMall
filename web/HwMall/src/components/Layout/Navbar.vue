<template>
  <header class="navbar">
    <div class="navbar-inner">
      <router-link to="/" class="logo">简易商城系统</router-link>
      <nav class="nav-links">
        <router-link to="/" class="nav-link">首页</router-link>
        <a href="#products" class="nav-link" @click="scrollToProducts">商品展示</a>
        <router-link to="/cart" class="nav-link">购物车</router-link>
        <router-link to="/order" class="nav-link">订单管理</router-link>
        <router-link to="/user" class="nav-link">个人中心</router-link>
        <router-link to="/user/login" class="nav-link nav-link-primary">登录 / 注册</router-link>
      </nav>
    </div>
  </header>
</template>

<script setup>
const scrollToProducts = () => {
  const section = document.getElementById('products')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}
</script>

<style scoped>
.navbar {
  position: sticky;
  top: 0;
  z-index: 100;
  background-color: #1f2933;
  color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.navbar-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
}

.logo {
  font-size: 20px;
  font-weight: 600;
  letter-spacing: 0.5px;
  white-space: nowrap;
  color: #fff;
}

.nav-links {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  font-size: 14px;
}

.nav-link {
  padding: 4px 8px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease;
  color: #fff;
}

.nav-link:hover {
  background-color: #e5e7eb;
  color: #111827;
}

.nav-link-primary {
  background-color: #2563eb;
  color: #fff;
}

.nav-link-primary:hover {
  background-color: #1d4ed8;
  color: #fff;
}

@media (max-width: 720px) {
  .navbar-inner {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>

