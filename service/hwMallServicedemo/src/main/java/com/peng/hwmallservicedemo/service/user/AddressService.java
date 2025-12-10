package com.peng.hwmallservicedemo.service.user;

import com.peng.hwmallservicedemo.model.user.Address;

import java.util.Map;

public interface AddressService {
    /**
     * 获取用户的所有地址
     * @param userId 用户ID
     * @return 地址列表
     */
    Map<String, Object> getAddressesByUserId(int userId);

    /**
     * 根据ID获取地址
     * @param id 地址ID
     * @return 地址信息
     */
    Map<String, Object> getAddressById(int id);

    /**
     * 添加地址
     * @param address 地址对象
     * @return 添加结果
     */
    Map<String, Object> addAddress(Address address);

    /**
     * 更新地址
     * @param address 地址对象
     * @return 更新结果
     */
    Map<String, Object> updateAddress(Address address);

    /**
     * 删除地址
     * @param id 地址ID
     * @return 删除结果
     */
    Map<String, Object> deleteAddress(int id);
}


