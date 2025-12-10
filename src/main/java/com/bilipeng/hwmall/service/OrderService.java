package com.bilipeng.hwmall.service;

import com.bilipeng.hwmall.dto.OrderDTO;
import com.bilipeng.hwmall.entity.Order;

import java.util.List;

public interface OrderService {
    /**
     * Create a new order
     * @param userId The ID of the user creating the order
     * @param orderDTO Order details
     * @return The created order
     */
    Order createOrder(Long userId, OrderDTO orderDTO);

    /**
     * List all orders for a user
     * @param userId The ID of the user
     * @return List of orders
     */
    List<Order> listOrders(Long userId);

    /**
     * Get order details
     * @param orderId The ID of the order
     * @return Order with items
     */
    Order getOrderDetail(Long orderId);
}
