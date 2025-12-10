// 商品相关 API
import request from './request.js'

/**
 * 根据商品ID查询商品详情
 * @param {number} productId - 商品ID
 * @returns {Promise}
 */
export function getProductById(productId) {
  return request.get(`/api/product/${productId}`)
}

/**
 * 查询所有商品（不分页）
 * @returns {Promise}
 */
export function getAllProducts() {
  return request.get('/api/product/list')
}

/**
 * 分页查询所有商品
 * @param {number} page - 页码（从1开始）
 * @param {number} pageSize - 每页数量
 * @returns {Promise}
 */
export function getAllProductsWithPage(page = 1, pageSize = 10) {
  return request.get('/api/product/page', {
    params: {
      page,
      pageSize
    }
  })
}

/**
 * 根据分类ID查询商品（不分页）
 * @param {number} categoryId - 分类ID
 * @returns {Promise}
 */
export function getProductsByCategory(categoryId) {
  return request.get(`/api/product/category/${categoryId}`)
}

/**
 * 根据分类ID分页查询商品
 * @param {number} categoryId - 分类ID
 * @param {number} page - 页码（从1开始）
 * @param {number} pageSize - 每页数量
 * @returns {Promise}
 */
export function getProductsByCategoryWithPage(categoryId, page = 1, pageSize = 10) {
  return request.get(`/api/product/category/${categoryId}/page`, {
    params: {
      page,
      pageSize
    }
  })
}


