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
        <!-- 未登录时显示登录注册按钮 -->
        <template v-if="!isLoggedIn">
          <router-link to="/login" class="nav-link nav-link-primary">登录</router-link>
          <router-link to="/register" class="nav-link nav-link-primary">注册</router-link>
        </template>
        <!-- 登录后显示用户名和退出登录按钮 -->
        <div v-else class="user-info">
            <span class="username">欢迎您，{{ userInfo.username || '用户' }}！</span>
            <button class="nav-link nav-link-primary logout-btn" @click="handleLogout">退出登录</button>
          </div>
      </nav>
    </div>
  </header>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const isLoggedIn = ref(false)
const userInfo = reactive({})

// 检查用户登录状态
const checkLoginStatus = () => {
  try {
    const userStr = localStorage.getItem('user')
    if (userStr) {
      const user = JSON.parse(userStr)
      if (user && user.username) {
        isLoggedIn.value = true
        Object.assign(userInfo, user)
      } else {
        isLoggedIn.value = false
        userInfo.username = ''
      }
    } else {
      isLoggedIn.value = false
      userInfo.username = ''
    }
  } catch (error) {
    console.error('检查登录状态失败:', error)
    isLoggedIn.value = false
    userInfo.username = ''
  }
}

// 退出登录
const handleLogout = () => {
  // 清除localStorage中的用户信息
  localStorage.removeItem('user')
  localStorage.removeItem('userId')
  localStorage.removeItem('token')
  
  // 更新登录状态
  isLoggedIn.value = false
  userInfo.username = ''
  
  // 跳转到首页或登录页
  router.push('/')
}

// 滚动到商品展示区域
const scrollToProducts = () => {
  const section = document.getElementById('products')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}

// 组件挂载时检查登录状态
onMounted(() => {
  checkLoginStatus()
  
  // 监听storage事件，以便在其他标签页登录/登出时同步更新
  window.addEventListener('storage', (e) => {
    if (e.key === 'user' || e.key === 'userId' || e.key === 'token') {
      checkLoginStatus()
    }
  })
})
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
}

/* 用户信息区域样式 */
.user-info {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.username {
  display: inline-block;
  padding: 4px 12px;
  cursor: default;
  font-weight: 500;
  color: #fff;
  background: none;
  border-radius: 4px;
}

.logout-btn {
  background: none;
  border: none;
  cursor: pointer;
  font-size: inherit;
  font-family: inherit;
  padding: 4px 12px;
  border-radius: 4px;
  transition: background-color 0.15s ease, color 0.15s ease;
}

.nav-link:hover {
  background-color: #e5e7eb;
  color: #111827;
  transition: background-color 0.15s ease, color 0.15s ease;
}

.nav-link-primary {
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

