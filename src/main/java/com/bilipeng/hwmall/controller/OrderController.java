package com.bilipeng.hwmall.controller;

import com.bilipeng.hwmall.common.Result;
import com.bilipeng.hwmall.dto.OrderDTO;
import com.bilipeng.hwmall.entity.Order;
import com.bilipeng.hwmall.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/create")
    public Result<Order> createOrder(@RequestHeader("userId") Long userId, @RequestBody OrderDTO orderDTO) {
        // In a real app, userId would come from a secure context or token, here simulating header
        try {
            Order order = orderService.createOrder(userId, orderDTO);
            return Result.success(order, "Order created successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("Failed to create order: " + e.getMessage());
        }
    }

    @GetMapping("/list")
    public Result<List<Order>> listOrders(@RequestHeader("userId") Long userId) {
        List<Order> orders = orderService.listOrders(userId);
        return Result.success(orders);
    }

    @GetMapping("/detail/{orderId}")
    public Result<Order> getOrderDetail(@PathVariable Long orderId) {
        Order order = orderService.getOrderDetail(orderId);
        if (order == null) {
            return Result.error("Order not found");
        }
        return Result.success(order);
    }
}
