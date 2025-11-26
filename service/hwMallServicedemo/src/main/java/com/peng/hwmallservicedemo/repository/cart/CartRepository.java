package com.peng.hwmallservicedemo.repository.cart;

import com.peng.hwmallservicedemo.model.cart.Cart;
import com.peng.hwmallservicedemo.model.cart.CartVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CartRepository {
    /**
     * 根据用户ID查询购物车
     */
    List<Cart> findByUserId(@Param("user_id") int userId);

    /**
     * 根据用户ID和商品ID查询购物车项
     */
    Cart findByUserIdAndProductId(@Param("user_id") int userId, @Param("product_id") int productId);

    /**
     * 添加商品到购物车
     */
    int save(Cart cart);

    /**
     * 更新购物车商品数量
     */
    int update(Cart cart);

    /**
     * 删除购物车商品
     */
    int delete(@Param("cart_id") int cartId);

    /**
     * 清空用户购物车
     */
    int deleteByUserId(@Param("user_id") int userId);

    /**
     * 根据购物车ID查询
     */
    Cart findById(@Param("cart_id") int cartId);

    /**
     * 获取购物车商品总数
     */
    int getCartCount(@Param("user_id") int userId);

    /**
     * 获取购物车列表（关联商品信息）
     */
    List<CartVO> getCartListWithProduct(@Param("user_id") int userId);
}

