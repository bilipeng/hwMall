package com.peng.hwmallservicedemo.model.order;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Order {
    private Long orderId;  // 对应数据库 order_id
    private Long userId;
    private Date orderDate;  // 对应数据库 order_date
    private BigDecimal totalAmount;
    private String status;  // 对应数据库 status (varchar类型: 待支付, 已支付, 已发货, 已完成, 已取消)
    private String address;  // 对应数据库 address (包含收货人信息)
    
    // Transient field for details
    private List<OrderItem> orderItems;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}

