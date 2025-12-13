package com.peng.hwmallservicedemo.controller.product;

import com.peng.hwmallservicedemo.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     * 根据商品ID查询商品详情
     */
    @GetMapping("/{productId}")
    public Map<String, Object> getProductById(@PathVariable int productId) {
        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> product = productService.getProductById(productId);
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", product);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 查询所有商品分类
     */
    @GetMapping("/categories")
    public Map<String, Object> getAllCategories() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Map<String, Object>> categories = productService.getAllCategories();
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", categories);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 查询所有商品（不分页）
     */
    @GetMapping("/list")
    public Map<String, Object> getAllProducts() {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Map<String, Object>> products = productService.getAllProducts();
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", products);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 分页查询所有商品
     */
    @GetMapping("/page")
    public Map<String, Object> getAllProductsWithPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 参数验证
            if (page < 1) {
                result.put("code", 400);
                result.put("message", "页码必须大于0");
                result.put("data", null);
                return result;
            }
            if (pageSize < 1 || pageSize > 100) {
                result.put("code", 400);
                result.put("message", "每页数量必须在1-100之间");
                result.put("data", null);
                return result;
            }

            Map<String, Object> pageResult = productService.getAllProductsWithPage(page, pageSize);
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", pageResult);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 根据分类ID查询商品（不分页）
     */
    @GetMapping("/category/{categoryId}")
    public Map<String, Object> getProductsByCategory(@PathVariable int categoryId) {
        Map<String, Object> result = new HashMap<>();
        try {
            if (categoryId <= 0) {
                result.put("code", 400);
                result.put("message", "分类ID无效");
                result.put("data", null);
                return result;
            }

            List<Map<String, Object>> products = productService.getProductsByCategory(categoryId);
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", products);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 根据分类ID分页查询商品
     */
    @GetMapping("/category/{categoryId}/page")
    public Map<String, Object> getProductsByCategoryWithPage(
            @PathVariable int categoryId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 参数验证
            if (categoryId <= 0) {
                result.put("code", 400);
                result.put("message", "分类ID无效");
                result.put("data", null);
                return result;
            }
            if (page < 1) {
                result.put("code", 400);
                result.put("message", "页码必须大于0");
                result.put("data", null);
                return result;
            }
            if (pageSize < 1 || pageSize > 100) {
                result.put("code", 400);
                result.put("message", "每页数量必须在1-100之间");
                result.put("data", null);
                return result;
            }

            Map<String, Object> pageResult = productService.getProductsByCategoryWithPage(
                categoryId, page, pageSize
            );
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", pageResult);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }
}

