package com.peng.hwmallservicedemo.repository.user;

import com.peng.hwmallservicedemo.model.user.Address;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AddressRepository {
    /**
     * 根据用户ID查询所有地址
     * @param userId 用户ID
     * @return 地址列表
     */
    List<Address> findByUserId(@Param("userId") int userId);

    /**
     * 根据地址ID查询地址
     * @param id 地址ID
     * @return 地址信息
     */
    Address findById(@Param("id") int id);

    /**
     * 保存地址
     * @param address 地址对象
     * @return 影响的行数
     */
    int save(Address address);

    /**
     * 更新地址
     * @param address 地址对象
     * @return 影响的行数
     */
    int update(Address address);

    /**
     * 删除地址
     * @param id 地址ID
     * @return 影响的行数
     */
    int deleteById(@Param("id") int id);
}


