<template>
  <div class="profile-container">
    <div class="profile-header">
      <h1 class="profile-title">个人中心</h1>
    </div>

    <div class="profile-content">
      <!-- 侧边栏菜单 -->
      <div class="profile-sidebar">
        <div 
          class="sidebar-item" 
          :class="{ 'active': currentTab === 'userInfo' }"
          @click="currentTab = 'userInfo'"
        >
          修改用户信息
        </div>
        <div 
          class="sidebar-item" 
          :class="{ 'active': currentTab === 'password' }"
          @click="currentTab = 'password'"
        >
          更改密码
        </div>
        <div 
          class="sidebar-item" 
          :class="{ 'active': currentTab === 'address' }"
          @click="currentTab = 'address'"
        >
          收货地址管理
        </div>
      </div>

      <!-- 主内容区域 -->
      <div class="profile-main">
        <!-- 修改用户信息 -->
        <section class="profile-section" v-if="currentTab === 'userInfo'">
          <h2 class="section-title">修改用户信息</h2>
          <form class="profile-form" @submit.prevent="handleUpdateUserInfo">
            <div class="form-group">
              <label for="username">用户名</label>
              <input 
                type="text" 
                id="username" 
                v-model="userInfo.username" 
                required 
                placeholder="请输入用户名"
                readonly
              />
            </div>
            <div class="form-group">
              <label for="phone">手机号</label>
              <input 
                type="tel" 
                id="phone" 
                v-model="userInfo.phone" 
                placeholder="请输入手机号"
              />
            </div>
            <div class="form-group">
              <label for="email">邮箱</label>
              <input 
                type="email" 
                id="email" 
                v-model="userInfo.email" 
                placeholder="请输入邮箱"
              />
            </div>
            <button type="submit" class="btn btn-primary">保存修改</button>
          </form>
        </section>

        <!-- 更改密码 -->
        <section class="profile-section" v-if="currentTab === 'password'">
          <h2 class="section-title">更改密码</h2>
          <form class="profile-form" @submit.prevent="handleChangePassword">
            <div class="form-group">
              <label for="currentPassword">当前密码</label>
              <input 
                type="password" 
                id="currentPassword" 
                v-model="passwordInfo.currentPassword" 
                required 
                placeholder="请输入当前密码"
              />
            </div>
            <div class="form-group">
              <label for="newPassword">新密码</label>
              <input 
                type="password" 
                id="newPassword" 
                v-model="passwordInfo.newPassword" 
                required 
                placeholder="请输入新密码"
              />
            </div>
            <div class="form-group">
              <label for="confirmPassword">确认新密码</label>
              <input 
                type="password" 
                id="confirmPassword" 
                v-model="passwordInfo.confirmPassword" 
                required 
                placeholder="请再次输入新密码"
              />
            </div>
            <button type="submit" class="btn btn-primary">确认更改</button>
          </form>
        </section>

        <!-- 收货地址管理 -->
        <section class="profile-section" v-if="currentTab === 'address'">
          <div class="section-header">
            <h2 class="section-title">收货地址管理</h2>
            <button class="btn btn-secondary" @click="showAddAddressForm = true">添加收货地址</button>
          </div>

          <!-- 收货地址列表 -->
          <div class="address-list" v-if="addresses.length > 0">
            <div class="address-item" v-for="address in addresses" :key="address.id">
              <div class="address-info">
                <div class="address-name">{{ address.name }}</div>
                <div class="address-phone">{{ address.tel }}</div>
                <div class="address-detail">{{ address.address }}</div>
              </div>
              <div class="address-actions">
                <button class="btn btn-sm btn-primary" @click="editAddress(address)">编辑</button>
                <button class="btn btn-sm btn-danger" @click="deleteAddress(address.id)">删除</button>
              </div>
            </div>
          </div>
          <div v-else class="empty-address">
            <p>暂无收货地址</p>
          </div>

          <!-- 添加/编辑收货地址表单 -->
          <div class="address-form-container" v-if="showAddAddressForm">
            <div class="address-form-header">
              <h3>{{ isEditingAddress ? '编辑收货地址' : '添加收货地址' }}</h3>
              <button class="btn-close" @click="closeAddAddressForm">&times;</button>
            </div>
            <form class="address-form" @submit.prevent="handleAddOrEditAddress">
              <div class="form-group">
                <label for="receiverName">收货人姓名</label>
                <input 
                  type="text" 
                  id="receiverName" 
                  v-model="currentAddress.receiverName" 
                  required 
                  placeholder="请输入收货人姓名"
                />
              </div>
              <div class="form-group">
                <label for="receiverPhone">收货人电话</label>
                <input 
                  type="tel" 
                  id="receiverPhone" 
                  v-model="currentAddress.receiverPhone" 
                  required 
                  placeholder="请输入收货人电话"
                />
              </div>
              <div class="form-group">
                <label for="address">收货地址</label>
                <textarea 
                  id="address" 
                  v-model="currentAddress.address" 
                  required 
                  rows="3" 
                  placeholder="请输入完整收货地址（包括省市县区详细地址）"
                ></textarea>
              </div>
              <div class="form-actions">
                <button type="button" class="btn btn-secondary" @click="closeAddAddressForm">取消</button>
                <button type="submit" class="btn btn-primary">保存</button>
              </div>
            </form>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { getUserInfo, updateUserInfo, changePassword, getAddresses, addAddress, updateAddress, deleteAddress as deleteAddressApi } from '@/api/user.js'
