# CORS 跨域问题修复说明

## 🔧 问题描述

前端（运行在 `http://localhost:5174`）访问后端（运行在 `http://localhost:8080`）时，浏览器阻止了跨域请求，错误信息：
```
Access to XMLHttpRequest at 'http://localhost:8080/api/cart/add' from origin 'http://localhost:5174' 
has been blocked by CORS policy: Response to preflight request doesn't pass access control check: 
No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## ✅ 解决方案

已创建全局 CORS 配置类：`CorsConfig.java`

### 配置内容

- ✅ 允许所有源（`*`）- 开发环境使用
- ✅ 允许所有请求头
- ✅ 允许所有 HTTP 方法（GET、POST、PUT、DELETE 等）
- ✅ 预检请求缓存时间：3600 秒

## 🚀 使用步骤

### 1. 重启后端服务

**重要**：修改配置后必须重启后端服务才能生效！

```bash
# 停止当前运行的后端服务（Ctrl+C）
# 然后重新启动
cd service/hwMallServicedemo
mvn spring-boot:run
```

### 2. 刷新前端页面

在浏览器中刷新前端页面（`http://localhost:5174`），然后再次尝试添加商品到购物车。

### 3. 验证修复

- 打开浏览器开发者工具（F12）
- 切换到 Network 标签
- 尝试添加商品到购物车
- 检查请求是否成功（状态码应该是 200）
- 检查响应头中是否包含 `Access-Control-Allow-Origin`

## 📝 配置说明

### 当前配置（开发环境）

```java
config.addAllowedOriginPattern("*");  // 允许所有源
config.addAllowedHeader("*");         // 允许所有请求头
config.addAllowedMethod("*");         // 允许所有方法
```

### 生产环境建议

在生产环境中，应该指定具体的域名，而不是使用 `*`：

```java
// 允许特定域名
config.addAllowedOrigin("https://yourdomain.com");
config.addAllowedOrigin("https://www.yourdomain.com");
config.setAllowCredentials(true);  // 允许携带凭证
```

## 🔍 验证 CORS 配置

### 方法1：查看响应头

在浏览器开发者工具的 Network 标签中，查看请求的响应头，应该包含：
- `Access-Control-Allow-Origin: *`
- `Access-Control-Allow-Methods: *`
- `Access-Control-Allow-Headers: *`

### 方法2：使用 curl 测试

```bash
curl -X OPTIONS http://localhost:8080/api/cart/add \
  -H "Origin: http://localhost:5174" \
  -H "Access-Control-Request-Method: POST" \
  -v
```

应该看到响应头中包含 CORS 相关的头信息。

## ⚠️ 注意事项

1. **必须重启后端**：修改配置后必须重启 Spring Boot 应用
2. **清除浏览器缓存**：如果还有问题，尝试清除浏览器缓存或使用无痕模式
3. **检查端口**：确保前端和后端的端口号正确
4. **防火墙**：确保防火墙没有阻止 8080 端口

## 🐛 如果还有问题

### 问题1：重启后仍然报错

- 检查 `CorsConfig.java` 文件是否正确创建
- 检查文件是否在正确的包路径下：`com.peng.hwmallservicedemo.config`
- 查看后端启动日志，确认没有配置错误

### 问题2：部分接口仍然报错

- 检查 Controller 上是否有其他 CORS 配置冲突
- 确保所有 Controller 都使用相同的 CORS 配置

### 问题3：预检请求失败

- 检查 OPTIONS 请求是否被正确处理
- 查看后端日志，确认请求是否到达服务器

## 📚 相关文档

- [Spring CORS 官方文档](https://docs.spring.io/spring-framework/reference/web/webmvc-cors.html)
- [购物车测试指南](./购物车测试指南.md)


