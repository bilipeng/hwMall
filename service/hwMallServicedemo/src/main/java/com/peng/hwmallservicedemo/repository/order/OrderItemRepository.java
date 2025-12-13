package com.peng.hwmallservicedemo.repository.order;

import com.peng.hwmallservicedemo.model.order.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderItemRepository {

    /**
     * 插入订单商品
     * @param orderItem 订单商品对象
     * @return 影响的行数
     */
    int insert(OrderItem orderItem);

    /**
     * 根据订单ID查询订单商品列表
     * @param orderId 订单ID
     * @return 订单商品列表
     */
    List<OrderItem> findByOrderId(@Param("orderId") Long orderId);
}

