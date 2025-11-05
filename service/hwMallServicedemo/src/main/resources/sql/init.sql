-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS hwmall_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE hwmall_db;

-- 创建用户表
CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户唯一标识',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    phone VARCHAR(20) COMMENT '手机号码',
    email VARCHAR(50) COMMENT '邮箱',
    created_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 插入测试数据
INSERT INTO user (username, password, phone, email) VALUES
('admin', '123456', '13800138000', 'admin@example.com'),
('testuser', 'password123', '13900139000', 'test@example.com')
ON DUPLICATE KEY UPDATE username=username;

-- 创建商品分类表
CREATE TABLE IF NOT EXISTS product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '分类唯一标识',
    category_name VARCHAR(50) NOT NULL COMMENT '分类名称',
    parent_id INT DEFAULT 0 COMMENT '父分类ID',
    created_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 创建商品表
CREATE TABLE IF NOT EXISTS product (
    product_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '商品唯一标识',
    name VARCHAR(100) NOT NULL COMMENT '商品名称',
    price DECIMAL(10,2) NOT NULL COMMENT '商品价格',
    stock INT NOT NULL DEFAULT 0 COMMENT '库存数量',
    description TEXT COMMENT '商品描述',
    category_id INT COMMENT '商品分类',
    created_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- 创建购物车表
CREATE TABLE IF NOT EXISTS cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '购物车唯一标识',
    user_id INT NOT NULL COMMENT '用户ID',
    product_id INT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL DEFAULT 1 COMMENT '购买数量',
    created_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    UNIQUE KEY unique_user_product (user_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 创建订单表
CREATE TABLE IF NOT EXISTS `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '订单唯一标识',
    user_id INT NOT NULL COMMENT '用户ID',
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单日期',
    total_amount DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    status VARCHAR(20) NOT NULL DEFAULT '待发货' COMMENT '订单状态',
    address TEXT COMMENT '收货地址',
    FOREIGN KEY (user_id) REFERENCES user(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 创建订单商品表
CREATE TABLE IF NOT EXISTS order_product (
    order_product_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '订单商品唯一标识',
    order_id INT NOT NULL COMMENT '订单ID',
    product_id INT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL COMMENT '商品数量',
    price DECIMAL(10,2) NOT NULL COMMENT '商品价格（下单时的价格）',
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品表';
