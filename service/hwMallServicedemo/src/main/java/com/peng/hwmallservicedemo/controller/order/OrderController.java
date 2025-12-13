package com.peng.hwmallservicedemo.controller.order;

import com.peng.hwmallservicedemo.model.order.OrderDTO;
import com.peng.hwmallservicedemo.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 创建订单
     * POST /api/order/create
     */
    @PostMapping("/create")
    public Map<String, Object> createOrder(
            @RequestHeader(value = "userId", required = false) Long userId,
            @RequestBody OrderDTO orderDTO) {
        // 如果 header 中没有 userId，尝试从请求体中获取
        if (userId == null && orderDTO != null) {
            // 这里可以根据实际需求调整，可能需要从 token 中解析 userId
        }
        if (userId == null) {
            Map<String, Object> errorResult = new java.util.HashMap<>();
            errorResult.put("code", 400);
            errorResult.put("message", "用户ID不能为空");
            errorResult.put("data", null);
            return errorResult;
        }
        return orderService.createOrder(userId, orderDTO);
    }

    /**
     * 获取订单列表
     * GET /api/order/list
     */
    @GetMapping("/list")
    public Map<String, Object> listOrders(@RequestHeader(value = "userId", required = false) Long userId) {
        if (userId == null) {
            Map<String, Object> errorResult = new java.util.HashMap<>();
            errorResult.put("code", 400);
            errorResult.put("message", "用户ID不能为空");
            errorResult.put("data", null);
            return errorResult;
        }
        return orderService.listOrders(userId);
    }

    /**
     * 获取订单详情
     * GET /api/order/detail/{orderId}
     */
    @GetMapping("/detail/{orderId}")
    public Map<String, Object> getOrderDetail(@PathVariable("orderId") Long orderId) {
        return orderService.getOrderDetail(orderId);
    }
}

