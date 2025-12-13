package com.peng.hwmallservicedemo.service.order;

import com.peng.hwmallservicedemo.model.order.OrderDTO;

import java.util.Map;

public interface OrderService {
    /**
     * 创建订单
     * @param userId 用户ID
     * @param orderDTO 订单详情
     * @return 创建结果
     */
    Map<String, Object> createOrder(Long userId, OrderDTO orderDTO);

    /**
     * 获取用户的订单列表
     * @param userId 用户ID
     * @return 订单列表
     */
    Map<String, Object> listOrders(Long userId);

    /**
     * 获取订单详情
     * @param orderId 订单ID
     * @return 订单详情
     */
    Map<String, Object> getOrderDetail(Long orderId);
}

