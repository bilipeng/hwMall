/*
 Navicat Premium Data Transfer

 Source Server         : mysqllocalhost
 Source Server Type    : MySQL
 Source Server Version : 80042
 Source Host           : localhost:3306
 Source Schema         : hwmall_db

 Target Server Type    : MySQL
 Target Server Version : 80042
 File Encoding         : 65001

 Date: 28/11/2025 18:57:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for order_product
-- ----------------------------
DROP TABLE IF EXISTS `order_product`;
CREATE TABLE `order_product`  (
  `order_product_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`order_product_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_product
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `stock` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `category_id` int NULL DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '家里泉雪山大屏矿泉净饮机家用即热式一体净水器小型台式饮水机', 3171.20, 88, '家里泉雪山大屏矿泉净饮机家用即热式一体净水器小型台式饮水机', 1, 'http://img.alicdn.com/img/i4/3173715591/O1CN01NcPABF1rAjTWdPi8X_!!4611686018427383431-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (2, 'Aqara绿米联创智能妙控开关S1E已接入米家HomeKit中控屏控制面板', 259.00, 97, 'Aqara绿米联创智能妙控开关S1E已接入米家HomeKit中控屏控制面板', 1, 'http://img.alicdn.com/img/i3/118747732/O1CN01jZbJvT26zJR1LBZ8R_!!4611686018427384404-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (3, '8H智能电动床主卧多功能双人床智能全自动床架真皮已接入米家APP', 2689.40, 66, '8H智能电动床主卧多功能双人床智能全自动床架真皮已接入米家APP', 1, 'http://img.alicdn.com/img/i3/125939777/O1CN01TCqRDZ2M5vPLUfPcO_!!4611686018427383873-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (4, '乔安摄像头门口免插电无线太阳能监控家用远程无需网络室内外高清', 117.30, 14, '乔安摄像头门口免插电无线太阳能监控家用远程无需网络室内外高清', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/724248411/O1CN01OP8xTo2C0INgk8RNT_!!4611686018427381595-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (5, '沃莱八电极体脂秤家用电子秤减肥专用智能精准体重秤健身房专用款', 299.00, 30, '沃莱八电极体脂秤家用电子秤减肥专用智能精准体重秤健身房专用款', 1, 'http://img.alicdn.com/img/i1/114659023/O1CN01jKn2Ap2GWam2aaZkk_!!4611686018427383503-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (6, '监控摄像头高清无线5gwifi家用手机远程家庭室内360度无死角摄影', 43.20, 36, '监控摄像头高清无线5gwifi家用手机远程家庭室内360度无死角摄影', 1, 'https://gw.alicdn.com/imgextra/O1CN01IEiCKG1XUcLUxeQsW_!!2216405312927.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (7, '新款拾音水母七彩香薰机自动喷香加湿器家用静音卧室大雾量吐圈', 105.00, 36, '新款拾音水母七彩香薰机自动喷香加湿器家用静音卧室大雾量吐圈', 1, 'http://img.alicdn.com/img/i3/3948346789/O1CN01iVPyUg201Pt7nPLQN_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (8, 'Aqara绿米智能筒灯射灯T3高显指防眩可调色温亮度HomeKit灯LED', 148.00, 49, 'Aqara绿米智能筒灯射灯T3高显指防眩可调色温亮度HomeKit灯LED', 1, 'https://img.alicdn.com/imgextra/i3/2210323128771/O1CN01QHAc0H2EfAw170MVe_!!2210323128771-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (9, '简约现代智能床头柜家用卧室多功能无线充电带锁带灯实木轻奢边柜 智能', 168.00, 11, '简约现代智能床头柜家用卧室多功能无线充电带锁带灯实木轻奢边柜 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2216700830491/O1CN01WxINpc1FUvNgBM8De_!!2216700830491.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (10, '高端全金属空气净化烟灰缸，吸烟不再打扰别人了！', 208.00, 66, '高端全金属空气净化烟灰缸，吸烟不再打扰别人了！', 1, 'https://img.alicdn.com/imgextra/i3/2206371909258/O1CN01HfantD2IGDooUFYDK_!!2206371909258-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (11, '小米室外摄像机CW500双摄监控器家用户外门口远程手机摄影头全景', 254.15, 46, '小米室外摄像机CW500双摄监控器家用户外门口远程手机摄影头全景', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/1714128138/O1CN012RHZ5o29zGCyiAo6j_!!4611686018427381002-2-item_pic.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (12, 'Aqara绿米流光溢彩灯带T1 Zigbee彩光氛围led智能HomeKit灯带套装', 43.00, 51, 'Aqara绿米流光溢彩灯带T1 Zigbee彩光氛围led智能HomeKit灯带套装', 1, 'http://img.alicdn.com/img/i4/1608790065/O1CN01SBBkoZ1CLojsv7G4K_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (13, '鸿蒙智选海雀智能摄像头监控家用手机远程无线摄影头适用华为苹果 智能', 152.15, 37, '鸿蒙智选海雀智能摄像头监控家用手机远程无线摄影头适用华为苹果 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2213264531172/O1CN01v9ctx01KWpGJ7HfgW_!!4611686018427387620-2-item_pic.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (14, '森肽基高浓度森林氧吧空气负离子发生器家用蛋小粒径多功能空气净化器', 3580.00, 12, '森肽基高浓度森林氧吧空气负离子发生器家用蛋小粒径多功能空气净化器', 1, 'https://img.alicdn.com/imgextra/i1/2211670200449/O1CN01YDYlVB1FBgrRF37LO_!!2211670200449-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (15, 'Aqara绿米智能开关H1 Pro零火版墙壁控制面板HomeKit远程遥控开关', 439.00, 100, 'Aqara绿米智能开关H1 Pro零火版墙壁控制面板HomeKit远程遥控开关', 1, 'http://img.alicdn.com/img/i4/694880175/O1CN01vlCCF61DACNdbn7Y4_!!4611686018427381679-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (16, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 0.59, 53, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2214646061627/O1CN01xL4Vty1NtDO6HCgi8_!!2214646061627.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (17, '洗手液自动感应器泡沫洗手机电动洗洁精感应洗手液器自动洗手液机', 120.83, 53, '洗手液自动感应器泡沫洗手机电动洗洁精感应洗手液器自动洗手液机', 1, 'http://img.alicdn.com/img/i2/3405588160/O1CN01JQziYH2A9KtWUTBh8_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (18, '虎牌保险柜箱智能床头柜一体家用防盗无线充电现代多功能2024新款 智能', 550.00, 61, '虎牌保险柜箱智能床头柜一体家用防盗无线充电现代多功能2024新款 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2216339102032/O1CN01J74YeL1Qshi1T0GH0_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (19, '沃莱八电极体脂秤电子秤家用体重秤减肥专用智能精准体脂测量P6', 299.00, 37, '沃莱八电极体脂秤电子秤家用体重秤减肥专用智能精准体脂测量P6', 1, 'http://img.alicdn.com/img/i1/114659023/O1CN01CDNPgi2GWaldg5wnb_!!4611686018427383503-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (20, '米家全屋智能家居控制系统套装全屋开关定制设计方案别墅家庭接入 智能 家居', 9.90, 69, '米家全屋智能家居控制系统套装全屋开关定制设计方案别墅家庭接入 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2219955550039/O1CN013CVj7q1C9uVY752Rj_!!2219955550039.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (21, '接入米家智能家居套装小爱同学控制全屋系统定制上门安装调试窗帘 智能 家居', 1980.00, 72, '接入米家智能家居套装小爱同学控制全屋系统定制上门安装调试窗帘 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2219580275145/O1CN01zFILat1nsSp06QXDR_!!2219580275145.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (22, '绿米aqara智能卷帘伴侣e1电动百叶升降HomeKit窗帘器已接入米家', 304.00, 18, '绿米aqara智能卷帘伴侣e1电动百叶升降HomeKit窗帘器已接入米家', 1, 'https://img.alicdn.com/imgextra/i1/2206670235094/O1CN01TRSTOM1nV6ar4nFlN_!!2206670235094-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (23, '米家小米全屋智能家居控制系统套装家庭定制设计灯光上门安装调试 智能 家居', 89.10, 11, '米家小米全屋智能家居控制系统套装家庭定制设计灯光上门安装调试 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/1741348996/O1CN01uOkp8T2GKE4nn8wYK_!!1741348996.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (24, '小米米家全屋智能家居控制系统套装别墅家庭智能窗帘灯光定制设计 智能 家居 智能', 29.90, 85, '小米米家全屋智能家居控制系统套装别墅家庭智能窗帘灯光定制设计 智能 家居 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2218517382418/O1CN01ORXnL71TjUfsLy814_!!2218517382418.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (25, '接入小米米家全屋智能家居控制系统套装智能窗帘灯控设计方案定制 智能 家居 智能', 19.90, 60, '接入小米米家全屋智能家居控制系统套装智能窗帘灯控设计方案定制 智能 家居 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2213277851117/O1CN01DV6AVh1K7dSqlvKXz_!!2213277851117.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (26, '海尔室外摄像头高清夜视360度无死角家用户外手机远程监控器摄影', 118.15, 14, '海尔室外摄像头高清夜视360度无死角家用户外手机远程监控器摄影', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/2213757439711/O1CN01NMlp3q2LbhFS9vmwW_!!4611686018427383519-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (27, '2025小米全屋智能家居设计方案点位布局全屋智能灯具空调设备布置 智能 家居 智能', 0.98, 13, '2025小米全屋智能家居设计方案点位布局全屋智能灯具空调设备布置 智能 家居 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3179860469/O1CN01CwqJ8v1FKqnunFZHc_!!3179860469.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (28, '智能空调伴侣WIFI版手机远程控制空调红外遥控器已接入米家APP 智能', 28.04, 92, '智能空调伴侣WIFI版手机远程控制空调红外遥控器已接入米家APP 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/868385472/O1CN01XJgWMN1qIEL57LFb1_!!868385472.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (29, '联想无线摄像头360度无死角手机远程家用监控器智能高清夜视摄影 智能', 57.80, 18, '联想无线摄像头360度无死角手机远程家用监控器智能高清夜视摄影 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/3378811475/O1CN01cCWFFo1MlbGlD7OYE_!!4611686018427384403-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (30, '智能香薰机自动持久喷香室内家用已接入米家APP厕所壁挂除臭神器 智能', 49.00, 43, '智能香薰机自动持久喷香室内家用已接入米家APP厕所壁挂除臭神器 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2709926677/O1CN01qMqGGs1zC7b8lbgwy_!!2709926677.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (31, '摄像头免插电无线家用手机远程无需网络室内高清智能摄影录像监控 智能', 124.00, 74, '摄像头免插电无线家用手机远程无需网络室内高清智能摄影录像监控 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2212383615705/O1CN017rWv2a1s0wcV9Q6yU_!!4611686018427382489-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (32, '空调扇冷风机制冷风扇家用小型落地冷气移动电静音2025新款水神器', 168.00, 88, '空调扇冷风机制冷风扇家用小型落地冷气移动电静音2025新款水神器', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2218449446963/O1CN01aPNeXQ21J6sRjbSnP_!!4611686018427381811-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (33, '宠物空气净化器全自动吸猫毛神器养猫专用吸毛器家用除甲醛吸附去', 328.00, 62, '宠物空气净化器全自动吸猫毛神器养猫专用吸毛器家用除甲醛吸附去', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2217127008986/O1CN01f4NiY82GFe79FJgBo_!!4611686018427386586-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (34, '计时器学习学生自律做题厨房闹钟专用儿童定时两用秒表时间管理倒', 6.54, 58, '计时器学习学生自律做题厨房闹钟专用儿童定时两用秒表时间管理倒', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2212340438729/O1CN01gWffeG2ELwIlgNXMO_!!4611686018427385545-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (35, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 6.98, 78, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/3432169591/O1CN01AYYoBg2KijZp1w1uy_!!3432169591.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (36, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 0.38, 83, '小米智能家居室内家装设计全屋施工落地解决方案智能开关灯具空调 智能 家居 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2209123886734/O1CN01pCNVyn1zcEAE8TXlO_!!2209123886734.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (37, '全屋智能家居系统米家智能家居系统语音智能开关控制面板智能窗帘 智能 家居 智能 家居 智能 智能', 9.90, 43, '全屋智能家居系统米家智能家居系统语音智能开关控制面板智能窗帘 智能 家居 智能 家居 智能 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2209296931355/O1CN01TjRXZC1LsdivncQYE_!!2209296931355.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (38, '人体感应小夜灯智能充电式声控灯家用无线过道墙壁起夜楼道感应灯 智能', 5.79, 37, '人体感应小夜灯智能充电式声控灯家用无线过道墙壁起夜楼道感应灯 智能', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2216907268244/O1CN01PXLB1O2AloCtX3dxZ_!!2216907268244.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (39, '小米全屋智能家居控制系统套装定制米家绿米涂鸦灯光照明设计方案 智能 家居', 199.00, 67, '小米全屋智能家居控制系统套装定制米家绿米涂鸦灯光照明设计方案 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2217884091046/O1CN01icU7WE1Jb7KRLwpl4_!!2217884091046.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (40, '联想可视门铃电子智能猫眼防盗门口监控摄像头家用无线360度全景 智能', 163.00, 48, '联想可视门铃电子智能猫眼防盗门口监控摄像头家用无线360度全景 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3378811475/O1CN01xhXIXW1MlbGlWoNQg_!!4611686018427384403-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (41, '现代手机店苹果华为小米专卖店数码店体验店营业厅智能家居SU模型 智能 家居', 0.36, 68, '现代手机店苹果华为小米专卖店数码店体验店营业厅智能家居SU模型 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2216063606524/O1CN01ZJ1qrc1y42pyOTZp3_!!2216063606524.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (42, '小米米家插座插排插线板带线多孔家用多功能多插位转换器 旗舰店', 37.41, 77, '小米米家插座插排插线板带线多孔家用多功能多插位转换器 旗舰店', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2214061515880/O1CN01LTvxkL1tJ5uPWnf0z_!!4611686018427380840-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (43, '小米智能家居家装家居设计全屋施工落地解决方案智能开关灯具空调 智能 家居 家居 智能', 2.32, 79, '小米智能家居家装家居设计全屋施工落地解决方案智能开关灯具空调 智能 家居 家居 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2219751022316/O1CN0186b5sn1SymLY8SORY_!!2219751022316.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (44, '国际电工嵌入式带开关洗衣机隐形插座内凹防水插座隐藏浅形凹槽式', 2.69, 61, '国际电工嵌入式带开关洗衣机隐形插座内凹防水插座隐藏浅形凹槽式', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/2215576420081/O1CN01cdimur1CT91zWb8r4_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (45, '空气清新剂香薰机自动喷扩香厕所去异味室内家用持久高级卧室留香', 12.62, 59, '空气清新剂香薰机自动喷扩香厕所去异味室内家用持久高级卧室留香', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2212340438729/O1CN0143RRt12ELwJv47vi4_!!4611686018427385545-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (46, '适用于小米米家全屋智能家居系统套装定制设计方案上门安装调试 智能 家居', 178.00, 23, '适用于小米米家全屋智能家居系统套装定制设计方案上门安装调试 智能 家居', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2215450239583/O1CN01tR1zLp2Kf4ZK7EPJk_!!2215450239583.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (47, '日本智能马桶一体式全自动坐便双水路海水咸水香港墙排后排小户型', 1888.00, 22, '日本智能马桶一体式全自动坐便双水路海水咸水香港墙排后排小户型', 1, 'http://img.alicdn.com/img/i1/1588540091/O1CN01fOHHJf1CXj5SAMCHS_!!4611686018427384507-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (48, '家里泉雪山大屏矿泉净饮机家用即热式一体净水器小型台式饮水机', 3171.20, 30, '家里泉雪山大屏矿泉净饮机家用即热式一体净水器小型台式饮水机', 1, 'http://img.alicdn.com/img/i4/3173715591/O1CN01NcPABF1rAjTWdPi8X_!!4611686018427383431-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (49, 'Aqara绿米联创智能妙控开关S1E已接入米家HomeKit中控屏控制面板', 259.00, 38, 'Aqara绿米联创智能妙控开关S1E已接入米家HomeKit中控屏控制面板', 1, 'http://img.alicdn.com/img/i3/118747732/O1CN01jZbJvT26zJR1LBZ8R_!!4611686018427384404-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (50, '饭菜保温菜罩家用神器可插电加热冬天冬季恒温箱食品商用展示柜', 328.00, 94, '饭菜保温菜罩家用神器可插电加热冬天冬季恒温箱食品商用展示柜', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/2112332109/O1CN01QBt8tJ1RRyH4M1xN9_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (51, '【全国上门安装调试】小米智能家居全屋定制套装', 97.00, 20, '【全国上门安装调试】小米智能家居全屋定制套装', 1, 'http://img.alicdn.com/img/i4/129378798/O1CN01TAJqx72ErXeXXYjGN_!!4611686018427382254-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (52, '亿家好太太手摇晾衣架阳台家用手动四杆晒衣长杆室内自动折叠升降', 154.60, 55, '亿家好太太手摇晾衣架阳台家用手动四杆晒衣长杆室内自动折叠升降', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2218842568239/O1CN01RHahTA2AjWEQQz279_!!4611686018427385391-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (53, 'Aqara绿米智能开关H1 Pro零火版墙壁控制面板HomeKit远程遥控开关', 439.00, 92, 'Aqara绿米智能开关H1 Pro零火版墙壁控制面板HomeKit远程遥控开关', 1, 'http://img.alicdn.com/img/i4/694880175/O1CN01vlCCF61DACNdbn7Y4_!!4611686018427381679-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (54, '全国上门安装调试！小米智能家居全屋定制', 99.00, 45, '全国上门安装调试！小米智能家居全屋定制', 1, 'http://img.alicdn.com/img/i3/127607551/O1CN01hvFY5625ePkXQFlKg_!!4611686018427380479-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (55, '无线监控摄像头免插电楼道门口家用手机远程室内智能超清私密猫眼 智能', 59.00, 34, '无线监控摄像头免插电楼道门口家用手机远程室内智能超清私密猫眼 智能', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1TMGHE81ZB2dfZgBwD_!!392193155-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (56, 'Aqara绿米流光溢彩灯带T1 Zigbee彩光氛围led智能HomeKit灯带套装', 43.00, 28, 'Aqara绿米流光溢彩灯带T1 Zigbee彩光氛围led智能HomeKit灯带套装', 1, 'http://img.alicdn.com/img/i4/1608790065/O1CN01SBBkoZ1CLojsv7G4K_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (57, '新款床头小吊灯背景电视墙玄关卧室高级感升降感应简约装饰氛围灯', 148.00, 69, '新款床头小吊灯背景电视墙玄关卧室高级感升降感应简约装饰氛围灯', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2216620109570/O1CN01aWIqBh2KZ7OFlCxoT_!!2216620109570.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (58, 'Aqara绿米智能筒灯射灯T3高显指防眩可调色温亮度HomeKit灯LED', 148.00, 78, 'Aqara绿米智能筒灯射灯T3高显指防眩可调色温亮度HomeKit灯LED', 1, 'https://img.alicdn.com/imgextra/i3/2210323128771/O1CN01QHAc0H2EfAw170MVe_!!2210323128771-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (59, '4G无线室户外摄像头360度无死角手机远程高清变焦全景夜视监控器', 575.00, 66, '4G无线室户外摄像头360度无死角手机远程高清变焦全景夜视监控器', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/822389589/O1CN01ffIaet2KhowWYE9KZ_!!4611686018427382613-2-item_pic.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (60, '看家王wifi无线双向可视频通话监控家用远程手机带语音摄像头老人婴儿看护器360度无死角智能夜视摄像机', 273.83, 35, '看家王wifi无线双向可视频通话监控家用远程手机带语音摄像头老人婴儿看护器360度无死角智能夜视摄像机', 1, 'http://img.alicdn.com/img/i3/6205268604/O1CN014ZedYD2DQgkpP5Dys_!!4611686018427380348-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (61, '海外版香港澳门免费试用华为手机投影仪4K超高清便携智能家用无线wifi手机投屏卧室投墙户外家庭娱乐迷你1080p海外版投影机', 899.00, 19, '海外版香港澳门免费试用华为手机投影仪4K超高清便携智能家用无线wifi手机投屏卧室投墙户外家庭娱乐迷你1080p海外版投影机', 1, 'https://img.alicdn.com/imgextra/i2/3680811610/O1CN013ykspX1NlQjI3MnEv_!!3680811610-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (62, '小米室外摄像机BW500高清户外摄像头无线夜视监控手机远程广角', 329.00, 79, '小米室外摄像机BW500高清户外摄像头无线夜视监控手机远程广角', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1V5qkDf1wQpTJS7GAI_!!398056303-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (63, 'koble双电机电动升降桌家用电脑桌钢化玻璃办公桌智能书桌学习桌', 1294.00, 65, 'koble双电机电动升降桌家用电脑桌钢化玻璃办公桌智能书桌学习桌', 1, 'http://img.alicdn.com/img/i2/1967860113/O1CN019Dusj01Chnp5pYXD4_!!4611686018427382161-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (64, '智能恒温自动加热折叠泡澡桶大人专用洗澡桶家用小孩婴儿童浴桶 智能', 99.00, 86, '智能恒温自动加热折叠泡澡桶大人专用洗澡桶家用小孩婴儿童浴桶 智能', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/2219189404254/O1CN01CAYtyl1hINuabDu8l_!!4611686018427380318-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (65, '智能床头柜保险箱多功能现代轻奢简约免安装家用卧室无线充床边柜', 249.00, 72, '智能床头柜保险箱多功能现代轻奢简约免安装家用卧室无线充床边柜', 1, 'http://img.alicdn.com/img/i4/110497757/O1CN013Tqsvc27AlKccfclu_!!4611686018427383773-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (66, '手环手表呼叫器随身无线防水远距离老人一键紧急报警遥控平安钟', 47.96, 12, '手环手表呼叫器随身无线防水远距离老人一键紧急报警遥控平安钟', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/1733578638/O1CN01USmZkf2DgG9E2nfly_!!1733578638.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (67, '电动护理床全自动家用老人智能自动翻身瘫痪病人多功能专用医疗床 智能', 1057.03, 61, '电动护理床全自动家用老人智能自动翻身瘫痪病人多功能专用医疗床 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2216005621734/O1CN01yYF16V1OgDqPz5ZG2_!!4611686018427385830-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (68, '森肽基高浓度森林氧吧空气负离子发生器家用蛋小粒径多功能空气净化器', 3580.00, 28, '森肽基高浓度森林氧吧空气负离子发生器家用蛋小粒径多功能空气净化器', 1, 'https://img.alicdn.com/imgextra/i1/2211670200449/O1CN01YDYlVB1FBgrRF37LO_!!2211670200449-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (69, '太太乐一线天隐形晾衣架隐藏式暗藏式嵌入阳台电动升降智能晒衣杆 智能', 677.76, 44, '太太乐一线天隐形晾衣架隐藏式暗藏式嵌入阳台电动升降智能晒衣杆 智能', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2986418383/O1CN01BN23kU2BnTD9fTpKl_!!2986418383.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (70, '超薄隐形电动晾衣架自动遥控升降智能阳台伸缩小尺寸嵌入晾衣杆机 智能', 399.00, 53, '超薄隐形电动晾衣架自动遥控升降智能阳台伸缩小尺寸嵌入晾衣杆机 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2217259109250/O1CN01AJ0g0d2ICYg6rZDFY_!!4611686018427382658-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (71, '全自动污水提升器地下室厨房马桶粉碎机电动抽水排污泵智能上排 智能', 269.00, 31, '全自动污水提升器地下室厨房马桶粉碎机电动抽水排污泵智能上排 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2062223829/O1CN01byalcG1e9jYVQQB2H_!!2062223829.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (72, '360摄像头门口免插电无线太阳能监控家用远程无需网络室内外高清', 159.00, 45, '360摄像头门口免插电无线太阳能监控家用远程无需网络室内外高清', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1mORwuX24Yd8pUg2lW_!!2003267403-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (73, 'IOTOT自动感应小便池嵌入式小便斗男士小便器落地式家用酒店尿斗', 558.00, 31, 'IOTOT自动感应小便池嵌入式小便斗男士小便器落地式家用酒店尿斗', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2217191948972/O1CN01z57lkL2G9EVEaOld6_!!2217191948972.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (74, '技师震动手环防水手表紧急报警器足疗店遥控振动手环会所洗浴中心一键报警器按摩店无线呼叫器棋牌室提醒腕表', 53.35, 13, '技师震动手环防水手表紧急报警器足疗店遥控振动手环会所洗浴中心一键报警器按摩店无线呼叫器棋牌室提醒腕表', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2212968269570/O1CN01ZqIx3S2KZ7MG3EIgN_!!4611686018427381506-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (75, '扬子断电洗浴移动式热水器储水即热式速热电热水器节能简易洗澡机', 248.00, 93, '扬子断电洗浴移动式热水器储水即热式速热电热水器节能简易洗澡机', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/3446766387/O1CN01Ovwuti1x3IdQ04oij_!!3446766387.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (76, '扬子节能简易洗澡机移动式热水器储水即热式速热电热水器断电淋浴', 248.00, 32, '扬子节能简易洗澡机移动式热水器储水即热式速热电热水器断电淋浴', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3446766387/O1CN01zlsMfx1x3IelzXY56_!!3446766387.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (77, '小米米家即热饮水机S1家用小型桌面台式免安装接桶装水直饮烧水壶', 249.00, 41, '小米米家即热饮水机S1家用小型桌面台式免安装接桶装水直饮烧水壶', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1pKeyeL1wQpTJRm6j6_!!398056303-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (78, '摄像头监控器家用手机远程免插电无线室外无需wifi门口店铺带语音', 148.00, 53, '摄像头监控器家用手机远程免插电无线室外无需wifi门口店铺带语音', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2214244751221/O1CN01rV1swY1KtGYwRzj9y_!!2-item_pic.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (79, '正品小户型智能马桶58cm小尺寸一体式全自动翻盖无水压短款坐便器 智能', 780.00, 53, '正品小户型智能马桶58cm小尺寸一体式全自动翻盖无水压短款坐便器 智能', 1, 'https://gw.alicdn.com/imgextra/O1CN01MwadeY2IKnnPitzVq_!!2207581169268-0-picasso.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (80, '威力多功能取暖茶几烤火桌家用长方形一体升降电取暖桌省电火炉子', 698.00, 10, '威力多功能取暖茶几烤火桌家用长方形一体升降电取暖桌省电火炉子', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2217870443459/O1CN01YDiyyE1bQGyeOf8E4_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (81, '庭大师户外庭院铝合金凉亭可伸缩凉棚防风遮阳智能室外生态阳光房 智能', 400.00, 16, '庭大师户外庭院铝合金凉亭可伸缩凉棚防风遮阳智能室外生态阳光房 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2219429391498/O1CN01NkWcvI1Mw8LXs4Ru1_!!4611686018427382922-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (82, '云舒居家养老床老人家用全自动智能带扶手升降适老电动遥控护理床 智能', 169.00, 23, '云舒居家养老床老人家用全自动智能带扶手升降适老电动遥控护理床 智能', 1, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2216992480073/O1CN01GW7U9h1CPTyqiXvwq_!!2216992480073.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (83, '小米米家智能蒸发式冷风扇制冷空调扇水冷抑菌家用降温落地扇抑菌 智能', 649.00, 32, '小米米家智能蒸发式冷风扇制冷空调扇水冷抑菌家用降温落地扇抑菌 智能', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1e3gTQD1wQpTJS9L5R_!!398056303-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (84, '黑金刚沙发智能语音电动伸缩多功能小户型客厅意式轻奢牛皮沙发床 智能', 3480.00, 67, '黑金刚沙发智能语音电动伸缩多功能小户型客厅意式轻奢牛皮沙发床 智能', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1R08vsJ1KD8EAqe2Lw_!!3340161129-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (85, '德国鞋套机新款家用2025新款防滑自动智能鞋膜机一次性踩脚鞋模机 智能', 666.00, 52, '德国鞋套机新款家用2025新款防滑自动智能鞋膜机一次性踩脚鞋模机 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2219343585004/O1CN01Akindt1mpsx8cYltn_!!2219343585004.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (86, '鞋套机自动家用新款拖拉式一次性脚套器工厂车间全自动套鞋机智能 智能', 238.00, 16, '鞋套机自动家用新款拖拉式一次性脚套器工厂车间全自动套鞋机智能 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/1954184726/O1CN01153AAq1kmYlBFRPCs_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (87, '哆嗳智能电子猫眼防盗门监控摄像头入户门可视门铃带显示屏 智能', 109.00, 38, '哆嗳智能电子猫眼防盗门监控摄像头入户门可视门铃带显示屏 智能', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2216976341231/O1CN01HStXvf1KxqUMdGzkz_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (88, '正品全新款智能马桶超静音冲水带机械冲水按键家用马桶座便 智能', 964.00, 91, '正品全新款智能马桶超静音冲水带机械冲水按键家用马桶座便 智能', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1GOxHe72IKnnKK97lg_!!2207581169268-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (89, '德国帷沃斯负离子空气净化器家用去甲醛除烟味粉尘异味杀菌消毒机', 668.00, 100, '德国帷沃斯负离子空气净化器家用去甲醛除烟味粉尘异味杀菌消毒机', 1, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2263046991/O1CN01NdtSmO21VvxcPxuiS_!!2263046991.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (90, '华为新款3.7手机体验台靠墙配件边柜智能家居笔记本展示柜收银台 智能 家居', 500.00, 79, '华为新款3.7手机体验台靠墙配件边柜智能家居笔记本展示柜收银台 智能 家居', 1, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/1625657750/O1CN017kmNOf277YPAHOJY7_!!1625657750.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (91, '正品智能马桶坐便器全自动翻盖一体式家用无水压限制座便器轻智能 智能 智能', 488.00, 32, '正品智能马桶坐便器全自动翻盖一体式家用无水压限制座便器轻智能 智能 智能', 1, 'https://picasso.alicdn.com/imgextra/O1CNA1oPONzN2IKnnGt04VM_!!2207581169268-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (92, '4g摄像头终身免费流量室内监控器360度家用手机远程无需网络摄影', 108.00, 71, '4g摄像头终身免费流量室内监控器360度家用手机远程无需网络摄影', 1, 'https://gw.alicdn.com/imgextra/O1CN01IZLmu01XUcLwREHgX_!!2216405312927.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (93, 'Hylaeion热带雨林户外运动防风防泼水登山外套女秋季休闲连帽外套', 438.00, 66, 'Hylaeion热带雨林户外运动防风防泼水登山外套女秋季休闲连帽外套', 2, 'http://img.alicdn.com/img/i1/7045106242/O1CN01xL8g7A1vytJXBIcd0_!!4611686018427382338-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (94, 'Hylaeion热带雨林户外运动半拉链立领长袖锦纶T恤春季休闲修身女', 228.00, 90, 'Hylaeion热带雨林户外运动半拉链立领长袖锦纶T恤春季休闲修身女', 2, 'http://img.alicdn.com/img/i4/7045106242/O1CN01EWGNEb1vytIwufM5I_!!4611686018427382338-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (95, '紫色户外冰丝速干短袖男款夏季龙鳞激光打孔运动t恤透气凉感半袖 户外 运动', 39.96, 19, '紫色户外冰丝速干短袖男款夏季龙鳞激光打孔运动t恤透气凉感半袖 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/4053571766/O1CN01kMTXpf1OusWFySdEx_!!4611686018427386038-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (96, '李宁逸界2.0 v2丨徒步鞋男女鞋户外防滑透气登山稳定跑步鞋运动鞋', 378.00, 37, '李宁逸界2.0 v2丨徒步鞋男女鞋户外防滑透气登山稳定跑步鞋运动鞋', 2, 'http://img.alicdn.com/img/i4/12974530/O1CN01Ke3acZ1jKnFZT0BAW_!!4611686018427386306-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (97, '户外折叠躺椅三档可调节野营便携式野餐露营椅子办公室午休折叠床 户外', 70.00, 51, '户外折叠躺椅三档可调节野营便携式野餐露营椅子办公室午休折叠床 户外', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2215908331785/O1CN01ADdcj71P3a2w4Id9p_!!4611686018427384073-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (98, '悟空有货美式潮牌条纹机能风运动裤男复古宽松户外阔腿百搭休闲裤', 58.10, 81, '悟空有货美式潮牌条纹机能风运动裤男复古宽松户外阔腿百搭休闲裤', 2, 'http://img.alicdn.com/img/i4/112044131/O1CN01gAcV5X1gO3DcjJHT5_!!4611686018427381859-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (99, 'WASSUP ERIKA夏季速干冰丝短裤男户外潮牌黑色五分裤休闲运动中裤 户外 运动', 52.20, 25, 'WASSUP ERIKA夏季速干冰丝短裤男户外潮牌黑色五分裤休闲运动中裤 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/3270715789/O1CN01egPWOE1sdPmnhiT0s_!!3270715789.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (100, '官方正品ON运动裤男子夏季训练跑步透气速干健身裤休闲户外长裤子', 498.00, 44, '官方正品ON运动裤男子夏季训练跑步透气速干健身裤休闲户外长裤子', 2, 'http://img.alicdn.com/img/i4/7012234638/O1CN01YXMisT1k8G1apVJ6W_!!4611686018427385230-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (101, '美式速干多巴胺短裤男女夏季薄款潮牌百搭运动裤沙滩阔腿五分裤子 运动', 41.10, 97, '美式速干多巴胺短裤男女夏季薄款潮牌百搭运动裤沙滩阔腿五分裤子 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2214295046324/O1CN015KeMcg1waRlKxLavv_!!4611686018427381940-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (102, '户外折叠椅子便携式超轻折叠凳子钓鱼椅露营靠背坐椅野营板凳马扎 户外', 8.82, 21, '户外折叠椅子便携式超轻折叠凳子钓鱼椅露营靠背坐椅野营板凳马扎 户外', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/748906550/O1CN01JARTMB1yFxETh1gRu_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (103, '熊猫工装裤休闲裤女2025新款防泼水户外伞兵速干阔腿防晒运动裤长', 219.00, 75, '熊猫工装裤休闲裤女2025新款防泼水户外伞兵速干阔腿防晒运动裤长', 2, 'http://img.alicdn.com/img/i4/5291937745/O1CN01WEjBYm275GbMJ45ZS_!!4611686018427383761-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (104, '悟空有货夏季户外速干运动伞兵短裤男女潮牌街头宽松百搭五分裤子 户外 运动', 29.00, 54, '悟空有货夏季户外速干运动伞兵短裤男女潮牌街头宽松百搭五分裤子 户外 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/2671610255/O1CN01v5NYlh1DkpwhNCcVQ_!!2671610255.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (105, 'NASA联名日系怪兽短裤男女夏季薄款休闲运动裤宽松情侣阔腿五分裤 运动', 29.24, 63, 'NASA联名日系怪兽短裤男女夏季薄款休闲运动裤宽松情侣阔腿五分裤 运动', 2, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2213776641680/O1CN01PSrcBW1OHUM9XcTJG_!!2213776641680.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (106, 'lulu速干运动t恤男夏季薄款专业跑步训练健身短袖吸汗透气骑行服 运动', 32.88, 86, 'lulu速干运动t恤男夏季薄款专业跑步训练健身短袖吸汗透气骑行服 运动', 2, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2215232273226/O1CN01HeBYjN1ZhYlzAAwC5_!!4611686018427386698-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (107, '成毅同款|斯凯奇云野男女款登山鞋徒步鞋户外抓地耐磨运动鞋时尚', 393.00, 18, '成毅同款|斯凯奇云野男女款登山鞋徒步鞋户外抓地耐磨运动鞋时尚', 2, 'https://gw.alicdn.com/imgextra/O1CN01dKJq3y1s5ytfq7JXl_!!2129855716.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (108, 'STA旗舰店溶解字母短裤男女新款潮牌美式宽松运动直筒沙滩休闲裤 运动', 57.00, 21, 'STA旗舰店溶解字母短裤男女新款潮牌美式宽松运动直筒沙滩休闲裤 运动', 2, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2200633078875/O1CN01XYObH32FQo25LNfAq_!!2200633078875.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (109, '【0酒精开创者】降温冰凉巾冷感湿巾植物配方清凉户外运动擦汗 户外 运动', 9.90, 52, '【0酒精开创者】降温冰凉巾冷感湿巾植物配方清凉户外运动擦汗 户外 运动', 2, 'https://gw.alicdn.com/imgextra/O1CN01XTA2rF28PhsYBH4bs_!!2218306857925.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (110, '夏季轻薄拼色沙滩短裤男士潮牌宽松直筒户外速干运动裤青年五分裤 户外 运动', 29.80, 22, '夏季轻薄拼色沙滩短裤男士潮牌宽松直筒户外速干运动裤青年五分裤 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2215924971888/O1CN01bP95UB1Pokp2cJOMA_!!4611686018427386224-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (111, '飞行体能训练服短袖套装正品户外运动套装圆领体能服T恤透气上衣 户外 运动', 24.00, 25, '飞行体能训练服短袖套装正品户外运动套装圆领体能服T恤透气上衣 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2215907659307/O1CN01gGcg2a2IcfDzcC1Ec_!!4611686018427383339-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (112, '汤米透气网眼拼接休闲裤男士2025新款宽松直筒超薄速干户外运动裤', 473.10, 78, '汤米透气网眼拼接休闲裤男士2025新款宽松直筒超薄速干户外运动裤', 2, 'http://img.alicdn.com/img/i1/47691987/O1CN01OBL7YH1QY63ICdBDs_!!4611686018427386067-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (113, 'NASA联名迷彩短裤男士夏季情侣沙滩裤痞帅大裤衩宽松运动五分裤潮 运动', 38.33, 19, 'NASA联名迷彩短裤男士夏季情侣沙滩裤痞帅大裤衩宽松运动五分裤潮 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3250755276/O1CN01IN6HaF1oqSUuw7xxg_!!3250755276.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (114, '水杯大容量耐高温吨吨桶2024新款男生大肚健身运动水壶顿顿2000ml 运动', 6.80, 64, '水杯大容量耐高温吨吨桶2024新款男生大肚健身运动水壶顿顿2000ml 运动', 2, 'https://picasso.alicdn.com/imgextra/O1CNA1JnfwDo25RafHQ2uIg_!!4076157523-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (115, '户外7A撞色凉感短袖男女夏季宽松徒步骑行运动T恤情侣防晒体恤衫 户外 运动', 63.20, 34, '户外7A撞色凉感短袖男女夏季宽松徒步骑行运动T恤情侣防晒体恤衫 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2214295046324/O1CN01vhT1G01waRmCMnwE8_!!4611686018427381940-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (116, 'MY夏季男童百搭简约印花T恤纯棉亲子短袖儿童热销字母运动户外', 80.10, 63, 'MY夏季男童百搭简约印花T恤纯棉亲子短袖儿童热销字母运动户外', 2, 'http://img.alicdn.com/img/i3/7944834598/O1CN01SxOfIw1jpwBMLzAGo_!!4611686018427383334-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (117, '户外速干冲锋裤男女夏季潮牌薄款百搭透气登山运动裤伞兵工装长裤 户外 运动', 57.20, 43, '户外速干冲锋裤男女夏季潮牌薄款百搭透气登山运动裤伞兵工装长裤 户外 运动', 2, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2214295046324/O1CN01ygeF5n1waRlJBGwdR_!!4611686018427381940-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (118, '春夏户外男女机能防水速干褶皱伞兵工装宽松休闲裤薄款运动登山裤 户外 运动', 49.99, 38, '春夏户外男女机能防水速干褶皱伞兵工装宽松休闲裤薄款运动登山裤 户外 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/2454326414/O1CN012eKcKd1xFfQB3DRYg_!!2454326414.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (119, 'NASA联名冰丝小熊短裤男女夏季薄款满印沙滩裤休闲运动情侣五分裤 运动', 36.90, 65, 'NASA联名冰丝小熊短裤男女夏季薄款满印沙滩裤休闲运动情侣五分裤 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3797492921/O1CN01wcO9n01XRrfCtZcff_!!3797492921.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (120, 'NASA联名蜡笔小新裤子男女短裤夏季薄款睡衣服运动休闲冰丝五分裤 运动', 36.80, 10, 'NASA联名蜡笔小新裤子男女短裤夏季薄款睡衣服运动休闲冰丝五分裤 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/1965951936/O1CN01Samv161QAjj4AmPrG_!!1965951936.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (121, '悟空有货潮牌户外机能风冰丝凉感运动裤男宽松百搭速干阔腿休闲裤', 57.20, 93, '悟空有货潮牌户外机能风冰丝凉感运动裤男宽松百搭速干阔腿休闲裤', 2, 'http://img.alicdn.com/img/i1/112044131/O1CN01QOcQki1gO3DMu9WWu_!!4611686018427381859-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (122, '运动户外弯刀工装冲锋裤男女夏季设计垂感褶皱轻薄透气阔腿裤速干 运动 户外', 29.50, 38, '运动户外弯刀工装冲锋裤男女夏季设计垂感褶皱轻薄透气阔腿裤速干 运动 户外', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/208454920/O1CN01dLzsib1mDPi10IMj7_!!208454920.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (123, '白色龙鳞打孔速干短袖男夏季吸湿排汗跑步健身t恤户外运动骑行服 户外 运动', 39.93, 82, '白色龙鳞打孔速干短袖男夏季吸湿排汗跑步健身t恤户外运动骑行服 户外 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/4053571766/O1CN013C81WK1OusWGeSOxN_!!4611686018427386038-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (124, '月亮椅户外折叠椅便携式露营椅子躺椅沙滩椅钓鱼凳野餐桌椅午休椅 户外', 19.80, 100, '月亮椅户外折叠椅便携式露营椅子躺椅沙滩椅钓鱼凳野餐桌椅午休椅 户外', 2, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2114346129/O1CN01uq2wiW1v98YJnboJW_!!4611686018427387025-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (125, '外贸大厂原单防滑耐磨户外运动徒步鞋 透气舒适作训男鞋 越野跑鞋', 62.50, 61, '外贸大厂原单防滑耐磨户外运动徒步鞋 透气舒适作训男鞋 越野跑鞋', 2, 'http://img.alicdn.com/img/i3/1427580161/O1CN01uIrbJP1D3mpVPfVcz_!!4611686018427380993-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (126, '条纹速干短裤男夏季薄款篮球运动休闲中裤美式宽松沙滩外穿五分裤 运动', 43.20, 23, '条纹速干短裤男夏季薄款篮球运动休闲中裤美式宽松沙滩外穿五分裤 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3547280601/O1CN01ROPbxH1GJJ50mltz6_!!4611686018427385049-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (127, '美式速干休闲短裤男士夏季薄款2025新款户外运动直筒宽松五分裤子 户外 运动', 34.20, 22, '美式速干休闲短裤男士夏季薄款2025新款户外运动直筒宽松五分裤子 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2095638804/O1CN01litdMt2EuHv1iUIne_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (128, 'WASSUP户外休闲五分裤男夏季百搭宽松速干运动短裤美式沙滩泳裤子 户外 运动', 60.20, 39, 'WASSUP户外休闲五分裤男夏季百搭宽松速干运动短裤美式沙滩泳裤子 户外 运动', 2, 'https://picasso.alicdn.com/imgextra/O1CNA19ZMiOU1MW1nq6UvNj_!!2908581441-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (129, 'NASA联名星之卡比运动短裤男女情侣夏季速干沙滩裤休闲阔腿五分裤 运动', 36.80, 65, 'NASA联名星之卡比运动短裤男女情侣夏季速干沙滩裤休闲阔腿五分裤 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/3797492921/O1CN01WHKHGC1XRrrHWvfr1_!!3797492921.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (130, '山脉鞋丨FILA斐乐户外徒步登山鞋休闲鞋老爹鞋运动鞋轻便男鞋', 614.00, 83, '山脉鞋丨FILA斐乐户外徒步登山鞋休闲鞋老爹鞋运动鞋轻便男鞋', 2, 'http://img.alicdn.com/img/i1/1818370038/O1CN013dEhXQ1C9S3Y3X4F9_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (131, '班尼路速干短裤男夏季户外篮球运动五分裤冰丝凉感直筒男士休闲裤 户外 运动', 69.90, 39, '班尼路速干短裤男夏季户外篮球运动五分裤冰丝凉感直筒男士休闲裤 户外 运动', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/2215925659128/O1CN017dMXU42HIgMEE8Ted_!!4611686018427385336-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (132, '哥伦夏季户外冰丝T恤男薄速干运动圆领短袖上衣力透气冰感弹力衣 户外 运动', 50.00, 19, '哥伦夏季户外冰丝T恤男薄速干运动圆领短袖上衣力透气冰感弹力衣 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/866621900/O1CN01bUznSc1PuFaesq7wU_!!866621900.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (133, '户外折叠椅子便携式露营野餐神器钓鱼椅子夜市摆摊椅子休闲车载 户外', 12.05, 66, '户外折叠椅子便携式露营野餐神器钓鱼椅子夜市摆摊椅子休闲车载 户外', 2, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/3329014613/O1CN01E20Tdd1jwo6VGMsZu_!!3329014613.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (134, '速干短袖t恤女冰丝运动2025新款户外情侣跑步宽松男健身衣', 23.66, 34, '速干短袖t恤女冰丝运动2025新款户外情侣跑步宽松男健身衣', 2, 'http://img.alicdn.com/img/i3/7269565017/O1CN01Vo1fbS1mvq8Pgsfa1_!!4611686018427380313-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (135, '短裤男夏季华夫格五分裤男士休闲裤新款国潮潮牌裤子男情侣沙滩裤', 34.90, 45, '短裤男夏季华夫格五分裤男士休闲裤新款国潮潮牌裤子男情侣沙滩裤', 2, 'https://picasso.alicdn.com/imgextra/O1CNA16MidWz1SYDNh10w46_!!1901612258-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (136, '回力冰丝短袖t恤男夏季新款透气跑步运动男款半袖男士速干上衣服 运动', 29.00, 95, '回力冰丝短袖t恤男夏季新款透气跑步运动男款半袖男士速干上衣服 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2215763523256/O1CN01fgkKlK1ZvIR3KM41N_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (137, '正品体能训练服套装男夏新款体能服短袖户外训作t恤运动上衣女裤 户外 运动', 21.00, 64, '正品体能训练服套装男夏新款体能服短袖户外训作t恤运动上衣女裤 户外 运动', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2216344804367/O1CN012gXUhT1i88g3pSBWM_!!2216344804367.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (138, '降温冰巾降温神器挂脖冷感清凉运动户外跑步学生防暑去汗薄荷毛巾 运动 户外', 8.52, 94, '降温冰巾降温神器挂脖冷感清凉运动户外跑步学生防暑去汗薄荷毛巾 运动 户外', 2, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2216716085200/O1CN01Jz8UKD1oHebv6295c_!!4611686018427381712-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (139, '机械革命深海泰坦x10 x8 pro x3 x2 umi Pro3 深海幽灵z2 pro主板', 99.00, 33, '机械革命深海泰坦x10 x8 pro x3 x2 umi Pro3 深海幽灵z2 pro主板', 3, 'http://img.alicdn.com/img/i1/7331698775/O1CN01qDDXWD2Eh0WymWNJd_!!4611686018427385943-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (140, 'rk3288/3568/3399安卓工业主板工控电脑瑞芯微主板linux/Ubuntu', 298.00, 76, 'rk3288/3568/3399安卓工业主板工控电脑瑞芯微主板linux/Ubuntu', 3, 'http://img.alicdn.com/img/i2/6875726668/O1CN01bLHH3S1z7zxKtRygP_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (141, '全新酷睿i3 i5 i7台式机电脑主板CPU套装H61 B75 B85四件套1155针', 219.00, 92, '全新酷睿i3 i5 i7台式机电脑主板CPU套装H61 B75 B85四件套1155针', 3, 'http://img.alicdn.com/img/i3/26470097/O1CN01l8P8l01CaTLJcxkTl_!!2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (142, '技嘉华硕B85台式机电脑主板CPU内存i3 i5 i7四核办公游戏套装升级 电脑 主板', 158.00, 86, '技嘉华硕B85台式机电脑主板CPU内存i3 i5 i7四核办公游戏套装升级 电脑 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/266176465/O1CN01p9tqHn1xd1J4sfhHL_!!266176465.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (143, '机械革命极光x 无界15x蛟龙16 k pro矿世16pro翼龙15pro主板', 130.00, 96, '机械革命极光x 无界15x蛟龙16 k pro矿世16pro翼龙15pro主板', 3, 'http://img.alicdn.com/img/i1/7331698775/O1CN01qDDXWD2Eh0WymWNJd_!!4611686018427385943-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (144, '爆新华硕Z370-PLUS Z390 B365M H310 B360 1151针电竞游戏主板 主板', 159.00, 19, '爆新华硕Z370-PLUS Z390 B365M H310 B360 1151针电竞游戏主板 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/892381470/O1CN013Qd2EE1MjJ3GzIgFH_!!892381470.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (145, '全新x79/x99双路主板cpu套装20', 600.00, 56, '全新x79/x99双路主板cpu套装20', 3, 'http://img.alicdn.com/img/i1/120754336/O1CN01up1TRR1htw9yGJwQb_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (146, '华硕ROG笔记本维修G713进水3主板5幻15 16枪神7电脑魔霸新锐8plus', 1.00, 23, '华硕ROG笔记本维修G713进水3主板5幻15 16枪神7电脑魔霸新锐8plus', 3, 'http://img.alicdn.com/img/i3/342280031/O1CN01vQaTAu1C6FK8Bfbl2_!!4611686018427381599-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (147, '华硕技嘉H61/H81台式机电脑主板cpu内存i3 i5 i7四核办公游戏套装 电脑 主板', 145.00, 50, '华硕技嘉H61/H81台式机电脑主板cpu内存i3 i5 i7四核办公游戏套装 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2208029042137/O1CN01xAHupp1RenHM5v5Id_!!2208029042137.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (148, '雷神笔记本电脑猎刃zero主板进水不开机维修械师曙光蓝屏换屏cpu', 10.00, 21, '雷神笔记本电脑猎刃zero主板进水不开机维修械师曙光蓝屏换屏cpu', 3, 'http://img.alicdn.com/img/i4/96997197/O1CN01466Ga1232HY6CG7mi_!!4611686018427383629-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (149, '全新i7台式机电脑主板CPU内存i5办公游戏吃鸡套装X99十核五件套i3 电脑 主板', 238.00, 66, '全新i7台式机电脑主板CPU内存i5办公游戏吃鸡套装X99十核五件套i3 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/314220184/O1CN011FE4811DEJtbBcfOi_!!314220184.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (150, '将星colorful隐星 笔记本主板X15 X16 X17 P15 P16 pro r15七彩虹', 80.00, 44, '将星colorful隐星 笔记本主板X15 X16 X17 P15 P16 pro r15七彩虹', 3, 'http://img.alicdn.com/img/i4/6156489210/O1CN01Uw4IyE2HuEhx7OQCB_!!2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (151, '华硕技嘉H61 B75 Z77 Z68 H77 P67原装1155针品牌台式机电脑主板 电脑 主板', 28.70, 13, '华硕技嘉H61 B75 Z77 Z68 H77 P67原装1155针品牌台式机电脑主板 电脑 主板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/911135374/O1CN01tG9iUd1pZLSkN0urL_!!911135374.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (152, '将星colorful隐星 笔记本主板X15 X16 X17 P15 P16 pro r15七彩虹', 80.00, 97, '将星colorful隐星 笔记本主板X15 X16 X17 P15 P16 pro r15七彩虹', 3, 'http://img.alicdn.com/img/i1/2981010026/O1CN01UhIjCd1C3xFWLk4nb_!!2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (153, '小米RMG2102 2104 2214 XMG2003 1902 RedmondGpro高端游戏本主板', 100.00, 36, '小米RMG2102 2104 2214 XMG2003 1902 RedmondGpro高端游戏本主板', 3, 'http://img.alicdn.com/img/i3/7268184587/O1CN01q03sg91jktp7GIxDf_!!4611686018427384331-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (154, '拆机技嘉华硕LGA1150针H81 B85 Z87 Z97台式电脑主板原装小板套装 电脑 主板', 48.90, 60, '拆机技嘉华硕LGA1150针H81 B85 Z87 Z97台式电脑主板原装小板套装 电脑 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2214984006883/O1CN01rCvzGZ20iSySAbmsB_!!2214984006883.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (155, '铭瑄主板 B760M系列 WIFI 终结者/电竞主板套装 搭12/14代CPU散片', 599.00, 35, '铭瑄主板 B760M系列 WIFI 终结者/电竞主板套装 搭12/14代CPU散片', 3, 'http://img.alicdn.com/img/i3/732910136/O1CN01le9sjh1CsKw2FKGKT_!!4611686018427384376-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (156, '全新酷睿i3 i5 i7台式电脑主板CPU套装B75 B85 H110 B360四件套 电脑 主板', 228.00, 54, '全新酷睿i3 i5 i7台式电脑主板CPU套装B75 B85 H110 B360四件套 电脑 主板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/1074280473/O1CN017G8nFa1FMgP7uekse_!!1074280473.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (157, '机械革命 蛟龙7 r5 x8 X9 x10ti 旷世 翼龙 耀世14 15 16 PRO主板', 100.00, 34, '机械革命 蛟龙7 r5 x8 X9 x10ti 旷世 翼龙 耀世14 15 16 PRO主板', 3, 'http://img.alicdn.com/img/i3/7698718075/O1CN01dsPuuN29WPHpH5DOR_!!4611686018427387259-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (158, '库存Colorful/七彩虹B560 Z590 B460 无线WiFi蓝牙冰霜电竞高端板', 189.00, 76, '库存Colorful/七彩虹B560 Z590 B460 无线WiFi蓝牙冰霜电竞高端板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/857205098/O1CN01URKU1V1nWwAETDlSQ_!!857205098.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (159, '华南金牌x99主板cpu套装游戏电脑至强e5 2666 2667 2696v3 2680v4 主板 电脑', 198.00, 92, '华南金牌x99主板cpu套装游戏电脑至强e5 2666 2667 2696v3 2680v4 主板 电脑', 3, 'https://picasso.alicdn.com/imgextra/O1CNA1pRDyIm2EBPDmi5Yfp_!!2924498706-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (160, '铭瑄B760M终结者WiFi/电竞之心/挑战者电脑主板支持12/13代CPU', 549.00, 92, '铭瑄B760M终结者WiFi/电竞之心/挑战者电脑主板支持12/13代CPU', 3, 'http://img.alicdn.com/img/i4/6798776309/O1CN0102a2UI1wTZqk4YFJE_!!4611686018427385845-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (161, '英特尔i5 12400F i512400F散片CPU主板套装12400F搭微星华硕B760M 主板', 657.00, 16, '英特尔i5 12400F i512400F散片CPU主板套装12400F搭微星华硕B760M 主板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/757608831/O1CN01TqH3eI2F6ejDdOnS8_!!4611686018427384191-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (162, '英特尔i5 12490f/12600kf/14600kf微星b760迫击炮电脑主板cpu套装 电脑 主板', 1101.25, 48, '英特尔i5 12490f/12600kf/14600kf微星b760迫击炮电脑主板cpu套装 电脑 主板', 3, 'https://picasso.alicdn.com/imgextra/O1CNA1TGw9I1243UDLBudfF_!!671257335-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (163, 'H81/H61/H110 i3 i5 E3电脑主板CPU 8/16/32G内存电脑配件套装 电脑 主板 电脑', 75.30, 27, 'H81/H61/H110 i3 i5 E3电脑主板CPU 8/16/32G内存电脑配件套装 电脑 主板 电脑', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/911135374/O1CN01U6iB6h1pZLPtS0Szm_!!911135374.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (164, '拆机各品牌一二线LGA1150针H81 B85 Z87 Z97台式电脑主板一年包换 电脑 主板', 41.90, 47, '拆机各品牌一二线LGA1150针H81 B85 Z87 Z97台式电脑主板一年包换 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2206820003878/O1CN01z68Lmg1eWB0J3RljO_!!2206820003878.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (165, '技嘉华硕B250M-V3电脑主板1151针B150 7500E3-1230V5D4内存超H310 电脑 主板', 129.00, 28, '技嘉华硕B250M-V3电脑主板1151针B150 7500E3-1230V5D4内存超H310 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/709583320/O1CN01j1BNwZ1aObqiCHlJn_!!709583320.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (166, 'X99主板DDR3/DDR4电脑E5至强2666 2678V3 2696V3 2680V3拼X99D3M4 主板 电脑', 122.00, 11, 'X99主板DDR3/DDR4电脑E5至强2666 2678V3 2696V3 2680V3拼X99D3M4 主板 电脑', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2590258420/O1CN01i5H0Kr2C4PweFJ7Yg_!!2590258420.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (167, '华硕主板CPU套装i5 12400 14600KF PRIME B660m-K/B760M台式机i7 主板', 299.00, 10, '华硕主板CPU套装i5 12400 14600KF PRIME B660m-K/B760M台式机i7 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/354999517/O1CN01CKTYwY2KAqIOPXqiJ_!!354999517.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (168, '英特尔Ultra7265K 搭配ROG STRIX Z890-A GAMINGWIFI吹雪电脑主板 电脑 主板', 5999.00, 58, '英特尔Ultra7265K 搭配ROG STRIX Z890-A GAMINGWIFI吹雪电脑主板 电脑 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2218388458073/O1CN01wyl2QH29VUVW2pJwA_!!2218388458073.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (169, '爆新华硕H410M-F b460m plus h510 b560支持10代11代1200针主板 主板', 129.00, 79, '爆新华硕H410M-F b460m plus h510 b560支持10代11代1200针主板 主板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/892381470/O1CN01VNgC1p1MjJFkLQo2h_!!892381470.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (170, '华硕B360M搭配I5 9400F 9600KF 8500 i39100 9700主板CPU套装 主板', 300.00, 37, '华硕B360M搭配I5 9400F 9600KF 8500 i39100 9700主板CPU套装 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3837396602/O1CN01EMIhQi1ydlsxhGTXv_!!3837396602.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (171, '充新保2年Asus华硕B85M-V/V5 PLUS 1150 B85主板I7CPU四件套电脑 主板 电脑', 58.80, 44, '充新保2年Asus华硕B85M-V/V5 PLUS 1150 B85主板I7CPU四件套电脑 主板 电脑', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/310465149/O1CN017GzJTy1nuINJmAUmg_!!310465149.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (172, '技嘉华硕H61H81/B75/B85/H110/H310/B150/B250/B360/Z370电脑主板 电脑 主板', 40.00, 59, '技嘉华硕H61H81/B75/B85/H110/H310/B150/B250/B360/Z370电脑主板 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/3692816620/O1CN01UH68Af1ym0nLtXj0t_!!3692816620.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (173, '适用西门子IQ300电脑板IQ500滚筒洗衣机WM12S3600W/4680W模块主板 电脑 主板', 38.00, 19, '适用西门子IQ300电脑板IQ500滚筒洗衣机WM12S3600W/4680W模块主板 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2200662213205/O1CN01ltPaPJ1ZXw26rb9QM_!!2200662213205.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (174, '华硕 技嘉H110M1151针电脑主板DDR4集显支持6/7代CPUE3V5V6 电脑 主板', 104.00, 54, '华硕 技嘉H110M1151针电脑主板DDR4集显支持6/7代CPUE3V5V6 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/899990518/O1CN01olyb0S1FhIDzWozZ6_!!899990518.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (175, '原装联想G41主板+4G内存+风扇+E8400双核台式电脑主板CPU套装包邮 主板 电脑 主板', 47.00, 66, '原装联想G41主板+4G内存+风扇+E8400双核台式电脑主板CPU套装包邮 主板 电脑 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/3998784722/O1CN01m50wQT1kkjGV0mBe5_!!3998784722.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (176, '拆机各品牌一二线LGA1150针H81 B85 Z87 Z97台式电脑主板一年包换 电脑 主板', 39.00, 44, '拆机各品牌一二线LGA1150针H81 B85 Z87 Z97台式电脑主板一年包换 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/376412854/O1CN01mboU7B1WxBP4WtTty_!!4611686018427386550-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (177, 'AMD锐龙R5 5600GT 5500盒装华硕微星A520M/B550M电脑主板CPU套装 电脑 主板', 689.00, 14, 'AMD锐龙R5 5600GT 5500盒装华硕微星A520M/B550M电脑主板CPU套装 电脑 主板', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/2219481274050/O1CN01xP4Xhz1fmx8Vrarnb_!!4611686018427385538-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (178, '技嘉华硕B85/H81主板搭配I5 4590 I7 4790台式电脑主板cpu套装i3 主板 电脑 主板', 89.00, 36, '技嘉华硕B85/H81主板搭配I5 4590 I7 4790台式电脑主板cpu套装i3 主板 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2027554311/O1CN010fyl591hiUU96WcyN_!!2027554311.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (179, '华硕H81拆机电脑主板B85技嘉小板大板双槽四槽台式机办公游戏套装 电脑 主板', 52.00, 29, '华硕H81拆机电脑主板B85技嘉小板大板双槽四槽台式机办公游戏套装 电脑 主板', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/1652307214/O1CN0194aiGZ23A4GSg1iVI_!!1652307214.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (180, '华南金牌X99电脑主板cpu套装游戏工作室多开双路E5 2696V3 2666V3 电脑 主板', 198.00, 26, '华南金牌X99电脑主板cpu套装游戏工作室多开双路E5 2696V3 2666V3 电脑 主板', 3, 'https://picasso.alicdn.com/imgextra/O1CNA1Mh7TBE1hyylqCt920_!!2202155524347-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (181, '适用于美的变频空调外机主板通用板 26 32 35交流变频空调电脑板 主板 电脑', 138.00, 24, '适用于美的变频空调外机主板通用板 26 32 35交流变频空调电脑板 主板 电脑', 3, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/4028728660/O1CN012MWHYx2DqKzkYwM8s_!!4028728660.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (182, '原装美的空调外主板KFR-120W/S-590电脑板 5匹风管机140W/590T2 主板 电脑', 35.00, 33, '原装美的空调外主板KFR-120W/S-590电脑板 5匹风管机140W/590T2 主板 电脑', 3, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/3084571028/O1CN01H2TLXS1JSsD64Jzsr_!!3084571028.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (183, '华南金牌H610/B760台式电脑主板cpu酷睿套装i3i5i7 13490F 12400F 电脑 主板', 289.00, 32, '华南金牌H610/B760台式电脑主板cpu酷睿套装i3i5i7 13490F 12400F 电脑 主板', 3, 'https://picasso.alicdn.com/imgextra/O1CNA1xFkOiV1hyylpemCHc_!!2202155524347-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (184, '华硕/技嘉H61 B75 Z77 Z68 H77 P67原装1155针品牌台式机电脑主板 电脑 主板', 29.00, 55, '华硕/技嘉H61 B75 Z77 Z68 H77 P67原装1155针品牌台式机电脑主板 电脑 主板', 3, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2213155264513/O1CN01UxZDpO1jD0UnMMmSB_!!2213155264513.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (185, '新品上市OPPOA3iPlus5G手机全新超硬核耐用战神全面抗摔耐磨', 989.40, 83, '新品上市OPPOA3iPlus5G手机全新超硬核耐用战神全面抗摔耐磨', 4, 'http://img.alicdn.com/img/i1/31703846/O1CN019gwIoU1eHWLDMI1wt_!!4611686018427380518-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (186, '【定制色上市】小米15Ultra手机新品新款上市小米徕卡联合', 6499.00, 92, '【定制色上市】小米15Ultra手机新品新款上市小米徕卡联合', 4, 'https://img.alicdn.com/imgextra/i1/6000000005764/O1CN01KuAvQ51sRxzkbRrnn_!!6000000005764-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (187, 'vivo X200 Ultra新品上市高端旗舰拍照大内存手机赠价值498元光影随行礼盒', 6414.00, 84, 'vivo X200 Ultra新品上市高端旗舰拍照大内存手机赠价值498元光影随行礼盒', 4, 'https://img.alicdn.com/imgextra/i1/2207440821122/O1CN01NMWBeJ1K9vRexk6Q6_!!2207440821122-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (188, 'Huawei/华为 畅享10 plus老人机大字体大声全网通老年人智能手机 手机', 390.04, 56, 'Huawei/华为 畅享10 plus老人机大字体大声全网通老年人智能手机 手机', 4, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/73177424/O1CN01VzjW8Z24iFG3YSVcE_!!73177424.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (189, '【国家补贴立省500元】vivo X200s新品蔡司天玑9400+旗舰芯拍照学生智能手机vivo官方旗舰店官网正品', 3649.00, 24, '【国家补贴立省500元】vivo X200s新品蔡司天玑9400+旗舰芯拍照学生智能手机vivo官方旗舰店官网正品', 4, 'https://img.alicdn.com/imgextra/i4/2207440821122/O1CN01Nehq5J1K9vRe2XgXY_!!2207440821122-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (190, '荣耀Magic5 Pro 5G 第二代骁龙8旗舰芯 定制煤安防爆手机 煤矿井下MA本安瓦斯隧道专用 煤安定制版带煤安证书 手机', 5928.13, 57, '荣耀Magic5 Pro 5G 第二代骁龙8旗舰芯 定制煤安防爆手机 煤矿井下MA本安瓦斯隧道专用 煤安定制版带煤安证书 手机', 4, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/547686779/O1CN01UEEios1zwpskeWtFn_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (191, '【下拉领政府补贴15%】REDMI K80红米k80手机官方', 1996.67, 12, '【下拉领政府补贴15%】REDMI K80红米k80手机官方', 4, 'https://img.alicdn.com/imgextra/i4/6000000004856/O1CN01zTeleV1lk6MryzFAV_!!6000000004856-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (192, '[新品上市]OPPO Reno14 opporeno14手机oppo手机官方旗舰店官网新品0ppo5g手机reno13pro手机reno14系列', 2699.00, 100, '[新品上市]OPPO Reno14 opporeno14手机oppo手机官方旗舰店官网新品0ppo5g手机reno13pro手机reno14系列', 4, 'http://img.alicdn.com/img/i4/45828625/O1CN01VTvQoc2DaJ7hh01wi_!!4611686018427382289-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (193, '【天猫自营 顺丰速发】Apple/苹果 iPhone 16 Pro 官方旗舰店国行正品 政府补贴 顺丰速发', 7219.05, 29, '【天猫自营 顺丰速发】Apple/苹果 iPhone 16 Pro 官方旗舰店国行正品 政府补贴 顺丰速发', 4, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2215532095020/O1CN01x67UgY1mxDK0jca6B_!!4611686018427381292-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (194, '【政府补贴15%|6期免息】Meizu魅族Note16 Pro AI手机新品官方旗舰店高通骁龙持久续航流畅耐用战神学生手机', 1218.92, 66, '【政府补贴15%|6期免息】Meizu魅族Note16 Pro AI手机新品官方旗舰店高通骁龙持久续航流畅耐用战神学生手机', 4, 'http://img.alicdn.com/img/i1/44250426/O1CN01f0VyYy1F19n3yNTAn_!!4611686018427385146-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (195, '【政府补贴15%|3期免息】Meizu魅族Note16 AI手机新品官方旗舰店6600mAh持久续航国民严选流畅战神紫光展锐 手机', 802.42, 36, '【政府补贴15%|3期免息】Meizu魅族Note16 AI手机新品官方旗舰店6600mAh持久续航国民严选流畅战神紫光展锐 手机', 4, 'https://picasso.alicdn.com/imgextra/O1CNA1M8FKK72EjkvRcykc9_!!1695308781-0-psf.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (196, '【Meta1旗舰】直降9000元 VERTU纬图 威图META1双曲屏奢品AI5G商务智能web3.0礼盒礼品', 16800.00, 48, '【Meta1旗舰】直降9000元 VERTU纬图 威图META1双曲屏奢品AI5G商务智能web3.0礼盒礼品', 4, 'https://img.alicdn.com/imgextra/i3/2200694625295/O1CN01CRuxQR1ozAEUO4uEx_!!2200694625295-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (197, '新品上市OPPOA3iPlus5G手机全新超硬核耐用战神全面抗摔耐磨', 989.40, 56, '新品上市OPPOA3iPlus5G手机全新超硬核耐用战神全面抗摔耐磨', 4, 'http://img.alicdn.com/img/i1/31703846/O1CN019gwIoU1eHWLDMI1wt_!!4611686018427380518-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (198, '【定制色上市】小米15Ultra手机新品新款上市小米徕卡联合', 6499.00, 19, '【定制色上市】小米15Ultra手机新品新款上市小米徕卡联合', 4, 'https://img.alicdn.com/imgextra/i1/6000000005764/O1CN01KuAvQ51sRxzkbRrnn_!!6000000005764-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (199, '【国家补贴立省500元】vivo X200s新品蔡司天玑9400+旗舰芯拍照学生智能手机vivo官方旗舰店官网正品', 3649.00, 40, '【国家补贴立省500元】vivo X200s新品蔡司天玑9400+旗舰芯拍照学生智能手机vivo官方旗舰店官网正品', 4, 'https://img.alicdn.com/imgextra/i2/2207440821122/O1CN01iT5rOc1K9vRdP322C_!!2207440821122-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (200, 'Apple/苹果 iPhone 13Pro Max 苹果国行13promax5G全网通分期免息', 2189.00, 85, 'Apple/苹果 iPhone 13Pro Max 苹果国行13promax5G全网通分期免息', 4, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/82281517/O1CN01nwzpY21N4psjzx6ct_!!82281517.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (201, '【下拉领政府补贴15%】REDMI K80红米k80手机官方', 1996.67, 77, '【下拉领政府补贴15%】REDMI K80红米k80手机官方', 4, 'https://img.alicdn.com/imgextra/i4/6000000004856/O1CN01zTeleV1lk6MryzFAV_!!6000000004856-0-alimamacc.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (202, '保密工厂车间无摄像头手机安卓智能全网通超长待机没有拍照功能的 手机', 569.76, 86, '保密工厂车间无摄像头手机安卓智能全网通超长待机没有拍照功能的 手机', 4, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/3343265585/O1CN0109BaRX1r7z2mXtSxZ_!!3343265585.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (203, 'vivo X200 Ultra新品上市高端旗舰拍照大内存手机赠价值498元光影随行礼盒', 6414.00, 80, 'vivo X200 Ultra新品上市高端旗舰拍照大内存手机赠价值498元光影随行礼盒', 4, 'https://img.alicdn.com/imgextra/i2/2207440821122/O1CN01OiBIqh1K9vReVNz3q_!!2207440821122-2-alimamacc.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (204, '[新品上市]OPPO Reno14 opporeno14手机oppo手机官方旗舰店官网新品0ppo5g手机reno13pro手机reno14系列', 2699.00, 66, '[新品上市]OPPO Reno14 opporeno14手机oppo手机官方旗舰店官网新品0ppo5g手机reno13pro手机reno14系列', 4, 'http://img.alicdn.com/img/i1/45828625/O1CN011UjAC12DaJ8edT1jl_!!4611686018427382289-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (205, 'honor/荣耀 60 Pro全网通5G手机 1亿像素 荣耀 60曲面屏 骁龙778g 手机', 1025.96, 18, 'honor/荣耀 60 Pro全网通5G手机 1亿像素 荣耀 60曲面屏 骁龙778g 手机', 4, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/2211386080116/O1CN015j5q8B1CjAxWgTJvc~crop,0,200,1200,1200~_!!2211386080116.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (206, '【政府补贴15%|6期免息】Meizu魅族Note16 Pro AI手机新品官方旗舰店高通骁龙持久续航流畅耐用战神学生手机', 1218.92, 46, '【政府补贴15%|6期免息】Meizu魅族Note16 Pro AI手机新品官方旗舰店高通骁龙持久续航流畅耐用战神学生手机', 4, 'http://img.alicdn.com/img/i1/44250426/O1CN01f0VyYy1F19n3yNTAn_!!4611686018427385146-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (207, 'MIUI/小米 Redmi K70 至尊版旗舰手机红米5G天玑9300+拍照游戏机 手机', 1585.64, 59, 'MIUI/小米 Redmi K70 至尊版旗舰手机红米5G天玑9300+拍照游戏机 手机', 4, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/3421188727/O1CN01D87Tfv2EL1Vgs2NdU_!!3421188727.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (208, '送小米充电宝 小米15Ultra新品上市手机官方旗舰店正品', 5499.01, 92, '送小米充电宝 小米15Ultra新品上市手机官方旗舰店正品', 4, 'http://img.alicdn.com/img/i2/53994110/O1CN01hV6BZ51gEQrrH8iGi_!!4611686018427380350-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (209, 'vivo iQOO Neo10手机新品学生游戏电竞手机新款三代骁龙8大电池 手机 手机', 1842.00, 24, 'vivo iQOO Neo10手机新品学生游戏电竞手机新款三代骁龙8大电池 手机 手机', 4, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/3224642556/O1CN01hospvO1UkhMb23amo_!!3224642556.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (210, '【政府补贴至高15%】HONOR/荣耀400 5G手机官方旗舰店新款官网正品智能游戏拍照荣耀400系列', 2018.76, 84, '【政府补贴至高15%】HONOR/荣耀400 5G手机官方旗舰店新款官网正品智能游戏拍照荣耀400系列', 4, 'http://img.alicdn.com/img/i4/53994110/O1CN019QcpKo1gEQtKJcWL5_!!4611686018427380350-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (211, 'Realme/真我 GT Neo5 骁龙8+旗舰5G独显芯片高帧率电竞智能手机', 1450.20, 38, 'Realme/真我 GT Neo5 骁龙8+旗舰5G独显芯片高帧率电竞智能手机', 4, 'http://img.alicdn.com/img/i2/2427570033/O1CN01ANJGOy1C7A6aofoso_!!4611686018427381617-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (212, '华为 nova 13 Pro 新品手机前后多焦段人像北斗卫星图片消息可升级鸿蒙系统华为智能手机 手机 手机', 3049.00, 91, '华为 nova 13 Pro 新品手机前后多焦段人像北斗卫星图片消息可升级鸿蒙系统华为智能手机 手机 手机', 4, 'https://gw.alicdn.com/imgextra/O1CN01aYN00B2FLJOxWfvHw_!!2213856588863-0-msd_sticker.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (213, 'honor/荣耀 畅玩50 Plus手机6000mAh长续航5000万超清影像35W快充', 1192.00, 72, 'honor/荣耀 畅玩50 Plus手机6000mAh长续航5000万超清影像35W快充', 4, 'http://img.alicdn.com/img/i4/49447158/O1CN01AiJfj022kQ4oKwfXD_!!4611686018427379958-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (214, '中国名家获奖绘本一年级阅读课外书正版适合小学1年级看的儿童大班幼儿园专用3-5-6一8岁带拼音以上故事书3-6岁小学生注音版读物书', 23.80, 94, '中国名家获奖绘本一年级阅读课外书正版适合小学1年级看的儿童大班幼儿园专用3-5-6一8岁带拼音以上故事书3-6岁小学生注音版读物书', 5, 'http://img.alicdn.com/img/i4/5254943342/O1CN015VoNFT1aYgis1beac_!!4611686018427384430-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (215, '草房子正版 曹文轩完整版青铜葵花根鸟四五年级下册课外阅读书籍老师推荐全套儿童文学8-10-12周岁畅销小说读物山羊不吃天堂草', 9.70, 39, '草房子正版 曹文轩完整版青铜葵花根鸟四五年级下册课外阅读书籍老师推荐全套儿童文学8-10-12周岁畅销小说读物山羊不吃天堂草', 5, 'http://img.alicdn.com/img/i1/6546025555/O1CN01jQwKvZ1quFDEdTGWG_!!4611686018427382867-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (216, '加厚版全套2册中国未解之谜+世界未解之谜百科全书小学生三至四五六年级课外阅读书籍正版少年儿童百科全书大全集科学青少年读物', 9.80, 33, '加厚版全套2册中国未解之谜+世界未解之谜百科全书小学生三至四五六年级课外阅读书籍正版少年儿童百科全书大全集科学青少年读物', 5, 'http://img.alicdn.com/img/i3/15940794/O1CN01NmIkmg1HjhW75r0Jy_!!4611686018427387066-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (217, '网上打印服务黑白彩色数码快印画册印刷印书资料书本装订论文复印', 1.00, 75, '网上打印服务黑白彩色数码快印画册印刷印书资料书本装订论文复印', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/3874729271/O1CN01HNrtjA2IMAyv0Ul9y_!!3874729271.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (218, '流浪地球书新华正版包邮刘慈欣少年科幻科学小说6册任选 中小学生青少年课外阅读书长篇科幻文学全集悬疑小说 现当代文学畅销书籍', 10.28, 13, '流浪地球书新华正版包邮刘慈欣少年科幻科学小说6册任选 中小学生青少年课外阅读书长篇科幻文学全集悬疑小说 现当代文学畅销书籍', 5, 'http://img.alicdn.com/img/i3/6546025555/O1CN01upqcZG1quFDMf8fFJ_!!4611686018427382867-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (219, '成都打印资料网上打印店复印印刷书本装订成册图文快印彩印次日达', 9.00, 94, '成都打印资料网上打印店复印印刷书本装订成册图文快印彩印次日达', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/870832562/O1CN01iZ4e0a1UnRmzpk9jT_!!870832562.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (220, '西西弗书店 夜莺与玫瑰 精装定制版 王尔德童话全集 中英双语 浪漫永生不灭 当代文学中小学生课外阅读书目畅销书', 59.10, 30, '西西弗书店 夜莺与玫瑰 精装定制版 王尔德童话全集 中英双语 浪漫永生不灭 当代文学中小学生课外阅读书目畅销书', 5, 'http://img.alicdn.com/img/i3/1380100052/O1CN01o0ycQH1CFrcrdOr11_!!4611686018427381716-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (221, '正版 典籍里的中国 精装版 青少年中小学生课外阅读书籍通俗易懂探寻中华民族的文化基因读典籍学文史有趣有料有知识点的中国通史', 25.62, 56, '正版 典籍里的中国 精装版 青少年中小学生课外阅读书籍通俗易懂探寻中华民族的文化基因读典籍学文史有趣有料有知识点的中国通史', 5, 'http://img.alicdn.com/img/i3/6471635806/O1CN01nspK6n1slCd8Ovr6r_!!4611686018427384670-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (222, '打印资料装订成册网上打印服务黑白彩色PDF复印扫描书本印刷彩印', 9.50, 49, '打印资料装订成册网上打印服务黑白彩色PDF复印扫描书本印刷彩印', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/798711581/O1CN01w4XW5o1NY9E3wPc6p_!!798711581.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (223, '小眼睛看世界系列儿童大百科全书全套彩图注音版中国少儿趣味科普类读物一二年级小学生课外阅读书籍宇宙地球自然海洋人体动物飞机', 12.24, 62, '小眼睛看世界系列儿童大百科全书全套彩图注音版中国少儿趣味科普类读物一二年级小学生课外阅读书籍宇宙地球自然海洋人体动物飞机', 5, 'http://img.alicdn.com/img/i2/15940794/O1CN01v4v8RX1HjhUWtqtQk_!!4611686018427387066-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (224, '打印资料网上复印文件印刷画册彩色图文快印装订培训教材书本服务', 10.00, 82, '打印资料网上复印文件印刷画册彩色图文快印装订培训教材书本服务', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/2772320647/O1CN01EK1NQh1GeNCmyXEme_!!2772320647.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (225, '米吴科学漫画书全套大冒险福建篇修订版上下全套2册 人文历史国家地理科普启蒙百科全书小学生课外阅读书籍123年级6-12岁', 19.80, 25, '米吴科学漫画书全套大冒险福建篇修订版上下全套2册 人文历史国家地理科普启蒙百科全书小学生课外阅读书籍123年级6-12岁', 5, 'http://img.alicdn.com/img/i2/7184594464/O1CN01nReyO61iqZ5jV074j_!!4611686018427385376-2-saturn_solar.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (226, '打印资料复印彩色a4黑白彩印图文快印A3印刷书本装订成册网上打印', 10.00, 11, '打印资料复印彩色a4黑白彩印图文快印A3印刷书本装订成册网上打印', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2208965789283/O1CN01SnIG1I2IRfMIP3P7s_!!2208965789283.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (227, '童小奇画给孩子的论语 求人不如求己 注音版全4册全集全新包邮正品正版书籍书刊123456年级小学生读物', 23.79, 41, '童小奇画给孩子的论语 求人不如求己 注音版全4册全集全新包邮正品正版书籍书刊123456年级小学生读物', 5, 'http://img.alicdn.com/img/i3/7316956306/O1CN01Rwkdpc1wSCf0B2Jz1_!!4611686018427380882-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (228, '全套4册 中国古代神话故事四年级上册阅读课外书必读正版的书籍快乐读书吧四上推荐古希腊世界经典神话与传说山海经小学生版老师', 9.30, 61, '全套4册 中国古代神话故事四年级上册阅读课外书必读正版的书籍快乐读书吧四上推荐古希腊世界经典神话与传说山海经小学生版老师', 5, 'http://img.alicdn.com/img/i3/7909103777/O1CN01ukwvLJ1dlv0PKLym4_!!4611686018427386017-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (229, '打印资料书本图文文件快印刷苏州江浙沪装订成册彩色黑白快印店', 10.00, 75, '打印资料书本图文文件快印刷苏州江浙沪装订成册彩色黑白快印店', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i1/2212323116034/O1CN01wmZRJd1uRcnM8yZlp_!!2212323116034.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (230, '现货速发正版中国哲学简史 哲学家冯友兰', 18.92, 13, '现货速发正版中国哲学简史 哲学家冯友兰', 5, 'http://img.alicdn.com/img/i3/1981610105/O1CN01LCc7uT1Ce8K6AIANx_!!0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (231, '打印资料网上打印彩色黑白图文快印书本书籍印刷装订成册复印成都', 10.00, 93, '打印资料网上打印彩色黑白图文快印书本书籍印刷装订成册复印成都', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2211836600838/O1CN01h7tVXO1I3qyHRr5Mk_!!4611686018427380230-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (232, '包邮 像间谍一样观察 杰克谢弗 马文卡林斯 著 微表情研究专家姜振宇倾情推荐 中信出版社图书 正版书籍', 34.70, 84, '包邮 像间谍一样观察 杰克谢弗 马文卡林斯 著 微表情研究专家姜振宇倾情推荐 中信出版社图书 正版书籍', 5, 'http://img.alicdn.com/img/i4/31738812/O1CN01ESV9QH2ExxBompKB8_!!4611686018427382716-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (233, '打印资料网上打印印刷书本装订A4彩印复印服务', 9.90, 85, '打印资料网上打印印刷书本装订A4彩印复印服务', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2214065076442/O1CN01N4xGsL1xSUD0BziJJ_!!2214065076442.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (234, '黑白彩色a4网上打印资料服务书本装订成册复印刷店山东次日达友余', 10.00, 63, '黑白彩色a4网上打印资料服务书本装订成册复印刷店山东次日达友余', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2219500581742/O1CN012tZU1X1OjszhMv7dz_!!2219500581742.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (235, '【抖音同款】漫画中华文化1000问正版中国文学常识一千问书籍儿童知识手册传统文化历史初中生小学生课外必备背世界百科大全本里的', 18.80, 72, '【抖音同款】漫画中华文化1000问正版中国文学常识一千问书籍儿童知识手册传统文化历史初中生小学生课外必备背世界百科大全本里的', 5, 'http://img.alicdn.com/img/i3/3735164215/O1CN01ss4RS11h0WUBPtbQR_!!4611686018427385143-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (236, '打印资料网上打印黑白彩印A4文件试卷复印印刷书本画册装订成册', 1.00, 67, '打印资料网上打印黑白彩印A4文件试卷复印印刷书本画册装订成册', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2644906024/O1CN01H8nIqI1uN2wlp41ab_!!2644906024.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (237, '辽宁沈阳资料打印网上打印电子书讲义打印装订效果图书册印刷激光 图书', 10.00, 62, '辽宁沈阳资料打印网上打印电子书讲义打印装订效果图书册印刷激光 图书', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2216014222812/O1CN01BLTnQx1Wdwgq70eYV_!!2216014222812.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (238, '打印资料网上打印快印印刷书本讲义装订成册彩色印复习资料复印店', 1.00, 20, '打印资料网上打印快印印刷书本讲义装订成册彩色印复习资料复印店', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/438854367/O1CN01Ki2tm91i88N3wIrS8_!!438854367.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (239, '打印资料网上打印复印彩色黑白书本印刷快印彩印打印文件装订成册', 10.00, 98, '打印资料网上打印复印彩色黑白书本印刷快印彩印打印文件装订成册', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i3/353018469/O1CN01Gcc8kn2CQrKMMOPk9_!!353018469.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (240, '打印资料装订成册网上文件彩色复印书本A4复印纸试卷图片铜版纸', 0.97, 51, '打印资料装订成册网上文件彩色复印书本A4复印纸试卷图片铜版纸', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2649646353/O1CN01sAISB21wnjFTLY56p_!!2649646353.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (241, '【新华书店正版】现货速发 2024新版 小学英语四年级上册 人教版教材课本教科书 人民教育出版社图书籍 4年级上册英语书 图书', 5.25, 82, '【新华书店正版】现货速发 2024新版 小学英语四年级上册 人教版教材课本教科书 人民教育出版社图书籍 4年级上册英语书 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2129856610/O1CN01uvmdnB1yhR09wDbKL_!!4611686018427381858-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (242, '高质量传统印刷强势文化手册成为高手的秘诀强者思维提升个人资料', 11.40, 66, '高质量传统印刷强势文化手册成为高手的秘诀强者思维提升个人资料', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2219065632811/O1CN01ZKRbRp1WdUNPbjvA2_!!2219065632811.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (243, '打印资料复印服务试卷培训教材书本A4B5彩打画册论文集胶装印刷名', 10.00, 26, '打印资料复印服务试卷培训教材书本A4B5彩打画册论文集胶装印刷名', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/1725737111/O1CN01pmzLVS22OtRjIxHj8_!!1725737111.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (244, '图书电子版代下代查帮下PDF电子版资料书籍文献古籍小说绝版旧书 图书', 1.00, 14, '图书电子版代下代查帮下PDF电子版资料书籍文献古籍小说绝版旧书 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2216878739003/O1CN01mxNx312GNQq8K4019_!!2216878739003.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (245, '代找电子书籍pdf电子版图书PDF古籍大学教材课本中英文pdf电子书 图书', 2.00, 66, '代找电子书籍pdf电子版图书PDF古籍大学教材课本中英文pdf电子书 图书', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2446335020/O1CN01q417rC1mxDJXN9x0b_!!2446335020.png_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (246, '正版图书了凡四训原版中华国学经典精粹 原文译文注释白话文对照 图书', 2.80, 35, '正版图书了凡四训原版中华国学经典精粹 原文译文注释白话文对照 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2215787488992/O1CN01DRvM6K2GIOTitMQHG_!!2215787488992.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (247, '找书PDF电子书籍pdf代找书大学课本教材疑难古籍代找电子版pdf', 2.00, 14, '找书PDF电子书籍pdf代找书大学课本教材疑难古籍代找电子版pdf', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/2217841605876/O1CN01PRruJN1tHGEwQ0C5r_!!2217841605876.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (248, '新版小学三年级上册语文数学书课本人教版教材教科书人民教育出版社义务教育教科书三上语数课本', 8.15, 37, '新版小学三年级上册语文数学书课本人教版教材教科书人民教育出版社义务教育教科书三上语数课本', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2219421930112/O1CN01Hiruts1ChLP45LBaw_!!4611686018427384448-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (249, '中国书法一本通大全正版书籍中国历代书法篆书楷书入门历代名家王羲之等收藏真迹艺术书法篆刻书法作品集书法集名帖一点通技法字典', 3.68, 49, '中国书法一本通大全正版书籍中国历代书法篆书楷书入门历代名家王羲之等收藏真迹艺术书法篆刻书法作品集书法集名帖一点通技法字典', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/722443368/O1CN01nl0QoN1akb044tCju_!!4611686018427386984-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (250, '打印资料次日达书本印刷讲义教材论文画册折页彩印装订成册打印店', 10.00, 98, '打印资料次日达书本印刷讲义教材论文画册折页彩印装订成册打印店', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2217885331894/O1CN0133urV01PrVD6wf3nB_!!2217885331894.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (251, '打印资料 网上打印a4彩印5分pdf书本复印黑白激光图文印刷装订', 10.00, 72, '打印资料 网上打印a4彩印5分pdf书本复印黑白激光图文印刷装订', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i4/2968534651/O1CN01H9TAdm1kECtlA1Oyj_!!2968534651.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (252, '打印资料印刷书画册装订成册定制书籍快印彩印复印定做书本图书A4 图书', 9.50, 73, '打印资料印刷书画册装订成册定制书籍快印彩印复印定做书本图书A4 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2712506658/O1CN01jK77Uf1z3PzUFcBYo_!!2712506658.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (253, '新版小学六年级上册语文数学英语全套书课本人教版教材教科书人民教育出版社义务教育教科书六上语数英课本', 7.61, 86, '新版小学六年级上册语文数学英语全套书课本人教版教材教科书人民教育出版社义务教育教科书六上语数英课本', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2219421930112/O1CN01bj1PWZ1ChLP4BUxuq_!!4611686018427384448-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (254, '打印资料彩色黑白激光打印书本胶装试卷合同标书网上打印山东临沂', 10.00, 40, '打印资料彩色黑白激光打印书本胶装试卷合同标书网上打印山东临沂', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/1868543345/O1CN011Jo73z1aa3q5FQRqT_!!1868543345.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (255, '打印资料网上打印快印印刷书本书籍装订成册彩印复习资料复印店', 9.50, 61, '打印资料网上打印快印印刷书本书籍装订成册彩印复习资料复印店', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/675354044/O1CN013z8nVE1fkCV1zZ9AI_!!675354044.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (256, '代找电子书籍pdf电子版图书PDF古籍教材课本中英文pdf电子书 图书', 3.00, 75, '代找电子书籍pdf电子版图书PDF古籍教材课本中英文pdf电子书 图书', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i3/2218573171208/O1CN01ezdreE1KnJRjBxM68_!!2218573171208.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (257, '特别关注杂志2025年1-8月【全年/半年订阅/2024/2023年1-12月】成熟男士读者意林青年文摘文学新闻时政话题非2022年合订过刊', 3.42, 68, '特别关注杂志2025年1-8月【全年/半年订阅/2024/2023年1-12月】成熟男士读者意林青年文摘文学新闻时政话题非2022年合订过刊', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/727242717/O1CN01Gp9HxF1VwRBIuPjBN_!!4611686018427385821-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (258, '代找各种电子书PDF图书大学教材中英文书籍PDF疑难书籍epub,mobi 图书', 3.00, 95, '代找各种电子书PDF图书大学教材中英文书籍PDF疑难书籍epub,mobi 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i4/2321267038/O1CN01jtHJw721rSa7abrih_!!2321267038.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (259, '培训资料印刷书本书籍定制个人印书打印a4彩印教材图书册子装订 图书', 10.00, 17, '培训资料印刷书本书籍定制个人印书打印a4彩印教材图书册子装订 图书', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i3/2216264121229/O1CN01Rz4SyR1Kwvd1zECUY_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (260, '中国名家获奖绘本一年级阅读课外书正版适合小学1年级看的儿童大班幼儿园专用3-5-6一8岁带拼音以上故事书3-6岁小学生注音版读物书', 23.80, 22, '中国名家获奖绘本一年级阅读课外书正版适合小学1年级看的儿童大班幼儿园专用3-5-6一8岁带拼音以上故事书3-6岁小学生注音版读物书', 5, 'http://img.alicdn.com/img/i2/5254943342/O1CN01v0Q4zl1aYgiyijTrM_!!4611686018427384430-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (261, '加厚版全套2册中国未解之谜+世界未解之谜百科全书小学生三至四五六年级课外阅读书籍正版少年儿童百科全书大全集科学青少年读物', 9.80, 79, '加厚版全套2册中国未解之谜+世界未解之谜百科全书小学生三至四五六年级课外阅读书籍正版少年儿童百科全书大全集科学青少年读物', 5, 'http://img.alicdn.com/img/i2/15940794/O1CN013BnQt71HjhW888afu_!!4611686018427387066-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (262, '西西弗书店 夜莺与玫瑰 精装定制版 王尔德童话全集 中英双语 浪漫永生不灭 当代文学中小学生课外阅读书目畅销书', 59.10, 84, '西西弗书店 夜莺与玫瑰 精装定制版 王尔德童话全集 中英双语 浪漫永生不灭 当代文学中小学生课外阅读书目畅销书', 5, 'http://img.alicdn.com/img/i1/1380100052/O1CN017bGyHW1CFrdFfIcEA_!!4611686018427381716-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (263, '【新华书店正版】让思考上瘾 逻辑学思维游戏书 让孩子放下手机天才的推理谜题入门经典必读比奥数有趣', 38.72, 49, '【新华书店正版】让思考上瘾 逻辑学思维游戏书 让孩子放下手机天才的推理谜题入门经典必读比奥数有趣', 5, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/3560214399/O1CN01ewsBa71iMnM2rRhuP_!!4611686018427383679-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (264, '草房子正版 曹文轩完整版青铜葵花根鸟四五年级下册课外阅读书籍老师推荐全套儿童文学8-10-12周岁畅销小说读物山羊不吃天堂草', 9.70, 24, '草房子正版 曹文轩完整版青铜葵花根鸟四五年级下册课外阅读书籍老师推荐全套儿童文学8-10-12周岁畅销小说读物山羊不吃天堂草', 5, 'http://img.alicdn.com/img/i2/6546025555/O1CN01tSiRVZ1quFDFmrJzO_!!4611686018427382867-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (265, '【2023年度中国好书】新世界史纲要软精装 钱乘旦教授主编 阐释世界历史横向和纵向发展交叉并举的客观事实新理念 世界史教科书籍', 30.42, 13, '【2023年度中国好书】新世界史纲要软精装 钱乘旦教授主编 阐释世界历史横向和纵向发展交叉并举的客观事实新理念 世界史教科书籍', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/919406354/O1CN01FqAdw61woBcAGRWP9_!!4611686018427381522-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (266, '【任选】我命由我不由天正版+难走的路从不拥挤 孩子为你自己读书 跳出内卷怪圈 认知觉醒摆脱焦虑 正能量人生哲学 青春励志书籍', 10.50, 25, '【任选】我命由我不由天正版+难走的路从不拥挤 孩子为你自己读书 跳出内卷怪圈 认知觉醒摆脱焦虑 正能量人生哲学 青春励志书籍', 5, 'http://img.alicdn.com/img/i3/14789935/O1CN01EtC5Ch2NGHz8HgSIl_!!4611686018427383087-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (267, '刘慈欣给孩子的科幻绘本全套8册 漫画日记系列误闯虫洞萨卡星人黑洞的制造者中国原创儿童科普绘本图画宇宙太空知识百科全书3-6岁', 13.36, 23, '刘慈欣给孩子的科幻绘本全套8册 漫画日记系列误闯虫洞萨卡星人黑洞的制造者中国原创儿童科普绘本图画宇宙太空知识百科全书3-6岁', 5, 'http://img.alicdn.com/img/i4/7184594464/O1CN011GtnJM1iqZ3R99KSE_!!4611686018427385376-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (268, '【新华书店 正版书籍】套装2册普通化学原理+普通化学原理习题解析 第4版 第四版 教材+习题解析 北京大学出版社 新华书店正版书籍', 20.21, 75, '【新华书店 正版书籍】套装2册普通化学原理+普通化学原理习题解析 第4版 第四版 教材+习题解析 北京大学出版社 新华书店正版书籍', 5, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2779887565/O1CN01PLAFZy25kpEPGNbqP_!!0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (269, '包邮 像间谍一样观察 杰克谢弗 马文卡林斯 著 微表情研究专家姜振宇倾情推荐 中信出版社图书 正版书籍', 34.70, 50, '包邮 像间谍一样观察 杰克谢弗 马文卡林斯 著 微表情研究专家姜振宇倾情推荐 中信出版社图书 正版书籍', 5, 'http://img.alicdn.com/img/i2/31738812/O1CN0157KUf92ExxBosduOA_!!4611686018427382716-0-saturn_solar.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (270, '官方正版 高效使用DeepSeek + DeepSeek使用指南 全职业场景应用实践（共2册套装）卢森煌 人工智能 AI 入门 职场 机械工业出版社', 31.82, 17, '官方正版 高效使用DeepSeek + DeepSeek使用指南 全职业场景应用实践（共2册套装）卢森煌 人工智能 AI 入门 职场 机械工业出版社', 5, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/707890731/O1CN01Q2vWRO1HGqZIaFCDd_!!4611686018427383339-0-item_pic.jpg_580x580q90.jpg_.webp');
INSERT INTO `product` VALUES (271, '全套4册 中国古代神话故事四年级上册阅读课外书必读正版的书籍快乐读书吧四上推荐古希腊世界经典神话与传说山海经小学生版老师', 9.30, 57, '全套4册 中国古代神话故事四年级上册阅读课外书必读正版的书籍快乐读书吧四上推荐古希腊世界经典神话与传说山海经小学生版老师', 5, 'http://img.alicdn.com/img/i1/7909103777/O1CN01BGCJaX1dlv0OgF8A3_!!4611686018427386017-0-saturn_solar.jpg_580x580q90.jpg_.webp');

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES (1, '智能家居', NULL);
INSERT INTO `product_category` VALUES (2, '户外运动', NULL);
INSERT INTO `product_category` VALUES (3, '电脑主板', NULL);
INSERT INTO `product_category` VALUES (4, '手机', NULL);
INSERT INTO `product_category` VALUES (5, '图书影像', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '彭海逸', '112211', '12345678', '3313079517@qq.com');

SET FOREIGN_KEY_CHECKS = 1;
