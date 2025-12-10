<template>
  <div class="login-form">
    <h2 class="form-title">用户登录</h2>
    <form @submit.prevent="handleSubmit">
      <div class="form-group">
        <label for="username">用户名</label>
        <input
          id="username"
          v-model="formData.username"
          type="text"
          placeholder="请输入用户名"
          required
          :class="{ 'error': errors.username }"
        />
        <span v-if="errors.username" class="error-message">{{ errors.username }}</span>
      </div>

      <div class="form-group">
        <label for="password">密码</label>
        <input
          id="password"
          v-model="formData.password"
          type="password"
          placeholder="请输入密码"
          required
          :class="{ 'error': errors.password }"
        />
        <span v-if="errors.password" class="error-message">{{ errors.password }}</span>
      </div>

      <div v-if="message" :class="['message', messageType]">
        {{ message }}
      </div>

      <button type="submit" class="btn btn-primary" :disabled="loading">
        {{ loading ? '登录中...' : '登录' }}
      </button>

      <div class="form-footer">
        <span>还没有账号？</span>
        <a href="#" @click.prevent="$emit('switch-to-register')">立即注册</a>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { login } from '@/api/user.js'
import { useRouter } from 'vue-router'

const emit = defineEmits(['switch-to-register', 'login-success'])

const router = useRouter()

const formData = reactive({
  username: '',
  password: ''
})



const errors = reactive({
  username: '',
  password: ''
})

const message = ref('')
const messageType = ref('')
const loading = ref(false)

const validateForm = () => {
  // 重置错误信息
  errors.username = ''
  errors.password = ''
  message.value = ''
  messageType.value = ''

  let isValid = true

  // 验证用户名
  if (!formData.username.trim()) {
    errors.username = '用户名不能为空'
    isValid = false
  }

  // 验证密码
  if (!formData.password.trim()) {
    errors.password = '密码不能为空'
    isValid = false
  }

  return isValid
}

const handleSubmit = async () => {
  if (!validateForm()) {
    return
  }

  loading.value = true
  message.value = ''
  messageType.value = ''

  try {
    const response = await login(formData.username, formData.password)
    
    if (response.code === 200) {
      // 登录成功，保存用户信息到localStorage
      const userData = response.data
      localStorage.setItem('user', JSON.stringify(userData))
      
      // 确保正确存储用户ID（支持多种字段名）
      const userId = userData.user_id || userData.userId || userData.id
      if (userId) {
        localStorage.setItem('userId', userId.toString())
        console.log('登录成功，存储用户ID:', userId)
      } else {
        console.warn('登录响应中未找到用户ID:', userData)
      }
      
      if (userData?.token) {
        localStorage.setItem('token', userData.token)
      } else {
        localStorage.removeItem('token')
      }
      
      message.value = '登录成功！'
      messageType.value = 'success'
      
      // 触发登录成功事件
      emit('login-success', response.data)
      
      // 延迟跳转到首页（之前推到 `/` 会被路由重定向回 `/login`）
      setTimeout(() => {
        router.push('/home')
      }, 1000)
    } else {
      message.value = response.message || '登录失败'
      messageType.value = 'error'
    }
  } catch (error) {
    console.error('登录错误:', error)
    message.value = error.response?.data?.message || '登录失败，请稍后重试'
    messageType.value = 'error'
    localStorage.removeItem('token')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-form {
  background: var(--white);
  border-radius: var(--radius-md);
  padding: 2rem;
  box-shadow: var(--shadow-md);
  max-width: 400px;
  width: 100%;
  margin: 0 auto;
}

.form-title {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--text-color);
  margin-bottom: 1.5rem;
  text-align: center;
}

.form-group {
  margin-bottom: 1.25rem;
}

.form-group label {
  display: block;
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-color);
  margin-bottom: 0.5rem;
}

.form-group input {
  width: 100%;
  padding: 0.75rem;
  font-size: 0.875rem;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  transition: var(--transition);
  background-color: var(--white);
}

.form-group input:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.form-group input.error {
  border-color: #ef4444;
}

.error-message {
  display: block;
  color: #ef4444;
  font-size: 0.75rem;
  margin-top: 0.25rem;
}

.message {
  padding: 0.75rem;
  border-radius: var(--radius-sm);
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.message.success {
  background-color: #d1fae5;
  color: #065f46;
  border: 1px solid #6ee7b7;
}

.message.error {
  background-color: #fee2e2;
  color: #991b1b;
  border: 1px solid #fca5a5;
}

.btn {
  width: 100%;
  padding: 0.75rem;
  font-size: 0.875rem;
  font-weight: 500;
  border-radius: var(--radius-sm);
  transition: var(--transition);
}

.btn-primary {
  background-color: var(--primary-color);
  color: var(--white);
}

.btn-primary:hover:not(:disabled) {
  background-color: var(--primary-hover);
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.form-footer {
  margin-top: 1.5rem;
  text-align: center;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.form-footer a {
  color: var(--primary-color);
  margin-left: 0.25rem;
  font-weight: 500;
}

.form-footer a:hover {
  text-decoration: underline;
}
</style>

