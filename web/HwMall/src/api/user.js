// 用户相关 API
import request from './request.js'

/**
 * 用户注册
 * @param {Object} userData - 用户注册信息
 * @param {string} userData.username - 用户名
 * @param {string} userData.password - 密码
 * @param {string} userData.confirmPassword - 确认密码
 * @param {string} userData.phone - 手机号（可选）
 * @param {string} userData.email - 邮箱（可选）
 * @returns {Promise}
 */
export function register(userData) {
  return request.post('/api/users/register', {
    username: userData.username,
    password: userData.password,
    confirmPassword: userData.confirmPassword,
    phone: userData.phone || '',
    email: userData.email || ''
  })
}

/**
 * 用户登录
 * @param {string} username - 用户名
 * @param {string} password - 密码
 * @returns {Promise}
 */
export function login(username, password) {
  return request.post('/api/users/login', {
    username,
    password
  })
}

/**
 * 获取用户信息
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function getUserInfo(userId) {
  return request.get(`/api/users/${userId}`)
}

/**
 * 更新用户信息
 * @param {number} userId - 用户ID
 * @param {Object} userData - 用户信息
 * @param {string} userData.phone - 手机号（可选）
 * @param {string} userData.email - 邮箱（可选）
 * @returns {Promise}
 */
export function updateUserInfo(userId, userData) {
  return request.put(`/api/users/${userId}`, userData)
}

/**
 * 更改密码
 * @param {number} userId - 用户ID
 * @param {string} currentPassword - 当前密码
 * @param {string} newPassword - 新密码
 * @returns {Promise}
 */
export function changePassword(userId, currentPassword, newPassword) {
  return request.post(`/api/users/${userId}/change-password`, {
    currentPassword,
    newPassword
  })
}

/**
 * 获取用户的所有地址
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function getAddresses(userId) {
  return request.get(`/api/addresses/user/${userId}`)
}

/**
 * 根据ID获取地址
 * @param {number} addressId - 地址ID
 * @returns {Promise}
 */
export function getAddressById(addressId) {
  return request.get(`/api/addresses/${addressId}`)
}

/**
 * 添加地址
 * @param {Object} addressData - 地址信息
 * @param {number} addressData.userId - 用户ID
 * @param {string} addressData.name - 收货人姓名
 * @param {string} addressData.tel - 收货人电话
 * @param {string} addressData.address - 收货地址
 * @returns {Promise}
 */
export function addAddress(addressData) {
  return request.post('/api/addresses', addressData)
}

/**
 * 更新地址
 * @param {number} addressId - 地址ID
 * @param {Object} addressData - 地址信息
 * @param {string} addressData.name - 收货人姓名
 * @param {string} addressData.tel - 收货人电话
 * @param {string} addressData.address - 收货地址
 * @returns {Promise}
 */
export function updateAddress(addressId, addressData) {
  return request.put(`/api/addresses/${addressId}`, addressData)
}

/**
 * 删除地址
 * @param {number} addressId - 地址ID
 * @returns {Promise}
 */
export function deleteAddress(addressId) {
  return request.delete(`/api/addresses/${addressId}`)
}

