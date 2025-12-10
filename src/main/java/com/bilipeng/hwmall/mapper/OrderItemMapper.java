package com.bilipeng.hwmall.mapper;

import com.bilipeng.hwmall.entity.OrderItem;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface OrderItemMapper {

    @Insert("INSERT INTO order_item (order_id, product_id, product_name, product_image, price, quantity, total_price) " +
            "VALUES (#{orderId}, #{productId}, #{productName}, #{productImage}, #{price}, #{quantity}, #{totalPrice})")
    int insert(OrderItem orderItem);

    @Select("SELECT * FROM order_item WHERE order_id = #{orderId}")
    List<OrderItem> selectByOrderId(Long orderId);
}
