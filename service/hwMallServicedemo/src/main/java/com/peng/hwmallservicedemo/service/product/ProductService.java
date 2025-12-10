package com.peng.hwmallservicedemo.service.product;

import java.util.List;
import java.util.Map;

public interface ProductService {
    /**
     * 根据商品ID查询商品信息
     * @param productId 商品ID
     * @return 商品信息
     */
    Map<String, Object> getProductById(int productId);

    /**
     * 查询所有商品
     * @return 商品列表
     */
    List<Map<String, Object>> getAllProducts();

    /**
     * 分页查询所有商品
     * @param page 页码（从1开始）
     * @param pageSize 每页数量
     * @return 包含商品列表和分页信息的Map
     */
    Map<String, Object> getAllProductsWithPage(int page, int pageSize);

    /**
     * 根据分类ID查询商品
     * @param categoryId 分类ID
     * @return 商品列表
     */
    List<Map<String, Object>> getProductsByCategory(int categoryId);

    /**
     * 根据分类ID分页查询商品
     * @param categoryId 分类ID
     * @param page 页码（从1开始）
     * @param pageSize 每页数量
     * @return 包含商品列表和分页信息的Map
     */
    Map<String, Object> getProductsByCategoryWithPage(int categoryId, int page, int pageSize);
}



