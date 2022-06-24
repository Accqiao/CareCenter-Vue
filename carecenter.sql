/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : carecenter

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 03/09/2021 10:57:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cid` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户id\r\n',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名称',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `illness` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '疾病，身体状况',
  `notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注意事项',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像路径',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('124532685745236985', '小红', 56, '女', '345454345', '良好', '注意不能吃涼的', '1630602490293.png');
INSERT INTO `customer` VALUES ('125423652698547856', '皇皇', 77, '女', '44563456789', '健康', '无', '1630601674582.jpg');
INSERT INTO `customer` VALUES ('258096197001303233', '李逍遥', 51, '女', '16598465545', '多动症、小儿麻痹', '不能看电视', '1630601687646.jpg');
INSERT INTO `customer` VALUES ('323424234232423423', '黑子', 88, '男', '12541258963', '无', '无', '1630631066003.png');
INSERT INTO `customer` VALUES ('333333333333333333', '张法', 33, NULL, '34534567890', '暂无', '无', '1630631073933.png');
INSERT INTO `customer` VALUES ('345515456561616555', 'Lisa', 48, '女', '15461511218', '正常', '无', '1630631083553.png');
INSERT INTO `customer` VALUES ('345678765456789876', '李丽', 77, '男', '15242632589', '无', '无', '1630631000499.jpg');
INSERT INTO `customer` VALUES ('354896587584586248', '姣姣', 88, '男', '15568688987', '正常', '无', '1630631020872.png');
INSERT INTO `customer` VALUES ('410110199011052222', '李白', 31, '男', '15079845445', '心脑血管疾病', '不吃酸，不吃辣', '1630600859608.jpg');
INSERT INTO `customer` VALUES ('410225198003211234', '一号', 42, '男', '15079095740', '阿尔茨海默病', '不吃辣', '1630602500197.png');
INSERT INTO `customer` VALUES ('421503620258745239', '卡卡', 70, '男', '56734567866', '健康', '无', '1630602507702.jpg');
INSERT INTO `customer` VALUES ('452136985214785698', '来来', 76, '女', '12345678987', '健康', 'ffadsdfsafdsffsda', '1630601738202.png');
INSERT INTO `customer` VALUES ('458523652142365896', '拉拉', 66, '女', '87908764567', '健康', '喜欢听收音机', '1630602517226.jpg');
INSERT INTO `customer` VALUES ('541257896521475365', '阿德', 101, '女', '15789652248', '脱发', '不喜欢小孩', '1630631044573.jpg');
INSERT INTO `customer` VALUES ('758269854125896548', '小刘', 88, '男', '18572698540', '高血糖', '喜欢看动漫', '1630631030793.jpg');
INSERT INTO `customer` VALUES ('856932541258745632', '溜溜', 76, '女', '52433465555', '健康', '暂无', '1630602526340.jpg');
INSERT INTO `customer` VALUES ('987687659120976543', '史蒂夫', 76, '男', '12546301957', '暂无', '暂无', '1630602536610.png');

-- ----------------------------
-- Table structure for distribution
-- ----------------------------
DROP TABLE IF EXISTS `distribution`;
CREATE TABLE `distribution`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supply_id` int(0) NULL DEFAULT NULL,
  `add_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of distribution