import router from '@/router'

// 当前选中的选项卡
const currentTab = ref('userInfo')

// 用户信息
const userInfo = reactive({
  username: '',
  phone: '',
  email: ''
})

// 密码信息
const passwordInfo = reactive({
  currentPassword: '',
  newPassword: '',
  confirmPassword: ''
})

// 收货地址相关
const addresses = ref([])
const showAddAddressForm = ref(false)
const isEditingAddress = ref(false)
const currentAddress = reactive({
  id: null,
  receiverName: '',
  receiverPhone: '',
  address: ''
})

// 从localStorage获取用户ID
const getUserId = () => {
  // 优先从userId键获取
  const userIdStr = localStorage.getItem('userId')
  console.log('从localStorage获取userId:', userIdStr)
  if (userIdStr && userIdStr !== 'null' && userIdStr !== 'undefined') {
    const userId = parseInt(userIdStr)
    if (!isNaN(userId)) {
      return userId
    }
  }
  
  // 其次从user键获取
  const userStr = localStorage.getItem('user')
  console.log('从localStorage获取user:', userStr)
  if (userStr) {
    try {
      const user = JSON.parse(userStr)
      console.log('解析后的用户对象:', user)
      // 尝试多种可能的字段名
      const userId = user.user_id || user.userId || user.id
      if (userId && !isNaN(userId)) {
        // 同时更新userId键，方便下次使用
        localStorage.setItem('userId', userId.toString())
        return parseInt(userId)
      }
    } catch (error) {
      console.error('解析用户信息失败:', error)
    }
  }
  
  console.log('未获取到用户ID，使用默认值0')
  // 返回默认值0，允许未登录用户操作
  return 0
}

// 获取用户信息
  const loadUserInfo = async () => {
    // 先尝试从localStorage获取用户信息，如果存在则直接使用
    const userStr = localStorage.getItem('user')
    console.log('localStorage中的用户信息:', userStr)
    if (userStr) {
      try {
        const user = JSON.parse(userStr)
        userInfo.username = user.username || ''
        userInfo.phone = user.phone || ''
        userInfo.email = user.email || ''
        console.log('通过localStorage更新后的用户信息:', userInfo)
        return
      } catch (error) {
        console.error('解析localStorage用户信息失败:', error)
      }
    }
    
    // 如果localStorage中没有用户信息，再尝试从API获取
    const userId = getUserId()
    console.log('获取到的用户ID:', userId)
    if (userId !== null && userId !== undefined) {
      try {
        const response = await getUserInfo(userId)
        console.log('获取用户信息的API响应:', response)
        if (response.code === 200) {
          const data = response.data
          userInfo.username = data.username || ''
          userInfo.phone = data.phone || ''
          userInfo.email = data.email || ''
          console.log('通过API更新后的用户信息:', userInfo)
        }
      } catch (error) {
        console.error('获取用户信息失败:', error)
      }
    } else {
      console.error('未获取到用户ID')
    }
  }

// 从localStorage获取用户信息
const loadUserInfoFromLocalStorage = () => {
  try {
    const userStr = localStorage.getItem('user')
    if (userStr) {
      const user = JSON.parse(userStr)
      userInfo.username = user.username || ''
      userInfo.phone = user.phone || ''
      userInfo.email = user.email || ''
      console.log('从localStorage更新后的用户信息:', userInfo)
    }
  } catch (error) {
    console.error('从localStorage获取用户信息失败:', error)
    // 允许未登录用户访问，不跳转到登录页面
    console.log('localStorage解析失败，继续访问个人中心')
  }
}

