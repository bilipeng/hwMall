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

/**
 * 获取全部商品分类
 */
export async function getCategories() {
  try {
    const response = await request.get('/api/product/categories')
    // 响应拦截器已经返回了 response.data
    // 后端返回格式: { code: 200, message: "success", data: [...] }
    if (response && response.code === 200 && response.data) {
      return response
    }
    // 如果格式不对，尝试直接返回
    return response
  } catch (error) {
    console.error('获取分类失败:', error)
    throw error
  }
}


