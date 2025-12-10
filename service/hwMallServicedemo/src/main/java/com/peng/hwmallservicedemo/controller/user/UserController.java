package com.peng.hwmallservicedemo.controller.user;

import com.peng.hwmallservicedemo.model.user.User;
import com.peng.hwmallservicedemo.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户注册
     * POST /api/users/register
     */
    @PostMapping("/register")
    public Map<String, Object> register(@RequestBody Map<String, String> request) {
        User user = new User();
        user.setUsername(request.getOrDefault("username", ""));
        user.setPassword(request.getOrDefault("password", ""));
        user.setPhone(request.getOrDefault("phone", ""));
        user.setEmail(request.getOrDefault("email", ""));

        String confirmPassword = request.getOrDefault("confirmPassword", "");

        return userService.register(user, confirmPassword);
    }

    /**
     * 用户登录
     * POST /api/users/login
     */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> request) {
        String username = request.getOrDefault("username", "");
        String password = request.getOrDefault("password", "");

        return userService.login(username, password);
    }

    /**
     * 获取用户信息
     * GET /api/users/:user_id
     */
    @GetMapping("/{user_id}")
    public Map<String, Object> getUserInfo(@PathVariable("user_id") int userId) {
        return userService.getUserById(userId);
    }

    /**
     * 更新用户信息
     * PUT /api/users/:user_id
     */
    @PutMapping("/{user_id}")
    public Map<String, Object> updateUserInfo(
            @PathVariable("user_id") int userId,
            @RequestBody Map<String, Object> request) {
        User user = new User();
        // 处理phone字段：如果存在则设置，否则为null
        if (request.containsKey("phone")) {
            Object phoneObj = request.get("phone");
            user.setPhone(phoneObj != null ? phoneObj.toString() : null);
        } else {
            user.setPhone(null); // 表示不更新此字段
        }
        // 处理email字段：如果存在则设置，否则为null
        if (request.containsKey("email")) {
            Object emailObj = request.get("email");
            user.setEmail(emailObj != null ? emailObj.toString() : null);
        } else {
            user.setEmail(null); // 表示不更新此字段
        }

        return userService.updateUserInfo(userId, user);
    }

    /**
     * 更改密码
     * POST /api/users/:user_id/change-password
     */
    @PostMapping("/{user_id}/change-password")
    public Map<String, Object> changePassword(
            @PathVariable("user_id") int userId,
            @RequestBody Map<String, String> request) {
        String currentPassword = request.getOrDefault("currentPassword", "");
        String newPassword = request.getOrDefault("newPassword", "");

        return userService.changePassword(userId, currentPassword, newPassword);
    }
}

