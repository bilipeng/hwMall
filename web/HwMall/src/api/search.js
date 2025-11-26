// 搜索相关 API
import request from './request.js'

/**
 * 搜索商品
 * @param {string} keyword - 搜索关键词
 * @param {number} page - 页码，默认 1
 * @param {number} pageSize - 每页数量，默认 10
 * @returns {Promise}
 */
export function searchProducts(keyword, page = 1, pageSize = 10) {
  return request.get('/api/search', {
    params: {
      keyword,
      page,
      pageSize
    }
  })
}

