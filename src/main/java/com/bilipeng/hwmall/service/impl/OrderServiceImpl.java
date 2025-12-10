package com.bilipeng.hwmall.service.impl;

import com.bilipeng.hwmall.dto.OrderDTO;
import com.bilipeng.hwmall.entity.Order;
import com.bilipeng.hwmall.entity.OrderItem;
import com.bilipeng.hwmall.mapper.OrderItemMapper;
import com.bilipeng.hwmall.mapper.OrderMapper;
import com.bilipeng.hwmall.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Override
    @Transactional
    public Order createOrder(Long userId, OrderDTO orderDTO) {
        // 1. Create Order
        Order order = new Order();
        order.setOrderNo(generateOrderNo());
        order.setUserId(userId);
        order.setReceiverName(orderDTO.getReceiverName());
        order.setReceiverPhone(orderDTO.getReceiverPhone());
        order.setReceiverAddress(orderDTO.getReceiverAddress());
        order.setStatus(0); // Pending
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());

        // Calculate total amount from items (validation step)
        BigDecimal totalAmount = BigDecimal.ZERO;
        
        // 2. Insert Order to get ID
        // Note: In a real scenario, we'd check stock here
        
        if (orderDTO.getItems() != null) {
            for (OrderDTO.OrderItemDTO itemDTO : orderDTO.getItems()) {
                BigDecimal itemTotal = itemDTO.getPrice().multiply(new BigDecimal(itemDTO.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            }
        }
        order.setTotalAmount(totalAmount);
        
        orderMapper.insert(order);
        Long orderId = order.getId();

        // 3. Insert Order Items
        if (orderDTO.getItems() != null) {
            for (OrderDTO.OrderItemDTO itemDTO : orderDTO.getItems()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(itemDTO.getProductId());
                orderItem.setProductName(itemDTO.getProductName());
                orderItem.setProductImage(itemDTO.getProductImage());
                orderItem.setPrice(itemDTO.getPrice());
                orderItem.setQuantity(itemDTO.getQuantity());
                orderItem.setTotalPrice(itemDTO.getPrice().multiply(new BigDecimal(itemDTO.getQuantity())));
                
                orderItemMapper.insert(orderItem);
            }
        }

        return getOrderDetail(orderId);
    }

    @Override
    public List<Order> listOrders(Long userId) {
        List<Order> orders = orderMapper.selectByUserId(userId);
        // Populate items for each order if needed, or do lazy loading
        // For simplicity, we can fetch items for each order
        for (Order order : orders) {
            order.setOrderItems(orderItemMapper.selectByOrderId(order.getId()));
        }
        return orders;
    }

    @Override
    public Order getOrderDetail(Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order != null) {
            order.setOrderItems(orderItemMapper.selectByOrderId(orderId));
        }
        return order;
    }

    private String generateOrderNo() {
        return java.time.LocalDateTime.now().toString().replace("-", "").replace(":", "").replace(".", "") 
               + (int)(Math.random() * 1000);
    }
}
