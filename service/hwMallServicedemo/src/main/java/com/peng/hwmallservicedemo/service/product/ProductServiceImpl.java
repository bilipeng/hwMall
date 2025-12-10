package com.peng.hwmallservicedemo.service.product;

import com.peng.hwmallservicedemo.repository.product.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public Map<String, Object> getProductById(int productId) {
        if (productId <= 0) {
            throw new RuntimeException("商品ID无效");
        }
        Map<String, Object> product = productRepository.getProductById(productId);
        if (product == null) {
            throw new RuntimeException("商品不存在");
        }
        return product;
    }

    @Override
    public List<Map<String, Object>> getAllProducts() {
        return productRepository.getAllProducts();
    }

    @Override
    public Map<String, Object> getAllProductsWithPage(int page, int pageSize) {
        // 参数验证
        if (page < 1) {
            page = 1;
        }
        if (pageSize < 1) {
            pageSize = 10;
        }
        if (pageSize > 100) {
            pageSize = 100; // 限制每页最大数量
        }

        // 计算偏移量
        int offset = (page - 1) * pageSize;

        // 查询商品列表
        List<Map<String, Object>> productList = productRepository.getAllProductsWithPage(offset, pageSize);

        // 查询总数
        int total = productRepository.countAllProducts();

        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / pageSize);

        // 构建返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("list", productList);
        result.put("total", total);
        result.put("page", page);
        result.put("pageSize", pageSize);
        result.put("totalPages", totalPages);

        return result;
    }

    @Override
    public List<Map<String, Object>> getProductsByCategory(int categoryId) {
        if (categoryId <= 0) {
            throw new RuntimeException("分类ID无效");
        }
        return productRepository.getProductsByCategory(categoryId);
    }

    @Override
    public Map<String, Object> getProductsByCategoryWithPage(int categoryId, int page, int pageSize) {
        // 参数验证
        if (categoryId <= 0) {
            throw new RuntimeException("分类ID无效");
        }
        if (page < 1) {
            page = 1;
        }
        if (pageSize < 1) {
            pageSize = 10;
        }
        if (pageSize > 100) {
            pageSize = 100; // 限制每页最大数量
        }

        // 计算偏移量
        int offset = (page - 1) * pageSize;

        // 查询商品列表
        List<Map<String, Object>> productList = productRepository.getProductsByCategoryWithPage(
            categoryId, offset, pageSize
        );

        // 查询总数
        int total = productRepository.countByCategory(categoryId);

        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / pageSize);

        // 构建返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("list", productList);
        result.put("total", total);
        result.put("categoryId", categoryId);
        result.put("page", page);
        result.put("pageSize", pageSize);
        result.put("totalPages", totalPages);

        return result;
    }
}



