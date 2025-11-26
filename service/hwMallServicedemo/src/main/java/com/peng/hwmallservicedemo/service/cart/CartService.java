package com.peng.hwmallservicedemo.service.cart;

import com.peng.hwmallservicedemo.model.cart.CartVO;

import java.util.List;
import java.math.BigDecimal;

public interface CartService {
    /**
     * 添加商品到购物车
     */
    int addToCart(int userId, int productId, int quantity);

    /**
     * 获取购物车商品列表
     */
    List<CartVO> getCartList(int userId);

    /**
     * 更新购物车商品数量
     */
    int updateCartItemQuantity(int cartId, int quantity);

    /**
     * 删除购物车商品
     */
    int removeCartItem(int cartId);

    /**
     * 清空购物车
     */
    int clearCart(int userId);

    /**
     * 获取购物车商品总数
     */
    int getCartCount(int userId);

    /**
     * 计算购物车总金额
     */
    BigDecimal getTotalAmount(int userId);
}