-- ----------------------------
INSERT INTO `distribution` VALUES (1, '124532685745236985', 5, '2021-09-02 17:11:43');
INSERT INTO `distribution` VALUES (2, '124532685745236985', 2, '2021-09-01 17:11:57');
INSERT INTO `distribution` VALUES (3, '124532685745236985', 2, '2021-08-27 17:18:54');
INSERT INTO `distribution` VALUES (4, '258096197001303233', 3, '2021-09-02 19:06:48');
INSERT INTO `distribution` VALUES (5, '258096197001303233', 4, '2021-09-02 21:13:30');
INSERT INTO `distribution` VALUES (6, '145225698745896521', 3, '2021-09-02 14:07:31');
INSERT INTO `distribution` VALUES (7, '124532685745236985', 6, '2021-09-03 00:40:00');
INSERT INTO `distribution` VALUES (8, '124532685745236985', 2, '2021-09-03 02:24:21');
INSERT INTO `distribution` VALUES (9, '124532685745236985', 9, '2021-09-03 02:36:10');

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`  (
  `food_id` int(0) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `food_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大荤；小荤；素菜；甜点；水果；套餐',
  `food_sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多糖；小糖；多脂肪；少脂肪；多盐；少盐',
  `food_price` decimal(10, 2) NULL DEFAULT NULL,
  `food_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_steam` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否清蒸；1为是；0为否',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`food_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES (1, '苹果', '水果', '少脂肪', 5.00, 'apple.webp', '0', '1. 慢性胃炎、消化不良、气滞不通者，便秘、慢性腹泻、神经性结肠炎，高血压、高血脂和肥胖患者，癌症患者、贫血和维生素缺乏者尤其适合。准妈妈每天吃个苹果可以减轻孕期反应；\r\n2. 肾炎和糖尿病患者不宜多吃。 苹果食疗作用\r\n苹果味甘、酸，性凉，归脾、肺经；\r\n具有生津、润肺，除烦解暑，开胃、醒酒，止泻的功效；\r\n主治中气不足，消化不良，气壅不通，轻度腹泻，便秘，烦热口渴，饮酒过度，高血压等。');
INSERT INTO `food` VALUES (2, '水煮蛋', '蛋制类', '高蛋白', 2.00, '1630466693620.webp', '0', '一个鸡蛋所含的热量，相当于半个苹果或半杯牛奶的热量，但是它还拥有人体每天所需8%的磷、4%的锌、4%的铁、12. 6%的蛋白质、6%的维生素D、3%的维生素E、6%的维生素A、2%的维生素B、5%的维生素B2、4%的维生素B6。这些营养都是人体必不可少的，它们起着极其重要的作用，如修复人体组织、形成新的组织、消耗能量和参与复杂的新陈代谢过程等。');
INSERT INTO `food` VALUES (4, '西红柿炒鸡蛋', '小荤', '健脑抗衰老', 4.00, '1630552950127.webp', '0', '西红柿炒蛋富含多种营养，它是女士保持好身材的一道美食。西红柿是人见人爱的食物之一，长相可爱，味美多汁，不仅能美容，其所含营养还能保护心脏，好处多多，实在是不可错过。鸡蛋营养丰富、易于保存、不用清洗，而且味道鲜美');
INSERT INTO `food` VALUES (5, '花生', '甜点', '油性', 21.00, '1630593886177.webp', '0', '花生可以榨油');
INSERT INTO `food` VALUES (6, '桃子', '水果', '无', 12.00, '1630629532024.webp', '0', '无');
INSERT INTO `food` VALUES (7, '栗子', '素菜', '无', 32.00, '1630636500684.webp', '1', '无');

-- ----------------------------
-- Table structure for nursing_content
-- ----------------------------
DROP TABLE IF EXISTS `nursing_content`;
CREATE TABLE `nursing_content`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `del_flag` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `serial_number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nursing_level` int(0) NULL DEFAULT NULL,
  `nursing_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `serial_price` decimal(10, 2) NULL DEFAULT NULL,
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `increment_flag` int(0) NULL DEFAULT NULL,
  `status` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nursing_content
-- ----------------------------
INSERT INTO `nursing_content` VALUES (1, NULL, '0', '01', 1, '整理内务', 50.00, '扫地、洗衣', 0, 1);
INSERT INTO `nursing_content` VALUES (2, NULL, '0', '02', 1, 'sdfkj', 100.00, 'asdlkj', 0, 1);
INSERT INTO `nursing_content` VALUES (3, NULL, '0', '03', 2, 'sdflkj', 75.00, 'a;lsdk', 0, 1);
INSERT INTO `nursing_content` VALUES (5, NULL, '0', '04', 2, '整理内务', 100.00, NULL, 0, 1);

-- ----------------------------
-- Table structure for nursing_level
-- ----------------------------
DROP TABLE IF EXISTS `nursing_level`;
CREATE TABLE `nursing_level`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `del_flag` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level_status` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nursing_level
-- ----------------------------
INSERT INTO `nursing_level` VALUES (1, NULL, '1', '初级', 2);
INSERT INTO `nursing_level` VALUES (2, NULL, '0', '中级', 1);
INSERT INTO `nursing_level` VALUES (3, NULL, '1', '高级', 1);
INSERT INTO `nursing_level` VALUES (4, '', '0', '顶级', 2);
INSERT INTO `nursing_level` VALUES (5, '', '1', '顶二', 2);
INSERT INTO `nursing_level` VALUES (6, '', '1', '顶三', 2);
INSERT INTO `nursing_level` VALUES (17, '', '0', '嗡嗡嗡', NULL);

