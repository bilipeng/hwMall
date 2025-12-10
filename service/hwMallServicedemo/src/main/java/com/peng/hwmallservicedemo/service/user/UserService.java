package com.peng.hwmallservicedemo.service.user;

import com.peng.hwmallservicedemo.model.user.User;

import java.util.Map;

public interface UserService {
    /**
     * 用户注册
     * @param user 用户信息
     * @param confirmPassword 确认密码
     * @return 注册结果
     */
    Map<String, Object> register(User user, String confirmPassword);

    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return 登录结果，包含用户信息
     */
    Map<String, Object> login(String username, String password);

    /**
     * 验证用户名唯一性
     * @param username 用户名
     * @return 如果用户名已存在返回true，否则返回false
     */
    boolean validateUsername(String username);

    /**
     * 根据用户ID获取用户详情
     * @param userId 用户ID
     * @return 用户信息
     */
    Map<String, Object> getUserById(int userId);

    /**
     * 更新用户信息
     * @param userId 用户ID
     * @param user 用户信息
     * @return 更新结果
     */
    Map<String, Object> updateUserInfo(int userId, User user);

    /**
     * 更改密码
     * @param userId 用户ID
     * @param currentPassword 当前密码
     * @param newPassword 新密码
     * @return 更改结果
     */
    Map<String, Object> changePassword(int userId, String currentPassword, String newPassword);
}

