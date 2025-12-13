package com.peng.hwmallservicedemo.repository.order;

import com.peng.hwmallservicedemo.model.order.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderRepository {
    
    /**
     * 插入订单
     * @param order 订单对象
     * @return 影响的行数
     */
    int insert(Order order);

    /**
     * 根据ID查询订单
     * @param id 订单ID
     * @return 订单对象
     */
    Order findById(@Param("id") Long id);

    /**
     * 根据用户ID查询订单列表
     * @param userId 用户ID
     * @return 订单列表
     */
    List<Order> findByUserId(@Param("userId") Long userId);

    /**
     * 更新订单状态
     * @param order 订单对象
     * @return 影响的行数
     */
    int updateStatus(Order order);
}

