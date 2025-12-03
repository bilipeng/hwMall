<template>
  <div class="register-view">
    <div class="register-container">
      <Register @switch-to-login="handleSwitchToLogin" @register-success="handleRegisterSuccess" />
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import Register from '@/components/User/Register.vue'

const router = useRouter()

const handleSwitchToLogin = () => {
  router.push('/login')
}

const handleRegisterSuccess = () => {
  console.log('注册成功')
}
</script>

<style scoped>
.register-view {
  min-height: calc(100vh - 200px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
  background-color: var(--background);
}

.register-container {
  width: 100%;
  max-width: 500px;
}
</style>

