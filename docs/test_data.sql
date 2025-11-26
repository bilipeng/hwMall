-- ============================================
-- 购物车模块测试数据
-- ============================================
-- 使用前请确保数据库 hwmall_db 已创建
-- 执行前请先执行表结构创建脚本

USE hwmall_db;

-- ============================================
-- 1. 插入商品分类数据
-- ============================================
INSERT INTO product_category (category_id, category_name, parent_id) VALUES
(1, '数码电子', 0),
(2, '家居生活', 0),
(3, '服饰鞋包', 0),
(4, '美食零食', 0)
ON DUPLICATE KEY UPDATE category_name=VALUES(category_name);

-- ============================================
-- 2. 插入用户数据（如果还没有）
-- ============================================
INSERT INTO user (user_id, username, password, phone, email) VALUES
(1, 'testuser', '123456', '13800138000', 'test@example.com'),
(2, 'admin', 'admin123', '13900139000', 'admin@example.com')
ON DUPLICATE KEY UPDATE username=VALUES(username);

-- ============================================
-- 3. 插入商品数据
-- ============================================
-- 注意：如果商品表有外键约束，确保 category_id 对应的分类存在

-- 数码电子类商品
INSERT INTO product (product_id, name, price, stock, description, category_id) VALUES
(1, '无线蓝牙耳机', 199.00, 100, '降噪设计，长续航，适合日常通勤与学习使用。', 1),
(2, '办公学习笔记本电脑', 4999.00, 50, '15.6 英寸窄边框屏幕，适合日常办公、网课与开发学习。', 1),
(3, '智能手机', 2999.00, 80, '高性能处理器，大容量存储，拍照清晰。', 1),
(4, '平板电脑', 1999.00, 60, '10.1英寸高清屏幕，适合学习和娱乐。', 1),
(5, '机械键盘', 299.00, 120, '青轴机械键盘，打字手感舒适。', 1)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 家居生活类商品
INSERT INTO product (product_id, name, price, stock, description, category_id) VALUES
(6, '人体工学电脑椅', 599.00, 40, '多档调节靠背与腰托，为长时间学习和办公提供支撑。', 2),
(7, '简约学生书桌', 399.00, 30, '带收纳格的木质书桌，适合卧室、书房与出租屋使用。', 2),
(8, '保温杯', 89.00, 200, '长效保温，容量适中，适合上课、自习与通勤携带。', 2),
(9, '台灯', 129.00, 150, '护眼LED台灯，可调节亮度，适合学习使用。', 2),
(10, '收纳盒套装', 59.00, 100, '多规格收纳盒，整理桌面和宿舍必备。', 2)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 服饰鞋包类商品
INSERT INTO product (product_id, name, price, stock, description, category_id) VALUES
(11, '基础款运动卫衣', 129.00, 80, '宽松舒适，多色可选，适合校园日常穿搭。', 3),
(12, '轻便双肩包', 159.00, 60, '可放下 15.6 英寸电脑，适合通勤与出游。', 3),
(13, '运动鞋', 299.00, 50, '舒适透气，适合运动和日常穿着。', 3),
(14, '休闲T恤', 79.00, 100, '纯棉材质，多色可选，夏季必备。', 3),
(15, '牛仔裤', 199.00, 70, '经典款式，百搭单品。', 3)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- 美食零食类商品
INSERT INTO product (product_id, name, price, stock, description, category_id) VALUES
(16, '休闲坚果零食大礼包', 79.00, 200, '多种坚果组合装，适合宿舍分享或节日送礼。', 4),
(17, '巧克力礼盒', 99.00, 150, '精美包装，适合送人或自己享用。', 4),
(18, '咖啡豆', 89.00, 80, '精选咖啡豆，适合咖啡爱好者。', 4),
(19, '茶叶礼盒', 129.00, 100, '优质茶叶，包装精美。', 4),
(20, '零食大礼包', 59.00, 300, '多种零食组合，适合宿舍分享。', 4)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- ============================================
-- 4. 可选：插入一些购物车测试数据
-- ============================================
-- 如果想让购物车页面一开始就有数据，可以执行以下语句
-- 注意：确保 user_id=1 和对应的 product_id 存在

-- INSERT INTO cart (user_id, product_id, quantity) VALUES
-- (1, 1, 2),
-- (1, 6, 1),
-- (1, 11, 3)
-- ON DUPLICATE KEY UPDATE quantity=VALUES(quantity);

-- ============================================
-- 查询验证数据
-- ============================================
-- 执行以下查询语句验证数据是否插入成功

-- 查看用户数据
-- SELECT * FROM user;

-- 查看商品分类数据
-- SELECT * FROM product_category;

-- 查看商品数据
-- SELECT product_id, name, price, stock, category_id FROM product;

-- 查看购物车数据（如果有）
-- SELECT * FROM cart;


