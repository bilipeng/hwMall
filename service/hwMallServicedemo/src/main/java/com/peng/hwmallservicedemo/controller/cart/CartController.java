package com.peng.hwmallservicedemo.controller.cart;

import com.peng.hwmallservicedemo.model.cart.CartVO;
import com.peng.hwmallservicedemo.service.cart.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    /**
     * 添加商品到购物车
     */
    @PostMapping("/add")
    public Map<String, Object> addToCart(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        try {
            int userId = (Integer) request.get("userId");
            int productId = (Integer) request.get("productId");
            int quantity = (Integer) request.get("quantity");

            int cartId = cartService.addToCart(userId, productId, quantity);
            int cartCount = cartService.getCartCount(userId);

            result.put("code", 200);
            result.put("message", "添加成功");
            Map<String, Object> data = new HashMap<>();
            data.put("cartCount", cartCount);
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 获取购物车商品列表
     */
    @GetMapping("/list")
    public Map<String, Object> getCartList(@RequestParam int userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<CartVO> cartItems = cartService.getCartList(userId);
            BigDecimal totalAmount = cartService.getTotalAmount(userId);

            result.put("code", 200);
            result.put("message", "success");
            Map<String, Object> data = new HashMap<>();
            data.put("cartItems", cartItems);
            data.put("totalAmount", totalAmount);
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 更新购物车商品数量
     */
    @PutMapping("/update")
    public Map<String, Object> updateCartItemQuantity(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        try {
            int cartId = (Integer) request.get("cartId");
            int quantity = (Integer) request.get("quantity");

            cartService.updateCartItemQuantity(cartId, quantity);

            result.put("code", 200);
            result.put("message", "更新成功");
            result.put("data", null);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 删除购物车商品
     */
    @DeleteMapping("/delete/{cartId}")
    public Map<String, Object> removeCartItem(@PathVariable int cartId) {
        Map<String, Object> result = new HashMap<>();
        try {
            cartService.removeCartItem(cartId);

            result.put("code", 200);
            result.put("message", "删除成功");
            result.put("data", null);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 清空购物车
     */
    @DeleteMapping("/clear")
    public Map<String, Object> clearCart(@RequestParam int userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            cartService.clearCart(userId);

            result.put("code", 200);
            result.put("message", "清空成功");
            result.put("data", null);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }

    /**
     * 获取购物车商品数量
     */
    @GetMapping("/count")
    public Map<String, Object> getCartCount(@RequestParam int userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = cartService.getCartCount(userId);

            result.put("code", 200);
            result.put("message", "success");
            Map<String, Object> data = new HashMap<>();
            data.put("count", count);
            result.put("data", data);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", e.getMessage());
            result.put("data", null);
        }
        return result;
    }
}