-- ----------------------------
-- Table structure for nursing_record
-- ----------------------------
DROP TABLE IF EXISTS `nursing_record`;
CREATE TABLE `nursing_record`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `remarks` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `del_flag` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `customer_id` int(0) NULL DEFAULT NULL,
  `context_id` int(0) NULL DEFAULT NULL,
  `nursing_time` datetime(0) NULL DEFAULT NULL,
  `nursing_content` int(0) NULL DEFAULT NULL,
  `nursing_count` int(0) NULL DEFAULT NULL,
  `staffinfo_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nursing_record
-- ----------------------------
INSERT INTO `nursing_record` VALUES (1, NULL, '0', 1003, NULL, '2021-08-11 21:46:20', 1, 1, 3);
INSERT INTO `nursing_record` VALUES (2, NULL, '0', 1002, NULL, '2021-08-11 22:16:21', 1, 1, 4);
INSERT INTO `nursing_record` VALUES (3, NULL, '0', 1004, NULL, '2021-08-10 22:16:52', 2, 2, 7);
INSERT INTO `nursing_record` VALUES (5, '', '0', 1002, NULL, '2021-09-03 01:38:05', 3, 2, 2);

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `reid` int(0) NOT NULL AUTO_INCREMENT,
  `intime` date NOT NULL,
  `indescribe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cid` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rid` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `outtime` date NULL DEFAULT NULL,
  `outdescribe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`reid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `record_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `room` (`rid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (5, '2021-09-01', NULL, '258096197001303233', 'A102', '2021-09-03', '', 'over');
