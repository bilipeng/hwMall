<template>
  <div class="register-form">
    <h2 class="form-title">用户注册</h2>
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

      <div class="form-group">
        <label for="confirmPassword">确认密码</label>
        <input
          id="confirmPassword"
          v-model="formData.confirmPassword"
          type="password"
          placeholder="请再次输入密码"
          required
          :class="{ 'error': errors.confirmPassword }"
        />
        <span v-if="errors.confirmPassword" class="error-message">{{ errors.confirmPassword }}</span>
      </div>

      <div class="form-group">
        <label for="phone">手机号（可选）</label>
        <input
          id="phone"
          v-model="formData.phone"
          type="tel"
          placeholder="请输入手机号"
          :class="{ 'error': errors.phone }"
        />
        <span v-if="errors.phone" class="error-message">{{ errors.phone }}</span>
      </div>

      <div class="form-group">
        <label for="email">邮箱（可选）</label>
        <input
          id="email"
          v-model="formData.email"
          type="email"
          placeholder="请输入邮箱"
          :class="{ 'error': errors.email }"
        />
        <span v-if="errors.email" class="error-message">{{ errors.email }}</span>
      </div>

      <div v-if="message" :class="['message', messageType]">
        {{ message }}
      </div>

      <button type="submit" class="btn btn-primary" :disabled="loading">
        {{ loading ? '注册中...' : '注册' }}
      </button>

      <div class="form-footer">
        <span>已有账号？</span>
        <a href="#" @click.prevent="$emit('switch-to-login')">立即登录</a>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { register } from '@/api/user.js'
import { useRouter } from 'vue-router'

const emit = defineEmits(['switch-to-login', 'register-success'])

const router = useRouter()

const formData = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  phone: '',
  email: ''
})



const errors = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  phone: '',
  email: ''
})

const message = ref('')
const messageType = ref('')
const loading = ref(false)

const validateForm = () => {
  // 重置错误信息
  Object.keys(errors).forEach(key => {
    errors[key] = ''
  })
  message.value = ''
  messageType.value = ''

  let isValid = true

  // 验证用户名
  if (!formData.username.trim()) {
    errors.username = '用户名不能为空'
    isValid = false
  } else if (formData.username.trim().length < 3) {
    errors.username = '用户名至少3个字符'
    isValid = false
  }

  // 验证密码
  if (!formData.password.trim()) {
    errors.password = '密码不能为空'
    isValid = false
  } else if (formData.password.length < 6) {
    errors.password = '密码至少6个字符'
    isValid = false
  }

  // 验证确认密码
  if (!formData.confirmPassword.trim()) {
    errors.confirmPassword = '请确认密码'
    isValid = false
  } else if (formData.password !== formData.confirmPassword) {
    errors.confirmPassword = '两次输入的密码不一致'
    isValid = false
  }

  // 验证手机号（如果填写了）
  if (formData.phone && !/^1[3-9]\d{9}$/.test(formData.phone)) {
    errors.phone = '请输入正确的手机号'
    isValid = false
  }

  // 验证邮箱（如果填写了）
  if (formData.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email)) {
    errors.email = '请输入正确的邮箱地址'
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
    const response = await register({
      username: formData.username.trim(),
      password: formData.password,
      confirmPassword: formData.confirmPassword,
      phone: formData.phone.trim(),
      email: formData.email.trim()
    })
    
    if (response.code === 200) {
      message.value = '注册成功！正在跳转到登录页面...'
      messageType.value = 'success'
      
      // 触发注册成功事件
      emit('register-success')
      
      // 延迟跳转到登录页
      setTimeout(() => {
        router.push('/login')
      }, 1500)
    } else {
      message.value = response.message || '注册失败'
      messageType.value = 'error'
    }
  } catch (error) {
    console.error('注册错误:', error)
    message.value = error.response?.data?.message || '注册失败，请稍后重试'
    messageType.value = 'error'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.register-form {
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

