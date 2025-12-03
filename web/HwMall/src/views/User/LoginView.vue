-- Active: 1757921052937@@localhost@3306@hwmall_db
<template>
  <div class="login-view">
    <div class="login-container">
      <Login @switch-to-register="handleSwitchToRegister" @login-success="handleLoginSuccess" />
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import Login from '@/components/User/Login.vue'

const router = useRouter()

const handleSwitchToRegister = () => {
  router.push('/register')
}

const handleLoginSuccess = (userData) => {
  console.log('登录成功，用户信息:', userData)
}
</script>

<style scoped>
.login-view {
  min-height: calc(100vh - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
  background-color: var(--background);
}

.login-container {
  width: 100%;
  max-width: 500px;
}
</style>

