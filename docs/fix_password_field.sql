-- 修复用户表 password 字段长度
-- BCrypt 加密后的密码通常是 60 个字符，设置为 255 以确保足够

-- 修改 password 字段长度为 255
ALTER TABLE `user` 
MODIFY COLUMN `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;

-- 验证修改（可选，用于检查）
-- DESCRIBE `user`;

