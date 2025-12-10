# Postman 测试指南 - 商品展示接口

## 一、准备工作

### 1. 启动后端服务

1. 确保 MySQL 数据库已启动，数据库 `hwmall_db` 已创建
2. 确保数据库中有 `product` 表和数据
3. 在 IDEA 中运行 `HwMallServicedemoApplication.java` 启动 Spring Boot 服务
4. 服务启动后，默认运行在：`http://localhost:8080`

### 2. 打开 Postman

- 如果没有安装 Postman，可以从官网下载：https://www.postman.com/downloads/

---

## 二、接口测试列表

### 接口1：根据商品ID查询商品详情

**请求方式：** `GET`

**请求URL：** `http://localhost:8080/api/product/{productId}`

**路径参数：**
- `productId`：商品ID（数字，例如：1）

**测试步骤：**
1. 在 Postman 中创建新请求
2. 选择请求方式为 `GET`
3. 输入URL：`http://localhost:8080/api/product/1`
4. 点击 `Send` 发送请求

**预期响应：**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "product_id": 1,
    "name": "商品名称",
    "price": 199.00,
    "stock": 100,
    "description": "商品描述",
    "category_id": 1
  }
}
```

**错误情况测试：**
- 测试不存在的商品ID：`http://localhost:8080/api/product/999`
- 预期返回：`code: 500, message: "商品不存在"`

---

### 接口2：查询所有商品（不分页）

**请求方式：** `GET`

**请求URL：** `http://localhost:8080/api/product/list`

**测试步骤：**
1. 选择请求方式为 `GET`
2. 输入URL：`http://localhost:8080/api/product/list`
3. 点击 `Send` 发送请求

**预期响应：**
```json
{
  "code": 200,
  "message": "success",
  "data": [
    {
      "product_id": 1,
      "name": "商品1",
      "price": 199.00,
      "stock": 100,
      "description": "描述1",
      "category_id": 1
    },
    {
      "product_id": 2,
      "name": "商品2",
      "price": 299.00,
      "stock": 50,
      "description": "描述2",
      "category_id": 2
    }
  ]
}
```

---

### 接口3：分页查询所有商品

**请求方式：** `GET`

**请求URL：** `http://localhost:8080/api/product/page`

**查询参数（Query Params）：**
- `page`：页码（可选，默认值：1）
- `pageSize`：每页数量（可选，默认值：10，最大：100）

**测试步骤：**
1. 选择请求方式为 `GET`
2. 输入URL：`http://localhost:8080/api/product/page`
3. 点击 `Params` 标签，添加参数：
   - Key: `page`, Value: `1`
   - Key: `pageSize`, Value: `10`
4. 点击 `Send` 发送请求

**或者直接在URL中写：**
```
http://localhost:8080/api/product/page?page=1&pageSize=10
```

**预期响应：**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "list": [
      {
        "product_id": 1,
        "name": "商品1",
        "price": 199.00,
        "stock": 100,
        "description": "描述1",
        "category_id": 1
      }
    ],
    "total": 50,
    "page": 1,
    "pageSize": 10,
    "totalPages": 5
  }
}
```

**测试用例：**
- 测试第2页：`?page=2&pageSize=10`
- 测试每页5条：`?page=1&pageSize=5`
- 测试无效页码：`?page=0` （预期返回错误）
- 测试超出限制：`?pageSize=200` （预期返回错误）

---

### 接口4：根据分类ID查询商品（不分页）

**请求方式：** `GET`

**请求URL：** `http://localhost:8080/api/product/category/{categoryId}`

**路径参数：**
- `categoryId`：分类ID（数字，例如：1）

**测试步骤：**
1. 选择请求方式为 `GET`
2. 输入URL：`http://localhost:8080/api/product/category/1`
3. 点击 `Send` 发送请求

**预期响应：**
```json
{
  "code": 200,
  "message": "success",
  "data": [
    {
      "product_id": 1,
      "name": "商品1",
      "price": 199.00,
      "stock": 100,
      "description": "描述1",
      "category_id": 1
    }
  ]
}
```

**错误情况测试：**
- 测试无效分类ID：`http://localhost:8080/api/product/category/0`
- 预期返回：`code: 400, message: "分类ID无效"`

---

### 接口5：根据分类ID分页查询商品

**请求方式：** `GET`

