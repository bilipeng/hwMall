package com.bilipeng.hwmall.mapper;

import com.bilipeng.hwmall.entity.Order;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface OrderMapper {
    
    @Insert("INSERT INTO `order` (order_no, user_id, total_amount, status, create_time, update_time, receiver_name, receiver_phone, receiver_address) " +
            "VALUES (#{orderNo}, #{userId}, #{totalAmount}, #{status}, #{createTime}, #{updateTime}, #{receiverName}, #{receiverPhone}, #{receiverAddress})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Order order);

    @Select("SELECT * FROM `order` WHERE id = #{id}")
    Order selectById(Long id);

    @Select("SELECT * FROM `order` WHERE user_id = #{userId} ORDER BY create_time DESC")
    List<Order> selectByUserId(Long userId);

    @Update("UPDATE `order` SET status = #{status}, update_time = #{updateTime} WHERE id = #{id}")
    int updateStatus(Order order);
}
