// 订单相关 API
import request from './request.js'

/**
 * 创建订单
 * @param {number} userId - 用户ID
 * @param {Object} orderData - 订单数据
 * @param {string} orderData.receiverName - 收货人姓名
 * @param {string} orderData.receiverPhone - 收货人电话
 * @param {string} orderData.receiverAddress - 收货地址
 * @param {Array} orderData.items - 订单商品列表
 * @returns {Promise}
 */
export function createOrder(userId, orderData) {
  return request.post('/api/order/create', orderData, {
    headers: {
      'userId': userId.toString()
    }
  })
}

/**
 * 获取订单列表
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function getOrderList(userId) {
  return request.get('/api/order/list', {
    headers: {
      'userId': userId.toString()
    }
  })
}

/**
 * 获取订单详情
 * @param {number} orderId - 订单ID
 * @returns {Promise}
 */
export function getOrderDetail(orderId) {
  return request.get(`/api/order/detail/${orderId}`)
}