// 加载收货地址列表
const loadAddresses = async () => {
  const userId = getUserId()
  if (!userId) {
    alert('请先登录后再查看收货地址')
    router.push('/login')
    return
  }
  try {
    const response = await getAddresses(userId)
    if (response.code === 200) {
      const list = Array.isArray(response.data) ? response.data : []
      // 统一字段到前端使用的命名
      addresses.value = list.map(item => ({
        id: item.id || item.address_id,
        name: item.name,
        tel: item.tel,
        address: item.address
      }))
    } else {
      console.error('获取地址列表失败:', response.message)
    }
  } catch (error) {
    console.error('获取地址列表失败:', error)
  }
}

// 更新用户信息
const handleUpdateUserInfo = async () => {
  const userId = getUserId()
  console.log('handleUpdateUserInfo - 获取到的userId:', userId)
  console.log('localStorage内容:', {
    userId: localStorage.getItem('userId'),
    user: localStorage.getItem('user')
  })
  
  // 只在userId为null或undefined时才阻止更新，允许userId=0的情况
  if (userId === null || userId === undefined) {
    console.error('无法获取用户ID')
    alert('无法更新用户信息')
    return
  }

    try {
    // 准备要发送的数据，空字符串转换为null
    const updateData = {}
    if (userInfo.phone !== undefined && userInfo.phone !== null) {
      updateData.phone = userInfo.phone.trim() || null
    }
    if (userInfo.email !== undefined && userInfo.email !== null) {
      updateData.email = userInfo.email.trim() || null
    }

    console.log('发送更新请求:', updateData)
    const response = await updateUserInfo(userId, updateData)
    console.log('更新响应:', response)
    
      if (response.code === 200) {
        alert('用户信息更新成功')
      // 重新从后端加载最新的用户信息，确保界面显示最新数据
      await loadUserInfo()
        // 更新localStorage中的用户信息
        const savedUser = localStorage.getItem('user')
        if (savedUser) {
          const user = JSON.parse(savedUser)
          user.phone = userInfo.phone
          user.email = userInfo.email
          localStorage.setItem('user', JSON.stringify(user))
        }
      } else {
        alert('用户信息更新失败: ' + (response.message || '未知错误'))
      }
    } catch (error) {
      console.error('更新用户信息失败:', error)
    alert('更新用户信息失败: ' + (error.message || '网络错误，请检查后端服务是否正常运行'))
  }
}

// 更改密码
const handleChangePassword = async () => {
  if (passwordInfo.newPassword !== passwordInfo.confirmPassword) {
    alert('两次输入的新密码不一致')
    return
  }
  
  if (passwordInfo.newPassword.length < 6) {
    alert('新密码至少6个字符')
    return
  }
  
  const userId = getUserId()
  // 只在userId为null或undefined时才阻止密码修改，允许userId=0的情况
  if (userId !== null && userId !== undefined) {
    try {
      const response = await changePassword(userId, passwordInfo.currentPassword, passwordInfo.newPassword)
      
      if (response.code === 200) {
        alert('密码更改成功')
        // 重置表单
        passwordInfo.currentPassword = ''
        passwordInfo.newPassword = ''
        passwordInfo.confirmPassword = ''
      } else {
        alert('密码更改失败: ' + (response.message || '未知错误'))
      }
    } catch (error) {
      console.error('密码更改失败:', error)
      alert('密码更改失败')
    }
  }
}

// 打开添加收货地址表单
const openAddAddressForm = () => {
  resetAddressForm()
  isEditingAddress.value = false
  showAddAddressForm.value = true
}

// 编辑收货地址
const editAddress = (address) => {
  currentAddress.id = address.id
  currentAddress.receiverName = address.name || ''
  currentAddress.receiverPhone = address.tel || ''
  currentAddress.address = address.address || ''
  isEditingAddress.value = true
  showAddAddressForm.value = true
}

// 关闭添加/编辑收货地址表单
const closeAddAddressForm = () => {
  showAddAddressForm.value = false
  resetAddressForm()
}

// 重置地址表单
const resetAddressForm = () => {
  currentAddress.id = null
  currentAddress.receiverName = ''
  currentAddress.receiverPhone = ''
  currentAddress.address = ''
}

