-- ============================================
-- 快速测试数据（最小数据集）
-- ============================================
-- 如果只需要快速测试，执行这个文件即可
-- 包含：1个用户 + 1个分类 + 5个商品

USE hwmall_db;

-- 1. 插入商品分类（如果不存在）
INSERT INTO product_category (category_id, category_name, parent_id) VALUES
(1, '数码电子', 0)
ON DUPLICATE KEY UPDATE category_name=VALUES(category_name);

-- 2. 插入测试用户（如果不存在）
INSERT INTO user (user_id, username, password, phone, email) VALUES
(1, 'testuser', '123456', '13800138000', 'test@example.com')
ON DUPLICATE KEY UPDATE username=VALUES(username);

-- 3. 插入5个测试商品
INSERT INTO product (product_id, name, price, stock, description, category_id) VALUES
(1, '无线蓝牙耳机', 199.00, 100, '降噪设计，长续航，适合日常通勤与学习使用。', 1),
(2, '办公学习笔记本电脑', 4999.00, 50, '15.6 英寸窄边框屏幕，适合日常办公、网课与开发学习。', 1),
(3, '智能手机', 2999.00, 80, '高性能处理器，大容量存储，拍照清晰。', 1),
(4, '平板电脑', 1999.00, 60, '10.1英寸高清屏幕，适合学习和娱乐。', 1),
(5, '机械键盘', 299.00, 120, '青轴机械键盘，打字手感舒适。', 1)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 验证数据
SELECT '用户数据：' AS info;
SELECT user_id, username FROM user WHERE user_id = 1;

SELECT '商品数据：' AS info;
SELECT product_id, name, price, stock FROM product LIMIT 5;