INSERT INTO `record` VALUES (6, '2021-09-01', '无', '410110199011052222', 'A302', NULL, NULL, 'using');
INSERT INTO `record` VALUES (10, '2021-09-02', NULL, '987687659120976543', 'A201', NULL, NULL, 'using');
INSERT INTO `record` VALUES (12, '2021-09-02', NULL, '333333333333333333', 'A101', NULL, NULL, 'using');
INSERT INTO `record` VALUES (20, '2021-09-03', '无', '410225198003211234', 'A102', NULL, NULL, 'using');
INSERT INTO `record` VALUES (23, '2021-09-03', NULL, '323424234232423423', 'B202', '2021-09-03', '无', 'over');
INSERT INTO `record` VALUES (25, '2021-09-03', NULL, '345678765456789876', 'B101', NULL, NULL, 'using');
INSERT INTO `record` VALUES (26, '2021-09-03', NULL, '452136985214785698', 'A303', '2021-09-03', 'null', 'over');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `rid` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `floor` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`rid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('A101', 1, NULL, 'using', '');
INSERT INTO `room` VALUES ('A102', 1, NULL, 'using', NULL);
INSERT INTO `room` VALUES ('A201', 2, NULL, 'using', NULL);
INSERT INTO `room` VALUES ('A202', 2, NULL, 'no', NULL);
INSERT INTO `room` VALUES ('A301', 3, NULL, 'no', NULL);
INSERT INTO `room` VALUES ('A302', 3, NULL, 'using', NULL);
INSERT INTO `room` VALUES ('A303', 3, NULL, 'no', NULL);
INSERT INTO `room` VALUES ('A401', 4, '', 'no', '');
INSERT INTO `room` VALUES ('A844', 8, '', 'no', '');
INSERT INTO `room` VALUES ('A866', 8, '', 'no', '');
INSERT INTO `room` VALUES ('B101', 1, '', 'using', '');
INSERT INTO `room` VALUES ('B102', 1, '', 'no', '');
INSERT INTO `room` VALUES ('B103', 1, '', 'no', '');
INSERT INTO `room` VALUES ('B201', 2, '', 'no', '');
INSERT INTO `room` VALUES ('B202', 2, NULL, 'no', NULL);
INSERT INTO `room` VALUES ('B204', 2, '', 'no', '');
INSERT INTO `room` VALUES ('B302', 3, '', 'no', '');
INSERT INTO `room` VALUES ('C201', 2, '', 'no', '');
INSERT INTO `room` VALUES ('C202', 2, '', 'no', '');
INSERT INTO `room` VALUES ('C303', 3, NULL, 'no', NULL);
INSERT INTO `room` VALUES ('C304', 3, '', 'no', '');
INSERT INTO `room` VALUES ('C305', 3, '', 'no', '');
INSERT INTO `room` VALUES ('D101', 1, NULL, 'no', NULL);

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `staff_id` int(0) NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `staff_age` int(0) NULL DEFAULT NULL,
  `staff_sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staff_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staff_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staff_entryTime` date NULL DEFAULT NULL,
  `staff_job` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staff_title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `staff_briefIntroduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`staff_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (4, '来来', 23, '女', '12345678900', '1630636438015.jpg', '2021-09-02', '医生', '高级', '嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻');
INSERT INTO `staff` VALUES (7, '叭叭', 34, '男', '212324334', '1630636944673.webp', '2021-09-02', '护工', '初级', '灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌灌');
INSERT INTO `staff` VALUES (8, '枝枝', 43, '女', '341243', '1630600691675.jpg', '2021-09-02', '护工', '初级', '就将计就计hthd');
INSERT INTO `staff` VALUES (9, '哈哈', 44, '男', '12542369852', '1630600700464.jpg', '2021-09-02', '医生', '五', '按时地方打SDAD撒');
INSERT INTO `staff` VALUES (11, '飒飒', 22, '女', '31254125032', '1630636458511.jpg', '2021-09-03', '护士', '', '');

-- ----------------------------
-- Table structure for supply
-- ----------------------------
DROP TABLE IF EXISTS `supply`;
CREATE TABLE `supply`  (
  `supply_id` int(0) NOT NULL AUTO_INCREMENT,
  `food_id` int(0) NULL DEFAULT NULL,
  `supply_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应类型；早餐；午餐；晚餐等',
  `supply_week` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设定星期几供应',
  `add_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`supply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supply
-- ----------------------------
INSERT INTO `supply` VALUES (1, 2, '早餐', '星期一', '2021-09-02 10:59:41');
INSERT INTO `supply` VALUES (2, 2, '早餐', '星期二', '2021-09-02 11:05:47');
INSERT INTO `supply` VALUES (3, 4, '午餐', '星期一', '2021-09-02 11:27:15');
INSERT INTO `supply` VALUES (4, 4, '午餐', '星期二', '2021-08-23 13:24:57');
INSERT INTO `supply` VALUES (5, 4, '午餐', '星期三', '2021-08-29 13:31:35');
INSERT INTO `supply` VALUES (6, 1, '下午茶', '星期三', '2021-09-02 13:58:37');
INSERT INTO `supply` VALUES (7, 1, '下午茶', '星期二', '2021-09-02 14:06:44');
INSERT INTO `supply` VALUES (8, 1, '早餐', '星期五', '2021-09-03 02:25:14');
INSERT INTO `supply` VALUES (9, 7, '夜宵', '星期五', '2021-09-03 02:35:23');

SET FOREIGN_KEY_CHECKS = 1;