**请求URL：** `http://localhost:8080/api/product/category/{categoryId}/page`

**路径参数：**
- `categoryId`：分类ID（数字）

**查询参数（Query Params）：**
- `page`：页码（可选，默认值：1）
- `pageSize`：每页数量（可选，默认值：10）

**测试步骤：**
1. 选择请求方式为 `GET`
2. 输入URL：`http://localhost:8080/api/product/category/1/page`
3. 点击 `Params` 标签，添加参数：
   - Key: `page`, Value: `1`
   - Key: `pageSize`, Value: `10`
4. 点击 `Send` 发送请求

**或者直接在URL中写：**
```
http://localhost:8080/api/product/category/1/page?page=1&pageSize=10
```

**预期响应：**
```json
{
  "code": 200,
  "message": "success",
  "data": {
    "list": [
      {
        "product_id": 1,
        "name": "商品1",
        "price": 199.00,
        "stock": 100,
        "description": "描述1",
        "category_id": 1
      }
    ],
    "total": 10,
    "categoryId": 1,
    "page": 1,
    "pageSize": 10,
    "totalPages": 1
  }
}
```

---

## 三、Postman 使用技巧

### 1. 创建 Collection（集合）

1. 点击左侧 `Collections` → `+ New Collection`
2. 命名为 "商品管理接口"
3. 将所有请求保存到这个集合中，方便管理

### 2. 保存请求

1. 测试完接口后，点击 `Save` 按钮
2. 选择保存到 Collection
3. 给请求起个有意义的名字，例如："查询商品详情"

### 3. 设置环境变量

1. 点击右上角齿轮图标 → `Manage Environments` → `Add`
2. 创建环境变量：
   - `base_url`: `http://localhost:8080`
3. 在URL中使用：`{{base_url}}/api/product/list`

### 4. 查看响应

- **Pretty**：格式化显示 JSON
- **Raw**：原始响应
- **Preview**：预览模式
- **Headers**：查看响应头信息

---

## 四、常见问题排查

### 1. 连接失败（Connection refused）

**原因：** 后端服务未启动

**解决：** 
- 检查 Spring Boot 服务是否启动
- 查看控制台是否有错误信息
- 确认端口 8080 是否被占用

### 2. 404 Not Found

**原因：** URL 路径错误

**解决：**
- 检查 URL 是否正确：`http://localhost:8080/api/product/...`
- 确认 Controller 的 `@RequestMapping` 路径

### 3. 500 Internal Server Error

**原因：** 服务器内部错误

**解决：**
- 查看后端控制台错误日志
- 检查数据库连接是否正常
- 确认数据库表是否存在数据

### 4. 返回空数据

**原因：** 数据库中没有数据

**解决：**
- 检查数据库 `product` 表是否有数据
- 可以手动插入测试数据

---

## 五、测试数据准备（SQL）

如果数据库中没有数据，可以执行以下 SQL 插入测试数据：

```sql
-- 插入测试商品数据
INSERT INTO product (name, price, stock, description, category_id) VALUES
('无线蓝牙耳机', 199.00, 100, '降噪设计，长续航，适合日常通勤与学习使用。', 1),
('办公学习笔记本电脑', 4999.00, 50, '15.6 英寸窄边框屏幕，适合日常办公、网课与开发学习。', 1),
('人体工学电脑椅', 599.00, 80, '多档调节靠背与腰托，为长时间学习和办公提供支撑。', 2),
('简约学生书桌', 399.00, 60, '带收纳格的木质书桌，适合卧室、书房与出租屋使用。', 2),
('基础款运动卫衣', 129.00, 200, '宽松舒适，多色可选，适合校园日常穿搭。', 3);
```

---

## 六、快速测试清单

- [ ] 接口1：查询商品详情（ID=1）
- [ ] 接口1：查询不存在的商品（ID=999）
- [ ] 接口2：查询所有商品
- [ ] 接口3：分页查询（第1页，每页10条）
- [ ] 接口3：分页查询（第2页，每页5条）
- [ ] 接口3：测试无效参数（page=0）
- [ ] 接口4：按分类查询（categoryId=1）
- [ ] 接口5：按分类分页查询（categoryId=1, page=1, pageSize=10）

---

祝测试顺利！如有问题，请查看后端控制台日志获取详细错误信息。



