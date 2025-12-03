package com.peng.hwmallservicedemo.model.user;

/**
 * 用户实体类
 */
public class User {
    private int user_id;
    private String username;
    private String password;
    private String phone;
    private String email;

    // 构造函数
    public User() {}

    public User(int user_id, String username, String password, String phone, String email) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.email = email;
    }

    // Getter 和 Setter 方法
    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User{" +
                "user_id=" + user_id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}

