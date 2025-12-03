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
 * @param {string} userData.username - 用户名（可选）
 * @param {string} userData.password - 密码（可选）
 * @param {string} userData.phone - 手机号（可选）
 * @param {string} userData.email - 邮箱（可选）
 * @returns {Promise}
 */
export function updateUserInfo(userId, userData) {
  return request.put(`/api/users/${userId}`, userData)
}

