package com.peng.hwmallservicedemo.service.user;

import com.peng.hwmallservicedemo.model.user.User;
import com.peng.hwmallservicedemo.repository.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Map<String, Object> register(User user, String confirmPassword) {
        Map<String, Object> result = new HashMap<>();

        String username = user.getUsername() != null ? user.getUsername().trim() : "";
        String rawPassword = user.getPassword() != null ? user.getPassword().trim() : "";
        String confirmPwd = confirmPassword != null ? confirmPassword.trim() : "";

        if (username.isEmpty()) {
            result.put("code", 400);
            result.put("message", "用户名不能为空");
            result.put("data", null);
            return result;
        }

        if (username.length() < 3) {
            result.put("code", 400);
            result.put("message", "用户名至少3个字符");
            result.put("data", null);
            return result;
        }

        if (rawPassword.isEmpty()) {
            result.put("code", 400);
            result.put("message", "密码不能为空");
            result.put("data", null);
            return result;
        }

        if (rawPassword.length() < 6) {
            result.put("code", 400);
            result.put("message", "密码至少6个字符");
            result.put("data", null);
            return result;
        }

        if (confirmPwd.isEmpty()) {
            result.put("code", 400);
            result.put("message", "请确认密码");
            result.put("data", null);
            return result;
        }

        if (!rawPassword.equals(confirmPwd)) {
            result.put("code", 400);
            result.put("message", "两次输入的密码不一致");
            result.put("data", null);
            return result;
        }

        if (userRepository.countByUsername(username) > 0) {
            result.put("code", 400);
            result.put("message", "用户名已存在");
            result.put("data", null);
            return result;
        }

        try {
            user.setUsername(username);
            user.setPassword(passwordEncoder.encode(rawPassword));
            String phone = user.getPhone() != null ? user.getPhone().trim() : null;
            user.setPhone(phone != null && phone.isEmpty() ? null : phone);
            String email = user.getEmail() != null ? user.getEmail().trim() : null;
            user.setEmail(email != null && email.isEmpty() ? null : email);

            // 保存用户信息
            int rows = userRepository.save(user);
            if (rows > 0) {
                result.put("code", 200);
                result.put("message", "注册成功");
                result.put("data", null);
            } else {
                result.put("code", 500);
                result.put("message", "注册失败");
                result.put("data", null);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "注册失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> login(String username, String password) {
        Map<String, Object> result = new HashMap<>();

        String usernameTrim = username != null ? username.trim() : "";
        String passwordTrim = password != null ? password.trim() : "";

        if (usernameTrim.isEmpty()) {
            result.put("code", 400);
            result.put("message", "用户名不能为空");
            result.put("data", null);
            return result;
        }

        if (passwordTrim.isEmpty()) {
            result.put("code", 400);
            result.put("message", "密码不能为空");
            result.put("data", null);
            return result;
        }

        try {
            // 根据用户名查询用户
            User user = userRepository.findByUsername(usernameTrim);
            if (user == null) {
                result.put("code", 400);
                result.put("message", "用户名或密码错误");
                result.put("data", null);
                return result;
            }

            // 验证密码
            if (!passwordEncoder.matches(passwordTrim, user.getPassword())) {
                result.put("code", 400);
                result.put("message", "用户名或密码错误");
                result.put("data", null);
                return result;
            }

            // 登录成功，返回用户信息（不包含密码）
            Map<String, Object> userData = new HashMap<>();
            userData.put("user_id", user.getUser_id());
            userData.put("userId", user.getUser_id());
            userData.put("username", user.getUsername());
            userData.put("phone", user.getPhone());
            userData.put("email", user.getEmail());
            userData.put("token", UUID.randomUUID().toString().replace("-", ""));

            result.put("code", 200);
            result.put("message", "登录成功");
            result.put("data", userData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "登录失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public boolean validateUsername(String username) {
        return userRepository.countByUsername(username) > 0;
    }

    @Override
    public Map<String, Object> getUserById(int userId) {
        Map<String, Object> result = new HashMap<>();

        try {
            User user = userRepository.findById(userId);
            if (user == null) {
                result.put("code", 404);
                result.put("message", "用户不存在");
                result.put("data", null);
                return result;
            }

            // 返回用户信息（不包含密码）
            Map<String, Object> userData = new HashMap<>();
            userData.put("user_id", user.getUser_id());
            userData.put("userId", user.getUser_id());
            userData.put("username", user.getUsername());
            userData.put("phone", user.getPhone());
            userData.put("email", user.getEmail());

            result.put("code", 200);
            result.put("message", "获取成功");
            result.put("data", userData);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "获取用户信息失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }

    @Override
    public Map<String, Object> updateUserInfo(int userId, User user) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 检查用户是否存在
            User existingUser = userRepository.findById(userId);
            if (existingUser == null) {
                result.put("code", 404);
                result.put("message", "用户不存在");
                result.put("data", null);
                return result;
            }

            user.setUser_id(userId);

            // 用户名处理
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                user.setUsername(existingUser.getUsername());
            } else {
                String newUsername = user.getUsername().trim();
                if (!newUsername.equals(existingUser.getUsername()) &&
                        userRepository.countByUsername(newUsername) > 0) {
                    result.put("code", 400);
                    result.put("message", "用户名已存在");
                    result.put("data", null);
                    return result;
                }
                user.setUsername(newUsername);
            }

            // 密码处理
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                user.setPassword(existingUser.getPassword());
            } else {
                String newPassword = user.getPassword().trim();
                if (newPassword.length() < 6) {
                    result.put("code", 400);
                    result.put("message", "密码至少6个字符");
                    result.put("data", null);
                    return result;
                }
                user.setPassword(passwordEncoder.encode(newPassword));
            }

            String phone = user.getPhone() != null ? user.getPhone().trim() : null;
            user.setPhone(phone != null && phone.isEmpty() ? null : phone);
            String email = user.getEmail() != null ? user.getEmail().trim() : null;
            user.setEmail(email != null && email.isEmpty() ? null : email);

            int rows = userRepository.updateUser(user);
            if (rows > 0) {
                result.put("code", 200);
                result.put("message", "更新成功");
                result.put("data", null);
            } else {
                result.put("code", 400);
                result.put("message", "更新失败");
                result.put("data", null);
            }
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "更新失败：" + e.getMessage());
            result.put("data", null);
        }

        return result;
    }
}

