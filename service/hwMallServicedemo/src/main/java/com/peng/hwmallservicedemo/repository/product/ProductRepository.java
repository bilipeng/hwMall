package com.peng.hwmallservicedemo.repository.product;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductRepository {
    /**
     * 根据商品ID查询商品信息
     */
    Map<String, Object> getProductById(@Param("product_id") int productId);

    /**
     * 根据关键词搜索商品
     */
    List<Map<String, Object>> searchByKeyword(@Param("keyword") String keyword);

    /**
     * 根据关键词分页搜索商品
     */
    List<Map<String, Object>> searchByKeywordWithPage(
        @Param("keyword") String keyword,
        @Param("offset") int offset,
        @Param("pageSize") int pageSize
    );

    /**
     * 统计搜索结果总数
     */
    int countByKeyword(@Param("keyword") String keyword);

    /**
     * 查询所有商品
     */
    List<Map<String, Object>> getAllProducts();

    /**
     * 分页查询所有商品
     */
    List<Map<String, Object>> getAllProductsWithPage(
        @Param("offset") int offset,
        @Param("pageSize") int pageSize
    );

    /**
     * 根据分类ID查询商品
     */
    List<Map<String, Object>> getProductsByCategory(@Param("category_id") int categoryId);

    /**
     * 根据分类ID分页查询商品
     */
    List<Map<String, Object>> getProductsByCategoryWithPage(
        @Param("category_id") int categoryId,
        @Param("offset") int offset,
        @Param("pageSize") int pageSize
    );

    /**
     * 统计商品总数
     */
    int countAllProducts();

    /**
     * 根据分类统计商品数量
     */
    int countByCategory(@Param("category_id") int categoryId);

    /**
     * 查询所有商品分类
     */
    List<Map<String, Object>> getAllCategories();
}


