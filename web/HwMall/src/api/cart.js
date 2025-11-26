// 购物车相关 API
import request from './request.js'

/**
 * 添加商品到购物车
 * @param {number} userId - 用户ID
 * @param {number} productId - 商品ID
 * @param {number} quantity - 数量
 * @returns {Promise}
 */
export function addToCart(userId, productId, quantity) {
  return request.post('/api/cart/add', {
    userId,
    productId,
    quantity
  })
}

/**
 * 获取购物车商品列表
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function getCartList(userId) {
  return request.get('/api/cart/list', {
    params: { userId }
  })
}

/**
 * 更新购物车商品数量
 * @param {number} cartId - 购物车ID
 * @param {number} quantity - 新数量
 * @returns {Promise}
 */
export function updateCartItemQuantity(cartId, quantity) {
  return request.put('/api/cart/update', {
    cartId,
    quantity
  })
}

/**
 * 删除购物车商品
 * @param {number} cartId - 购物车ID
 * @returns {Promise}
 */
export function removeCartItem(cartId) {
  return request.delete(`/api/cart/delete/${cartId}`)
}

/**
 * 清空购物车
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function clearCart(userId) {
  return request.delete('/api/cart/clear', {
    params: { userId }
  })
}

/**
 * 获取购物车商品数量
 * @param {number} userId - 用户ID
 * @returns {Promise}
 */
export function getCartCount(userId) {
  return request.get('/api/cart/count', {
    params: { userId }
  })
}


