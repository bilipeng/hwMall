package com.peng.hwmallservicedemo.repository.user;

import com.peng.hwmallservicedemo.model.user.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface UserRepository {
    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户信息
     */
    User findByUsername(@Param("username") String username);

    /**
     * 根据用户ID查询用户
     * @param userId 用户ID
     * @return 用户信息
     */
    User findById(@Param("user_id") int userId);

    /**
     * 检查用户名是否存在
     * @param username 用户名
     * @return 存在的数量
     */
    int countByUsername(@Param("username") String username);

    /**
     * 保存用户信息（注册）
     * @param user 用户对象
     * @return 影响的行数
     */
    int save(User user);

    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 影响的行数
     */
    int updateUser(User user);
}

