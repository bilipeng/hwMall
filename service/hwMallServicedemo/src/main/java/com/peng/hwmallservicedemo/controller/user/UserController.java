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
            @RequestBody Map<String, String> request) {
        User user = new User();
        user.setUsername(request.getOrDefault("username", ""));
        user.setPassword(request.getOrDefault("password", ""));
        user.setPhone(request.getOrDefault("phone", ""));
        user.setEmail(request.getOrDefault("email", ""));

        return userService.updateUserInfo(userId, user);
    }
}

