package com.peng.hwmallservicedemo.service.order;

import com.peng.hwmallservicedemo.model.order.Order;
import com.peng.hwmallservicedemo.model.order.OrderDTO;
import com.peng.hwmallservicedemo.model.order.OrderItem;
import com.peng.hwmallservicedemo.repository.order.OrderItemRepository;
import com.peng.hwmallservicedemo.repository.order.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Override
    @Transactional
    public Map<String, Object> createOrder(Long userId, OrderDTO orderDTO) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 验证必填字段
            if (orderDTO.getReceiverName() == null || orderDTO.getReceiverName().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人姓名不能为空");
                result.put("data", null);
                return result;
            }

            if (orderDTO.getReceiverPhone() == null || orderDTO.getReceiverPhone().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货人电话不能为空");
                result.put("data", null);
                return result;
            }

            if (orderDTO.getReceiverAddress() == null || orderDTO.getReceiverAddress().trim().isEmpty()) {
                result.put("code", 400);
                result.put("message", "收货地址不能为空");
                result.put("data", null);
                return result;
            }

            if (orderDTO.getItems() == null || orderDTO.getItems().isEmpty()) {
                result.put("code", 400);
                result.put("message", "订单商品不能为空");
                result.put("data", null);
                return result;
            }

            // 1. 创建订单
            Order order = new Order();
            order.setUserId(userId);
            order.setOrderDate(new Date());
            order.setStatus("待支付"); // 使用字符串状态
            
            // 构建地址信息（包含收货人姓名、电话和地址）
            String addressInfo = orderDTO.getReceiverAddress() + "，收货人：" + orderDTO.getReceiverName() + "，电话：" + orderDTO.getReceiverPhone();
            order.setAddress(addressInfo);

            // 计算订单总金额
            BigDecimal totalAmount = BigDecimal.ZERO;
            for (OrderDTO.OrderItemDTO itemDTO : orderDTO.getItems()) {
                BigDecimal itemTotal = itemDTO.getPrice().multiply(new BigDecimal(itemDTO.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            }
            order.setTotalAmount(totalAmount);

            // 2. 插入订单获取ID
            orderRepository.insert(order);
            Long orderId = order.getOrderId();

            // 3. 插入订单商品
            for (OrderDTO.OrderItemDTO itemDTO : orderDTO.getItems()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(itemDTO.getProductId());
                orderItem.setPrice(itemDTO.getPrice());
                orderItem.setQuantity(itemDTO.getQuantity());
                // totalPrice会在查询时计算，这里也可以设置
                orderItem.setTotalPrice(itemDTO.getPrice().multiply(new BigDecimal(itemDTO.getQuantity())));

                orderItemRepository.insert(orderItem);
            }

            // 4. 获取完整的订单信息
            Order createdOrder = orderRepository.findById(orderId);
            if (createdOrder != null) {
                createdOrder.setOrderItems(orderItemRepository.findByOrderId(orderId));
            }

            result.put("code", 200);
            result.put("message", "订单创建成功");
            result.put("data", createdOrder);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", 500);
            result.put("message", "订单创建失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> listOrders(Long userId) {
        Map<String, Object> result = new HashMap<>();

        try {
            List<Order> orders = orderRepository.findByUserId(userId);
            // 为每个订单填充订单商品信息
            for (Order order : orders) {
                order.setOrderItems(orderItemRepository.findByOrderId(order.getOrderId()));
            }

            result.put("code", 200);
            result.put("message", "获取成功");
            result.put("data", orders);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", 500);
            result.put("message", "获取订单列表失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> getOrderDetail(Long orderId) {
        Map<String, Object> result = new HashMap<>();

        try {
            Order order = orderRepository.findById(orderId);
            if (order == null) {
                result.put("code", 404);
                result.put("message", "订单不存在");
                result.put("data", null);
            } else {
                order.setOrderItems(orderItemRepository.findByOrderId(orderId));
                result.put("code", 200);
                result.put("message", "获取成功");
                result.put("data", order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code", 500);
            result.put("message", "获取订单详情失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

}

