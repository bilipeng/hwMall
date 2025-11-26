package com.peng.hwmallservicedemo.service.cart;

import com.peng.hwmallservicedemo.model.cart.Cart;
import com.peng.hwmallservicedemo.model.cart.CartVO;
import com.peng.hwmallservicedemo.repository.cart.CartRepository;
import com.peng.hwmallservicedemo.repository.product.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    @Transactional
    public int addToCart(int userId, int productId, int quantity) {
        try {
            // 检查商品是否存在和库存是否充足
            Map<String, Object> productInfo = productRepository.getProductById(productId);
            if (productInfo == null) {
                throw new RuntimeException("商品不存在");
            }
            
            Object stockObj = productInfo.get("stock");
            if (stockObj == null) {
                throw new RuntimeException("商品库存信息异常");
            }
            int stock = stockObj instanceof Integer ? (Integer) stockObj : ((Number) stockObj).intValue();
            if (stock < quantity) {
                throw new RuntimeException("库存不足");
            }

            // 检查购物车中是否已有该商品
            Cart existingCart = cartRepository.findByUserIdAndProductId(userId, productId);
            
            if (existingCart != null) {
                // 如果已存在，更新数量
                int newQuantity = existingCart.getQuantity() + quantity;
                if (newQuantity > stock) {
                    throw new RuntimeException("库存不足，当前库存：" + stock);
                }
                existingCart.setQuantity(newQuantity);
                cartRepository.update(existingCart);
                return existingCart.getCart_id();
            } else {
                // 如果不存在，新增
                Cart cart = new Cart();
                cart.setUser_id(userId);
                cart.setProduct_id(productId);
                cart.setQuantity(quantity);
                cartRepository.save(cart);
                return cart.getCart_id();
            }
        } catch (Exception e) {
            throw new RuntimeException("添加购物车失败: " + e.getMessage(), e);
        }
    }

    @Override
    public List<CartVO> getCartList(int userId) {
        return cartRepository.getCartListWithProduct(userId);
    }

    @Override
    @Transactional
    public int updateCartItemQuantity(int cartId, int quantity) {
        try {
            Cart cart = cartRepository.findById(cartId);
            if (cart == null) {
                throw new RuntimeException("购物车项不存在");
            }

            // 检查库存
            Map<String, Object> productInfo = productRepository.getProductById(cart.getProduct_id());
            if (productInfo == null) {
                throw new RuntimeException("商品不存在");
            }
            
            Object stockObj = productInfo.get("stock");
            if (stockObj == null) {
                throw new RuntimeException("商品库存信息异常");
            }
            int stock = stockObj instanceof Integer ? (Integer) stockObj : ((Number) stockObj).intValue();
            if (quantity > stock) {
                throw new RuntimeException("库存不足，当前库存：" + stock);
            }

            if (quantity <= 0) {
                throw new RuntimeException("数量必须大于0");
            }

            cart.setQuantity(quantity);
            cartRepository.update(cart);
            return 1;
        } catch (Exception e) {
            throw new RuntimeException("更新购物车失败: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int removeCartItem(int cartId) {
        try {
            return cartRepository.delete(cartId);
        } catch (Exception e) {
            throw new RuntimeException("删除购物车项失败: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int clearCart(int userId) {
        try {
            return cartRepository.deleteByUserId(userId);
        } catch (Exception e) {
            throw new RuntimeException("清空购物车失败: " + e.getMessage(), e);
        }
    }

    @Override
    public int getCartCount(int userId) {
        return cartRepository.getCartCount(userId);
    }

    @Override
    public BigDecimal getTotalAmount(int userId) {
        List<CartVO> cartList = getCartList(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartVO item : cartList) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
}