// 添加或编辑收货地址
const handleAddOrEditAddress = async () => {
  const userId = getUserId()
  if (!userId) {
    alert('请先登录后再添加收货地址')
    router.push('/login')
    return
  }

  try {
    const addressData = {
      name: currentAddress.receiverName,
      tel: currentAddress.receiverPhone,
      address: currentAddress.address
    }

    let response
    if (isEditingAddress.value) {
      // 编辑现有地址
      response = await updateAddress(currentAddress.id, addressData)
    } else {
      // 添加新地址
      addressData.userId = userId
      response = await addAddress(addressData)
    }

    if (response.code === 200) {
      alert(isEditingAddress.value ? '收货地址更新成功' : '收货地址添加成功')
      closeAddAddressForm()
      // 重新加载地址列表
      await loadAddresses()
  } else {
      alert((isEditingAddress.value ? '更新' : '添加') + '失败: ' + (response.message || '未知错误'))
    }
  } catch (error) {
    console.error('操作地址失败:', error)
    alert('操作失败，请稍后重试')
  }
}

// 删除收货地址
const deleteAddress = async (addressId) => {
  if (confirm('确定要删除这个收货地址吗？')) {
    try {
      const response = await deleteAddressApi(addressId)
      if (response.code === 200) {
    alert('收货地址删除成功')
        // 重新加载地址列表
        await loadAddresses()
      } else {
        alert('删除失败: ' + (response.message || '未知错误'))
      }
    } catch (error) {
      console.error('删除地址失败:', error)
      alert('删除失败，请稍后重试')
    }
  }
}

// 组件挂载时加载数据
onMounted(() => {
  console.log('组件挂载，开始加载用户信息')
  loadUserInfo()
  loadAddresses()
})
</script>

<style scoped>
.profile-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.profile-header {
  margin-bottom: 30px;
}

.profile-title {
  font-size: 24px;
  font-weight: 600;
  color: #333;
}

.profile-content {
  display: flex;
  gap: 30px;
}

/* 侧边栏样式 */
.profile-sidebar {
  width: 200px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.sidebar-item {
  padding: 16px 24px;
  cursor: pointer;
  transition: all 0.3s;
  border-bottom: 1px solid #f0f0f0;
  color: #555;
  font-size: 14px;
}

.sidebar-item:last-child {
  border-bottom: none;
}

.sidebar-item:hover {
  background-color: #f8f9fa;
  color: #333;
}

.sidebar-item.active {
  background-color: #007bff;
  color: #fff;
}

/* 主内容区域 */
.profile-main {
  flex: 1;
}

.profile-section {
  background-color: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.section-title {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 20px;
  color: #333;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.profile-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-row {
  display: flex;
  gap: 16px;
}

.form-row .form-group {
  flex: 1;
}

label {
  font-size: 14px;
  font-weight: 500;
  color: #555;
}

input, textarea {
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.3s;
}

/* 只读输入框样式 */
input[readonly] {
  color: #999;
  background-color: #f5f5f5;
}

input:focus, textarea:focus {
  outline: none;
  border-color: #007bff;
}

textarea {
  resize: vertical;
  min-height: 80px;
}

.form-actions {
  display: flex;
  gap: 12px;
  justify-content: flex-end;
  margin-top: 16px;
}

.btn {
  padding: 12px 24px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover {
  background-color: #0056b3;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #5a6268;
}

.btn-danger {
  background-color: #dc3545;
  color: white;
}

.btn-danger:hover {
  background-color: #c82333;
}

.btn-sm {
  padding: 8px 16px;
  font-size: 13px;
}

.btn-close {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #666;
}

.btn-close:hover {
  color: #333;
}

.address-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.address-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  padding: 16px;
  border: 1px solid #ddd;
  border-radius: 8px;
  gap: 20px;
}

.address-info {
  flex: 1;
}

.address-name {
  font-weight: 600;
  margin-bottom: 4px;
}

.address-phone {
  color: #666;
  margin-bottom: 8px;
}

.address-detail {
  color: #555;
  line-height: 1.5;
}

.address-actions {
  display: flex;
  gap: 8px;
}

.empty-address {
  text-align: center;
  padding: 40px;
  color: #666;
}

.address-form-container {
  margin-top: 24px;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
}

.address-form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background-color: #f8f9fa;
  border-bottom: 1px solid #ddd;
}

.address-form-header h3 {
  font-size: 18px;
  font-weight: 600;
  margin: 0;
}

.address-form {
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>