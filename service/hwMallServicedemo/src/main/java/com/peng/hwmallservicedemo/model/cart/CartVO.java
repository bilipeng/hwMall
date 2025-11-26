package com.peng.hwmallservicedemo.model.cart;

import java.math.BigDecimal;

/**
 * 购物车视图对象，包含商品详细信息
 */
public class CartVO {
    private int cartId;
    private int productId;
    private String productName;
    private BigDecimal price;
    private int quantity;
    private int stock;
    private BigDecimal subtotal;
    private String productImage; // 商品图片URL（可选）

    // 构造函数
    public CartVO() {}

    public CartVO(int cartId, int productId, String productName, BigDecimal price, int quantity, int stock, BigDecimal subtotal) {
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.stock = stock;
        this.subtotal = subtotal;
    }

    // Getter 和 Setter 方法
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    @Override
    public String toString() {
        return "CartVO{" +
                "cartId=" + cartId +
                ", productId=" + productId +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", stock=" + stock +
                ", subtotal=" + subtotal +
                '}';
    }
}


