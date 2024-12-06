/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : nexnote

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 07/12/2024 04:15:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for note_page
-- ----------------------------
DROP TABLE IF EXISTS `note_page`;
CREATE TABLE `note_page` (
  `page_id` bigint NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `space_id` bigint NOT NULL COMMENT '空间id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `parent_id` bigint DEFAULT '0' COMMENT '上级id，0是顶级',
  `sort_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '排序号',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面图标',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New Page' COMMENT '页面标题',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面封面',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '笔记内容',
  `collect` int DEFAULT '0' COMMENT '收藏：0否，1收藏',
  `layout` enum('big','default','small','mobile') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'default' COMMENT '页面布局',
  `font` enum('默认','衬线体','等宽体') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '默认' COMMENT '字体',
  `size` enum('12','14','16','18','20') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '16' COMMENT '字体大小',
  `readonly` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '只读：0可以编辑，1只读',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码：NULL不加密',
  `bottominfo` int DEFAULT '0' COMMENT '底部信息，0默认开启，1关闭',
  `template` int DEFAULT '0' COMMENT '模板：0普通页面，1~n 模板',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`page_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1864991406103945219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='页面';

-- ----------------------------
-- Records of note_page
-- ----------------------------
BEGIN;
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864975123333472257, 23, 1859329812227633153, 0, NULL, NULL, '欢迎来到', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 18:08:13', '2024-11-15 19:21:17');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864975873375690753, 23, 1859329812227633153, 1864975123333472257, NULL, NULL, 'New Page1', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 18:11:12', '2024-12-04 19:21:20');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864975889678950402, 1864975846142074882, 1859329812227633153, 0, NULL, NULL, 'New Page2', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 18:11:16', '2024-12-05 19:21:22');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864989580021424129, 23, 1859329812227633153, 1864975873375690753, NULL, NULL, 'New Page3', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 19:05:40', '2024-12-06 19:19:25');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864989582475091970, 23, 1859329812227633153, 1864989580021424129, NULL, NULL, 'New Page4', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 19:05:40', '2024-12-06 19:21:28');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `bottominfo`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1864991406103945218, 23, 1859329812227633153, 0, NULL, NULL, 'hello', NULL, NULL, 0, 'default', '默认', '16', '0', NULL, 0, 0, 0, '2024-12-06 19:12:55', '2024-12-06 19:21:31');
COMMIT;

-- ----------------------------
-- Table structure for note_page_history
-- ----------------------------
DROP TABLE IF EXISTS `note_page_history`;
CREATE TABLE `note_page_history` (
  `page_history_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `page_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面id',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '历史版本',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'space' COMMENT '页面标题',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面图标',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '笔记内容',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面封面',
  `time_limit` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '期限，默认7天',
  `is_current_version` int DEFAULT '0' COMMENT '当前使用版本：0历史版本，1当前使用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`page_history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='笔记编辑历史版本';

-- ----------------------------
-- Records of note_page_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for note_page_setting
-- ----------------------------
DROP TABLE IF EXISTS `note_page_setting`;
CREATE TABLE `note_page_setting` (
  `page_setting_id` int NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `page_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '空间id',
  `font` enum('默认','衬线体','等宽体') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '默认' COMMENT '字体',
  `size` enum('12','14','16','18','20') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '14' COMMENT '字体大小',
  `layout` enum('large','default','mobile') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'default' COMMENT '页面布局',
  `read` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '只读：0可以编辑，1只读',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码：NULL不加密',
  `titlenumber` int DEFAULT NULL COMMENT '标题自动编号, 0默认不编号, 1自动编号',
  `bottominfo` int DEFAULT NULL COMMENT '底部信息，0默认开启，1关闭',
  `template` int DEFAULT NULL COMMENT '模板：0普通页面，1~n 模板',
  `background` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面背景',
  PRIMARY KEY (`page_setting_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='页面设置';

-- ----------------------------
-- Records of note_page_setting
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for note_setting
-- ----------------------------
DROP TABLE IF EXISTS `note_setting`;
CREATE TABLE `note_setting` (
  `setting_id` int NOT NULL AUTO_INCREMENT COMMENT '笔记全局设置id',
  `user_id` int NOT NULL COMMENT '用户id',
  `sidebar` int DEFAULT '300' COMMENT '侧边栏：0收起，n宽度',
  `tools_sidebar` int DEFAULT '300' COMMENT '工具侧边栏：0收起，n宽度',
  `language` enum('简体中文','English') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '简体中文' COMMENT '语言',
  `theme` int DEFAULT '0' COMMENT '主题：0白，1黑',
  `start_page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '启动时展示页面：0默认主页，n上次操作的页面',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`setting_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='笔记全局设置';

-- ----------------------------
-- Records of note_setting
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for note_space
-- ----------------------------
DROP TABLE IF EXISTS `note_space`;
CREATE TABLE `note_space` (
  `space_id` bigint NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New Space' COMMENT '空间名称',
  `color` int DEFAULT '1' COMMENT '空间配色',
  `default_space` int DEFAULT '1' COMMENT '默认空间, 0默认, 1其它',
  `sort_number` int DEFAULT '1' COMMENT '排序号',
  `deleted` int DEFAULT '0' COMMENT '是否删除, 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`space_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1865127522755346435 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='笔记空间';

-- ----------------------------
-- Records of note_space
-- ----------------------------
BEGIN;
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (23, 1859329812227633153, '默认空间5', 6, 0, 1, 0, '2024-12-06 18:06:09', '2024-12-07 04:13:52');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865114974245064705, 1859329812227633153, '34', 1, 1, 9, 0, '2024-12-07 03:23:56', '2024-12-07 04:13:23');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865120210800046081, 1859329812227633153, '是对方', 4, 1, 9, 0, '2024-12-07 04:08:49', '2024-12-07 04:13:34');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865127025155702785, 1859329812227633153, '4354543', 1, 1, 9, 0, '2024-12-07 04:11:49', '2024-12-07 04:13:52');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865127394644525057, 1859329812227633153, '34', 1, 1, 9, 0, '2024-12-07 04:13:17', '2024-12-07 04:13:17');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865127493261000706, 1859329812227633153, '425', 5, 1, 9, 0, '2024-12-07 04:13:41', '2024-12-07 04:13:41');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `default_space`, `sort_number`, `deleted`, `create_time`, `update_time`) VALUES (1865127522755346434, 1859329812227633153, '444', 1, 1, 9, 0, '2024-12-07 04:13:48', '2024-12-07 04:13:48');
COMMIT;

-- ----------------------------
-- Table structure for note_subscribe
-- ----------------------------
DROP TABLE IF EXISTS `note_subscribe`;
CREATE TABLE `note_subscribe` (
  `subscribe_id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `subscribe_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
  `subscribe_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐标识',
  `comments` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `oldprice` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '原价',
  `unit` int NOT NULL DEFAULT '30' COMMENT '套餐订阅天数，0为无限',
  `space` int DEFAULT '3' COMMENT '空间个数',
  `recycle` int DEFAULT '30' COMMENT '回收站最大天数',
  `page_history` int DEFAULT '30' COMMENT '页面编辑历史记录最大天数',
  `page_wordage` int DEFAULT '10000' COMMENT '单页面最大字数，0等于无限',
  `ai` int DEFAULT '5' COMMENT 'AI 每天使用次数，0等于无限',
  `recommend` tinyint DEFAULT '0' COMMENT '是否推荐 1 表示推荐，0 表示不推荐',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态, 0正常, 1下架',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`subscribe_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of note_subscribe
-- ----------------------------
BEGIN;
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `comments`, `price`, `oldprice`, `unit`, `space`, `recycle`, `page_history`, `page_wordage`, `ai`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (1, '个人普通版', 'Lite', '普通用户Lite', 0.00, 0.00, 0, 3, 30, 30, 10000, 5, 0, 0, 0, '2024-11-21 23:49:51', '2024-12-05 17:03:02');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `comments`, `price`, `oldprice`, `unit`, `space`, `recycle`, `page_history`, `page_wordage`, `ai`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (2, '个人Plus+', 'Plus', '个人Plus版', 12.00, 24.00, 30, 5, 30, 30, 100000, 10, 1, 0, 0, '2024-11-21 23:50:47', '2024-12-05 18:40:24');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `comments`, `price`, `oldprice`, `unit`, `space`, `recycle`, `page_history`, `page_wordage`, `ai`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (3, '团队版', 'Team', '团队版', 48.00, 68.00, 90, 10, 90, 90, 0, 100, 0, 0, 0, '2024-11-21 23:51:35', '2024-12-05 18:41:23');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `comments`, `price`, `oldprice`, `unit`, `space`, `recycle`, `page_history`, `page_wordage`, `ai`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (4, '企业版', 'Business', '企业版：AI、字数不限', 88.00, 120.00, 366, 20, 365, 365, 0, 0, 0, 0, 0, '2024-11-21 23:54:11', '2024-12-05 18:41:20');
COMMIT;

-- ----------------------------
-- Table structure for note_subscribe_order
-- ----------------------------
DROP TABLE IF EXISTS `note_subscribe_order`;
CREATE TABLE `note_subscribe_order` (
  `subscribe_order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐订单id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `subscribe_id` bigint NOT NULL COMMENT '套餐id',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态, 0订单完成, 1订单异常，2已退款、3支付失败',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`subscribe_order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53453645766 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户套餐订单';

-- ----------------------------
-- Records of note_subscribe_order
-- ----------------------------
BEGIN;
INSERT INTO `note_subscribe_order` (`subscribe_order_id`, `user_id`, `subscribe_id`, `status`, `create_time`) VALUES (32425, 1859329812227633153, 3, 0, '2024-02-15 11:28:29');
INSERT INTO `note_subscribe_order` (`subscribe_order_id`, `user_id`, `subscribe_id`, `status`, `create_time`) VALUES (43523, 1859329812227633153, 3, 0, '2024-11-05 10:46:50');
INSERT INTO `note_subscribe_order` (`subscribe_order_id`, `user_id`, `subscribe_id`, `status`, `create_time`) VALUES (43557657, 1859329962681511937, 4, 0, '2024-10-16 11:28:29');
INSERT INTO `note_subscribe_order` (`subscribe_order_id`, `user_id`, `subscribe_id`, `status`, `create_time`) VALUES (53453645765, 1859329812227633153, 2, 1, '2024-10-04 11:28:29');
COMMIT;

-- ----------------------------
-- Table structure for note_template
-- ----------------------------
DROP TABLE IF EXISTS `note_template`;
CREATE TABLE `note_template` (
  `template_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'admin' COMMENT '用户或管理员',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户邮箱',
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '未命名' COMMENT '模板名称',
  `preview` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预览图',
  `comments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板描述',
  `recommend` tinyint DEFAULT '0' COMMENT '是否推荐 1 表示推荐，0 表示不推荐',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态, 0正常, 1下架',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`template_id`) USING BTREE,
  KEY `sys_user` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='模板中心';

-- ----------------------------
-- Records of note_template
-- ----------------------------
BEGIN;
INSERT INTO `note_template` (`template_id`, `role`, `email`, `template_name`, `preview`, `comments`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (1, 'admin', '2405824084@qq.com', '哈哈哈', 'SystemDefaultFiles/images/template/template1.jpg', 'todolist', 0, 0, 0, '2024-11-23 03:19:40', '2024-11-23 23:02:51');
INSERT INTO `note_template` (`template_id`, `role`, `email`, `template_name`, `preview`, `comments`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (2, 'admin', 'zhang3@qq.com', 'hello', 'SystemDefaultFiles/images/template/template2.jpg', 'helloworld', 1, 1, 0, '2024-11-23 03:49:44', '2024-11-23 23:02:55');
INSERT INTO `note_template` (`template_id`, `role`, `email`, `template_name`, `preview`, `comments`, `recommend`, `status`, `deleted`, `create_time`, `update_time`) VALUES (3, 'user', '123@gmail.com', '记录', 'SystemDefaultFiles/images/template/template3.jpg', '记录花销', 0, 0, 0, '2024-11-23 16:24:43', '2024-11-23 23:03:02');
COMMIT;

-- ----------------------------
-- Table structure for note_user
-- ----------------------------
DROP TABLE IF EXISTS `note_user`;
CREATE TABLE `note_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱/账号',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Nex笔记' COMMENT '昵称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'SystemDefaultFiles/images/avatar/avatar-default.png' COMMENT '头像',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态, 0正常, 1冻结，2异常，3注销',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1864112813100064771 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户';

-- ----------------------------
-- Records of note_user
-- ----------------------------
BEGIN;
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859329812227633153, 'xiaoli@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$eZP8YBEbLeM7NQOSRZRUPQ$9pDUvkdrXFrE5P2pZvIbJoySlXkKJHF+mXEsGLtHMco', 'Mary', 'UserFiles/images/avatar/a6540470-d522-42f1-bed0-a9fb7b73d4eb.jpg', 0, '2024-11-21 04:15:46', '2024-12-06 01:33:27');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859329962681511937, 'tianxiang@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$dzKkxYHuHWkuIfjte3QRMw$lRrnCd1CBy/YV2G0F1bNaRV2qJk/yZgsNS1zluCfUkM', '天线宝宝', 'UserFiles/images/avatar/13549b95-c562-4e76-8887-25bfffe7f75f.jpg', 3, '2024-11-21 04:16:22', '2024-11-21 04:23:18');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859330063948787713, 'mu@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$jpq6HipmtzNNj0Z3ZrBkGw$vX6rNTFtaCLGa992QT/iJ8+VwayReyhiBi8jxIjGbsk', '34', 'UserFiles/images/avatar/7d3290e6-3492-4fef-8e3a-33635f16de95.jpeg', 0, '2024-11-21 04:16:46', '2024-11-23 20:38:39');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859330240466071553, 'hello@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$f4a5fVafHq4eILipD6EM3Q$Xmz9b6uJQnCDi4BoYT/+c0PcRKKrdKkB1ceksRoMrVY', 'Nex笔记', 'UserFiles/images/avatar/9959db3c-5233-4340-8a9f-052b16ea6746.jpg', 0, '2024-11-21 04:17:28', '2024-11-21 04:17:28');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859330354152681474, '123@gmail.com', '$argon2i$v=19$m=65536,t=2,p=1$gpC4GwVRXdFhNdIACy8LOw$c794g7ddJ2gpP2ynjWEWyImBhXFotlF0Yj7FO1kHDLU', 'hai', 'UserFiles/images/avatar/dfd93a19-9deb-4e20-8439-7822d34e2f64.png', 2, '2024-11-21 04:17:55', '2024-11-21 04:23:11');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859330498411573249, 'huo@gmail.com', '$argon2i$v=19$m=65536,t=2,p=1$1ytWsbBIDAQ1KCUyNaUzUA$uH3MT+/FhoXWbJ1WuFPm1Jrif+eJeWrMHS3mYBJBPo0', 'sadness and sorrow', 'UserFiles/images/avatar/9b812e3a-cedf-4a39-8d9a-f27c84987811.jpg', 0, '2024-11-21 04:18:30', '2024-11-21 04:18:30');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859330612005908481, '456@gmail.com', '$argon2i$v=19$m=65536,t=2,p=1$4SmDSzBZ1q1k/VUzebzd9Q$Tp7k1DA3mIyX4JzqmRu6w1m9vBg5XGIDkfcuMoYde1M', '静静的', 'UserFiles/images/avatar/782146e7-ed97-443f-9c72-7cccbb5e527e.png', 0, '2024-11-21 04:18:57', '2024-11-21 04:18:57');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859331362777935873, 'haha@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$rt5zwtlasrlNqywKELpwTQ$FUH8nqWDWygpQh+HlAyC58uIIvFE7d5H40ra0puBoyo', 'HaHa', 'UserFiles/images/avatar/81fd04de-0421-4f31-95b3-dffb717d5576.jpeg', 0, '2024-11-21 04:21:56', '2024-11-21 04:21:56');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859331453530091521, 'lanqiu@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$plXw9J3v4ynmUZu0nWLt1A$aeJCXTu0h8eb+NKL5/ltWJTsqvDge0y79YFS/KIasjE', 'Nex笔记', 'UserFiles/images/avatar/7eba530c-498d-4ede-98f7-c4a406e832cf.png', 0, '2024-11-21 04:22:17', '2024-11-21 04:22:17');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859331507322040322, 'ikun@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$LCAZtgq43BFmQIoY9kvifA$KriA2fpY5rsi9W5ErIw86JE9ek8yYt8YpajPRv4zDlY', 'Nex笔记', 'UserFiles/images/avatar/17561444-e861-48c5-9a28-6fc2b6df93b7.png', 1, '2024-11-21 04:22:30', '2024-11-21 14:55:29');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859331602964754433, 'gou@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$H6AyQ4DX5Z5wO5OwrMeFZg$UEKkizA8853ibIpdS3W+e1WW1BqbgInNxTDq6pyeTFA', '小狗儿', 'UserFiles/images/avatar/5d18bbf9-1d3d-47d2-aa1a-78e8733f4829.jpg', 0, '2024-11-21 04:22:53', '2024-11-21 04:22:53');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1859490692863156226, 'zhezie@qq.om', '$argon2i$v=19$m=65536,t=2,p=1$WvPRTi2speeVhdJ2wCIFYQ$BdeQ9IVbKBZE3SOrSEuOKu0gtQC+7jHsNBc8iidfqQY', '紫则', 'UserFiles/images/avatar/7d20b48a-0ce3-4035-b939-e1b8dbc9aed6.png', 0, '2024-11-21 14:55:03', '2024-11-21 14:55:03');
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1864112813100064770, '2405824084@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$43mI6ZBKGx8gYjUVQZxRFw$sNJHBwefq7OZxwhm0BTlZ20GMyppniG6VxkRWaufhZU', 'Nex笔记', 'SystemDefaultFiles/images/avatar/avatar-default.png', 0, '2024-12-04 09:01:42', '2024-12-04 09:01:42');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int NOT NULL DEFAULT '0' COMMENT '上级id, 0是顶级',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单路由地址',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单组件地址, 目录可为空',
  `menu_type` int DEFAULT '0' COMMENT '类型, 0菜单, 1按钮',
  `sort_number` int NOT NULL DEFAULT '1' COMMENT '排序号',
  `authority` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单图标',
  `hide` int NOT NULL DEFAULT '0' COMMENT '是否隐藏, 0否, 1是(仅注册路由不显示在左侧菜单)',
  `meta` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它路由元信息',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (1, 0, '系统管理', '/system', NULL, 0, 500, NULL, 'Setting', 0, '{\"badge\": \"New\", \"badgeColor\": \"warning\"}', 0, '2020-02-26 12:51:23', '2024-10-14 00:19:14');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (2, 1, '系统用户管理', '/system/user', '/system/user', 0, 2, NULL, 'el-icon-_user-group', 0, NULL, 0, '2020-02-26 12:51:55', '2024-11-14 20:42:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (3, 2, '查询用户', NULL, NULL, 1, 1, 'sys:user:list', NULL, 0, NULL, 0, '2020-02-26 12:52:06', '2020-09-16 11:05:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (4, 2, '添加用户', NULL, NULL, 1, 2, 'sys:user:save', NULL, 0, NULL, 0, '2020-02-26 12:52:26', '2020-03-21 18:45:29');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (5, 2, '修改用户', NULL, NULL, 1, 3, 'sys:user:update', NULL, 0, NULL, 0, '2020-02-26 12:52:50', '2020-03-21 18:45:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (6, 2, '删除用户', NULL, NULL, 1, 4, 'sys:user:remove', NULL, 0, NULL, 0, '2020-02-26 12:53:13', '2020-03-21 18:45:32');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (7, 1, '系统角色管理', '/system/role', '/system/role', 0, 3, NULL, 'el-icon-postcard', 0, NULL, 0, '2020-03-13 13:29:08', '2024-11-14 20:42:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (8, 7, '查询角色', NULL, NULL, 1, 1, 'sys:role:list', NULL, 0, NULL, 0, '2020-03-13 13:30:41', '2020-03-21 18:45:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (9, 7, '添加角色', NULL, NULL, 1, 2, 'sys:role:save', NULL, 0, NULL, 0, '2020-03-15 13:02:07', '2020-03-21 18:45:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (10, 7, '修改角色', NULL, NULL, 1, 3, 'sys:role:update', NULL, 0, NULL, 0, '2020-03-15 13:02:49', '2020-03-21 18:45:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (11, 7, '删除角色', NULL, NULL, 1, 4, 'sys:role:remove', NULL, 0, NULL, 0, '2020-03-20 17:58:51', '2020-03-21 18:45:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (12, 1, '系统菜单管理', '/system/menu', '/system/menu', 0, 4, NULL, 'el-icon-s-operation', 0, NULL, 0, '2020-03-21 01:07:13', '2024-11-14 20:42:39');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (13, 12, '查询菜单', NULL, NULL, 1, 1, 'sys:menu:list', NULL, 0, NULL, 0, '2020-03-21 16:43:30', '2020-03-21 18:45:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (14, 12, '添加菜单', NULL, NULL, 1, 2, 'sys:menu:save', NULL, 0, NULL, 0, '2020-03-21 16:43:54', '2020-03-21 18:45:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (15, 12, '修改菜单', NULL, NULL, 1, 3, 'sys:menu:update', NULL, 0, NULL, 0, '2020-03-21 18:24:17', '2020-03-21 18:45:43');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (16, 12, '删除菜单', NULL, NULL, 1, 4, 'sys:menu:remove', NULL, 0, NULL, 0, '2020-03-21 18:24:18', '2020-03-21 18:45:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (27, 1, '系统登录日志', '/system/login-record', '/system/login-record', 0, 5, 'sys:login-record:list', 'el-icon-date', 0, NULL, 0, '2020-03-21 18:24:33', '2024-11-14 20:42:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (28, 1, '系统操作日志', '/system/operation-record', '/system/operation-record', 0, 6, 'sys:operation-record:list', 'el-icon-_retrieve', 0, NULL, 0, '2020-03-21 18:24:34', '2024-11-14 20:42:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (29, 1, '文件管理', '/system/file', '/system/file', 0, 6, NULL, 'el-icon-folder', 1, NULL, 0, '2020-09-17 23:19:43', '2022-03-11 22:13:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (30, 29, '上传文件', NULL, NULL, 1, 1, 'sys:file:upload', NULL, 0, NULL, 0, '2020-09-17 23:21:04', '2022-07-20 16:40:21');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (31, 29, '删除文件', NULL, NULL, 1, 2, 'sys:file:remove', NULL, 0, NULL, 0, '2020-09-17 23:21:53', '2022-07-20 16:40:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (32, 29, '查看记录', NULL, NULL, 1, 3, 'sys:file:list', NULL, 0, NULL, 0, '2020-09-17 23:20:29', '2022-07-20 16:40:24');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (33, 2, '用户详情', '/system/user/details', '/system/user/details', 0, 5, NULL, 'el-icon-user', 1, '{\"active\": \"/system/user\"}', 0, '2021-05-21 11:07:54', '2022-07-20 16:39:29');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (34, 1, '修改个人密码', NULL, NULL, 1, 9, 'sys:auth:password', NULL, 0, NULL, 0, '2020-09-17 23:22:45', '2022-07-20 16:40:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (35, 1, '修改个人资料', NULL, NULL, 1, 10, 'sys:auth:user', NULL, 0, NULL, 0, '2020-09-17 23:23:24', '2022-07-20 16:40:55');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (36, 0, '仪表板', '/dashboard', NULL, 0, 0, NULL, 'House', 0, NULL, 0, '2021-02-02 20:00:34', '2024-10-11 21:38:02');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (37, 36, '工作台', '/dashboard/workplace', '/dashboard/workplace', 0, 1, NULL, 'el-icon-monitor', 0, NULL, 0, '2021-02-02 20:00:37', '2021-11-05 16:36:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (38, 36, '分析页', '/dashboard/analysis', '/dashboard/analysis', 0, 2, NULL, 'el-icon-data-analysis', 0, '{\"badge\": 1}', 0, '2021-02-02 20:00:40', '2022-03-11 16:45:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (39, 36, '监控页', '/dashboard/monitor', '/dashboard/monitor', 0, 3, NULL, 'el-icon-odometer', 0, NULL, 0, '2021-02-02 20:03:12', '2021-11-05 16:36:56');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (40, 0, '表单页面0001', '/form', NULL, 0, 2, NULL, 'el-icon-tickets', 0, NULL, 0, '2021-02-02 20:03:28', '2024-10-11 13:08:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (41, 40, '基础表单', '/form/basic', '/form/basic', 0, 1, NULL, 'el-icon-_feedback', 0, NULL, 0, '2021-02-02 20:03:51', '2021-11-05 16:36:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (42, 40, '复杂表单', '/form/advanced', '/form/advanced', 0, 2, NULL, 'el-icon-_visa', 0, NULL, 0, '2021-02-02 20:03:56', '2021-11-05 16:36:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (43, 40, '分步表单', '/form/step', '/form/step', 0, 3, NULL, 'el-icon-c-scale-to-original', 0, NULL, 0, '2021-02-02 20:04:06', '2021-11-05 16:36:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (44, 0, '列表页面', '/list', NULL, 0, 3, NULL, 'el-icon-_table', 0, NULL, 0, '2021-02-02 20:05:07', '2021-11-05 16:36:49');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (45, 44, '基础列表', '/list/basic', '/list/basic', 0, 1, NULL, 'el-icon-document', 0, NULL, 0, '2021-02-02 20:05:10', '2021-11-05 16:36:48');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (46, 44, '复杂列表', '/list/advanced', '/list/advanced', 0, 2, NULL, 'el-icon-_cols', 0, NULL, 0, '2021-02-02 20:05:26', '2021-11-05 16:36:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (47, 44, '卡片列表', '/list/card', '/list/card', 0, 3, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:05:30', '2021-11-05 16:36:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (48, 47, '项目列表', '/list/card/project', '/list/card/project', 0, 1, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:35', '2021-11-05 16:36:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (49, 47, '应用列表', '/list/card/application', '/list/card/application', 0, 2, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:39', '2021-11-05 16:36:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (50, 47, '文章列表', '/list/card/article', '/list/card/article', 0, 3, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:48', '2021-11-05 16:36:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (51, 45, '添加用户', '/list/basic/add', '/list/basic/add', 0, 1, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:25');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (52, 45, '修改用户', '/list/basic/edit', '/list/basic/edit', 0, 2, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:26');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (53, 45, '用户详情', '/list/basic/details/:id', '/list/basic/details', 0, 3, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (54, 0, '结果页面', '/result', NULL, 0, 4, NULL, 'el-icon-circle-check', 0, NULL, 0, '2021-02-02 20:07:33', '2021-11-05 16:36:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (55, 54, '成功页', '/result/success', '/result/success', 0, 1, NULL, 'el-icon-circle-check', 0, NULL, 0, '2021-02-02 20:07:40', '2021-11-05 16:36:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (56, 54, '失败页', '/result/fail', '/result/fail', 0, 2, NULL, 'el-icon-circle-close', 0, NULL, 0, '2021-02-02 20:07:41', '2021-11-05 16:36:37');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (57, 0, '异常页面', '/exception', NULL, 0, 5, NULL, 'el-icon-document-delete', 0, NULL, 0, '2021-02-02 20:08:44', '2021-11-05 16:36:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (58, 57, '403', '/exception/403', '/exception/403', 0, 1, NULL, 'el-icon-document-checked', 0, NULL, 0, '2021-02-02 20:08:47', '2021-11-05 16:36:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (59, 57, '404', '/exception/404', '/exception/404', 0, 2, NULL, 'el-icon-document-remove', 0, NULL, 0, '2021-02-02 20:08:49', '2021-11-05 16:36:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (60, 57, '500', '/exception/500', '/exception/500', 0, 3, NULL, 'el-icon-document-delete', 0, NULL, 0, '2021-02-02 20:08:52', '2021-11-05 16:36:33');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (61, 1, '个人中心', '/user', NULL, 0, 1, NULL, 'Tickets', 0, NULL, 0, '2021-02-02 20:09:54', '2024-11-14 20:42:13');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (62, 61, '我的资料', '/user/profile', '/user/profile', 0, 1, NULL, 'el-icon-user', 0, NULL, 0, '2021-02-02 20:09:58', '2021-11-05 16:36:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (64, 0, '扩展组件', '/extension', NULL, 0, 7, NULL, 'el-icon-open', 0, NULL, 0, '2021-02-02 20:10:52', '2021-11-05 16:36:26');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (65, 64, '图标扩展', '/extension/icon', '/extension/icon', 0, 1, NULL, 'el-icon-_heart', 0, NULL, 0, '2021-02-02 20:10:55', '2022-03-11 21:36:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (66, 64, '标签组件', '/extension/tag', '/extension/tag', 0, 2, NULL, 'el-icon-price-tag', 0, NULL, 0, '2021-10-05 11:13:35', '2022-03-11 21:42:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (67, 64, '弹窗扩展', '/extension/dialog', '/extension/dialog', 0, 3, NULL, 'el-icon-copy-document', 0, NULL, 0, '2021-10-05 11:32:12', '2022-03-11 21:42:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (68, 64, '文件列表', '/extension/file', '/extension/file', 0, 4, NULL, 'el-icon-folder', 0, NULL, 0, '2021-02-02 20:10:58', '2022-03-11 21:37:16');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (69, 64, '图片上传', '/extension/upload', '/extension/upload', 0, 5, NULL, 'el-icon-picture-outline', 0, NULL, 0, '2021-02-02 20:10:58', '2022-07-20 16:49:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (70, 64, '拖拽排序', '/extension/dragsort', '/extension/dragsort', 0, 6, NULL, 'el-icon-rank', 0, NULL, 0, '2021-02-02 20:11:48', '2022-07-20 16:43:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (71, 64, '消息提示', '/extension/message', '/extension/message', 0, 7, NULL, 'el-icon-chat-line-square', 0, NULL, 0, '2021-10-05 11:14:28', '2022-07-20 16:43:39');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (72, 64, '城市选择', '/extension/regions', '/extension/regions', 0, 8, NULL, 'el-icon-office-building', 0, NULL, 0, '2021-10-05 11:25:15', '2022-07-20 16:43:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (73, 64, '打印插件', '/extension/printer', '/extension/printer', 0, 9, NULL, 'el-icon-printer', 0, NULL, 0, '2021-02-02 20:11:00', '2022-07-20 16:43:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (74, 64, 'excel插件', '/extension/excel', '/extension/excel', 0, 10, NULL, 'el-icon-_table', 0, NULL, 0, '2021-02-02 20:11:03', '2022-07-20 16:43:43');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (75, 64, '滚动数字', '/extension/count-up', '/extension/count-up', 0, 11, NULL, 'el-icon-more', 0, NULL, 0, '2021-10-05 11:29:03', '2022-07-20 16:43:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (76, 64, '空状态', '/extension/empty', '/extension/empty', 0, 12, NULL, 'el-icon-receiving', 0, NULL, 0, '2021-10-05 11:20:35', '2022-07-20 16:43:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (77, 64, '步骤条', '/extension/steps', '/extension/steps', 0, 13, NULL, 'el-icon-_timeline', 0, NULL, 0, '2021-10-05 11:16:39', '2022-07-20 16:43:49');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (78, 64, '菜单导航', '/extension/menu', '/extension/menu', 0, 14, NULL, 'el-icon-s-operation', 0, NULL, 0, '2021-10-05 11:18:35', '2022-07-20 16:43:51');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (79, 64, '树形下拉', '/extension/tree-select', '/extension/tree-select', 0, 15, NULL, 'el-icon-_condition', 0, NULL, 0, '2021-10-10 16:21:12', '2022-07-20 16:43:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (80, 64, '表格下拉', '/extension/table-select', '/extension/table-select', 0, 16, NULL, 'el-icon-_table', 0, NULL, 0, '2021-10-10 16:21:45', '2022-07-20 16:43:54');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (81, 64, '分割布局', '/extension/split-layout', '/extension/split-layout', 0, 17, NULL, NULL, 0, NULL, 1, '2021-10-10 16:21:45', '2022-07-20 16:45:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (82, 64, '视频播放', '/extension/player', '/extension/player', 0, 18, NULL, 'el-icon-_video', 0, NULL, 0, '2021-02-02 20:13:49', '2022-07-20 16:44:01');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (83, 64, '地图组件', '/extension/map', '/extension/map', 0, 19, NULL, 'el-icon-map-location', 0, NULL, 0, '2021-02-02 20:11:49', '2022-07-20 16:44:03');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (84, 64, '二维码', '/extension/qr-code', '/extension/qr-code', 0, 20, NULL, 'el-icon-_qrcode', 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:44:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (85, 64, '条形码', '/extension/bar-code', '/extension/bar-code', 0, 21, NULL, 'el-icon-_barcode', 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:49:58');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (86, 64, '富文本框', '/extension/editor', '/extension/editor', 0, 22, NULL, 'el-icon-_font-family', 0, NULL, 0, '2021-02-02 20:13:57', '2022-07-20 16:44:07');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (87, 64, 'markdown', '/extension/markdown', '/extension/markdown', 0, 23, NULL, 'el-icon-_feedback', 0, NULL, 0, '2022-03-11 21:58:13', '2022-07-20 16:44:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (90, 0, '常用实例', '/example', NULL, 0, 8, NULL, 'el-icon-_integral', 0, NULL, 0, '2021-02-02 20:15:01', '2021-11-05 16:52:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (91, 90, '表格实例', '/example/table', '/example/table', 0, 1, NULL, 'el-icon-_table', 0, NULL, 0, '2021-10-06 22:26:55', '2022-03-11 21:53:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (92, 90, '菜单徽章', '/example/menu-badge', '/example/menu-badge', 0, 2, NULL, 'el-icon-_menu', 0, NULL, 1, '2022-03-11 21:57:35', '2022-03-11 21:57:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (93, 90, '内嵌页面', '/example/eleadmin', 'https://www.eleadmin.com', 0, 3, NULL, 'el-icon-connection', 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:55');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (94, 90, '内嵌文档', '/example/eleadmin-doc', 'https://eleadmin.com/doc/eleadmin/', 0, 4, NULL, 'el-icon-connection', 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:56');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (95, 90, '批量选择', '/example/choose', '/example/choose', 0, 5, NULL, 'el-icon-finished', 0, NULL, 0, '2021-02-02 20:15:11', '2022-07-20 16:45:57');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (96, 90, '案卷调整', '/example/document', '/example/document', 0, 6, NULL, 'el-icon-files', 0, NULL, 0, '2021-02-02 20:15:03', '2022-07-20 16:45:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (97, 90, '预留1', NULL, NULL, 0, 7, NULL, NULL, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (98, 90, '预留2', NULL, NULL, 0, 8, NULL, NULL, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:46');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (99, 0, '套餐管理', '/subscribe', '', 0, 30, NULL, 'Ticket', 0, NULL, 0, '2021-02-02 20:15:18', '2024-11-19 23:17:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (100, 99, '套餐管理', '/subscribe/membership', '/subscribe/membership', 0, 1, NULL, 'Ticket', 0, NULL, 0, '2021-02-02 20:15:18', '2024-11-21 15:01:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (101, 0, '订单管理', '/order', '', 0, 40, '', 'Handbag', 0, NULL, 0, '2021-02-02 20:15:18', '2024-10-14 00:34:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (120, 163, '插件管理', '/templateplugin/plugin', '/templateplugin/plugin', 0, 2, NULL, 'AppstoreAddOutlined', 0, NULL, 0, '2024-10-11 21:21:17', '2024-11-22 16:31:37');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (130, 0, '数据管理', '/data', NULL, 0, 20, NULL, 'Coin', 0, NULL, 0, '2024-10-11 21:24:12', '2024-10-14 00:26:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (140, 163, '模板管理', '/templateplugin/template', '/templateplugin/template', 0, 1, NULL, 'DataAnalysis', 0, NULL, 0, '2024-10-11 21:32:11', '2024-11-22 16:31:24');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (150, 0, '用户管理', '/customer', NULL, 0, 10, NULL, 'User', 0, NULL, 0, '2024-10-11 21:34:48', '2024-11-20 01:26:33');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (151, 130, '数据备份', '/data/databackup', '', 0, 3, '', 'MostlyCloudy', 0, '', 0, '2024-10-13 22:50:27', '2024-11-01 10:15:43');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (152, 0, '笔记公开', '/release', '', 0, 50, '', 'Upload', 0, '', 0, '2024-10-13 23:05:22', '2024-10-14 00:57:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (153, 130, '笔记数据管理', '/data/notesdata', '', 0, 1, '', 'MessageBox', 0, '', 0, '2024-10-13 23:08:46', '2024-11-01 10:15:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (154, 0, '隐私政策', '/term', '', 0, 300, '', 'Warning', 0, '', 0, '2024-10-14 00:12:17', '2024-10-14 00:39:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (155, 154, '隐私政策', '/term/privacypolicy', '', 0, 1, '', 'ToiletPaper', 0, '', 0, '2024-10-14 00:13:26', '2024-11-01 10:17:07');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (156, 154, '条件与条款', '/term/conditionclause', '', 0, 2, '', 'Tickets', 0, '', 0, '2024-10-14 00:14:08', '2024-11-01 10:17:12');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (157, 0, '报告与反馈', '/feedback', '', 0, 60, '', 'WarnTriangleFilled', 0, '', 0, '2024-10-14 00:14:56', '2024-10-14 01:05:46');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (158, 157, '客服中心', '/feedback/customer', '', 0, 1, '', 'Service', 0, '', 0, '2024-10-14 00:16:43', '2024-11-01 10:16:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (159, 152, '敏感词检测警告', '/feedback/sensitive', '', 0, 2, '', 'QuestionFilled', 0, '', 0, '2024-10-14 00:17:33', '2024-11-01 10:16:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (160, 152, '敏感词库管理', '/feedback/sensitivelibrary', '', 0, 3, '', 'DocumentRemove', 0, '', 0, '2024-10-14 00:24:12', '2024-11-01 10:16:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (161, 130, '文件存储管理', '/data/file', '', 0, 2, '', 'MessageBox', 0, '', 0, '2024-10-14 00:30:22', '2024-11-01 10:15:37');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (162, 99, '增值服务条款管理', '/subscribe/term', '', 0, 2, '', 'Warning', 0, '', 0, '2024-10-14 00:48:10', '2024-11-19 23:20:57');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (163, 0, '模板管理', '/templateplugin', '', 0, 50, '', 'Orange', 0, '', 0, '2024-10-14 00:52:18', '2024-12-05 18:51:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (164, 152, '笔记发布管理', '/release/notespublicly', '', 0, 1, '', 'Compass', 0, '', 0, '2024-10-14 00:57:59', '2024-11-01 10:16:31');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (165, 157, '意见反馈中心', '/feedback/opinion', '', 0, 2, '', 'InfoFilled', 0, '', 0, '2024-10-14 01:07:58', '2024-11-01 10:16:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (166, 101, '订单管理', '/order/orderlist', '/order/orderlist', 0, 1, '', 'GoodsFilled', 0, '', 0, '2024-10-14 01:18:37', '2024-12-05 17:46:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (167, 101, '订单统计', '/order/statistics', '/dashboard/analysis', 0, 2, '', 'PieChart', 0, '', 0, '2024-10-14 01:19:47', '2024-11-23 18:12:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (168, 150, '用户管理', '/customer/user', '/customer/user', 0, 1, '', 'Avatar', 0, '', 0, '2024-11-01 10:13:21', '2024-11-20 01:26:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `title`, `path`, `component`, `menu_type`, `sort_number`, `authority`, `icon`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (169, 150, '用户统计分析', '/customer/analysis', '/dashboard/monitor', 0, 2, '', 'Aim', 0, '', 0, '2024-11-01 10:19:51', '2024-11-23 18:11:27');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色标识',
  `comments` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_code`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (1, '最高管理员', 'admin', '最高管理员', 0, '2024-11-09 23:44:17', '2024-11-23 17:31:07');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_code`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (2, '高级管理员', 'senior', '高级管理员', 0, '2024-11-09 23:45:32', '2024-11-23 17:31:10');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_code`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (3, '普通管理员', 'user', '普通管理员', 0, '2024-11-09 23:45:32', '2024-11-23 17:30:18');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_menu_id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int NOT NULL COMMENT '角色id',
  `menu_id` int NOT NULL COMMENT '菜单id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_menu_id`) USING BTREE,
  KEY `sys_role_menu_role_id` (`role_id`) USING BTREE,
  KEY `sys_role_menu_menu_id` (`menu_id`) USING BTREE,
  CONSTRAINT `sys_role_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`menu_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sys_role_menu_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1606 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色权限';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (315, 3, 40, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (316, 3, 41, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (317, 3, 42, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (318, 3, 43, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1430, 2, 36, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1431, 2, 37, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1432, 2, 38, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1433, 2, 39, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1434, 2, 40, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1435, 2, 41, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1436, 2, 42, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1437, 2, 43, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1438, 2, 44, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1439, 2, 45, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1440, 2, 51, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1441, 2, 52, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1442, 2, 53, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1443, 2, 46, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1444, 2, 47, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1445, 2, 48, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1446, 2, 49, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1447, 2, 50, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1448, 2, 54, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1449, 2, 55, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1450, 2, 56, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1451, 2, 57, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1452, 2, 58, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1453, 2, 59, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1454, 2, 60, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1455, 2, 64, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1456, 2, 65, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1457, 2, 66, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1458, 2, 67, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1459, 2, 68, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1460, 2, 69, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1461, 2, 70, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1462, 2, 71, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1463, 2, 72, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1464, 2, 73, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1465, 2, 74, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1466, 2, 75, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1467, 2, 76, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1468, 2, 77, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1469, 2, 78, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1470, 2, 79, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1471, 2, 80, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1472, 2, 82, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1473, 2, 83, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1474, 2, 84, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1475, 2, 85, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1476, 2, 86, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1477, 2, 87, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1480, 2, 90, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1481, 2, 91, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1482, 2, 93, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1483, 2, 94, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1484, 2, 95, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1485, 2, 96, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1486, 2, 1, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1487, 2, 2, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1488, 2, 3, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1489, 2, 4, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1490, 2, 5, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1491, 2, 6, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1492, 2, 33, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1493, 2, 7, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1494, 2, 8, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1495, 2, 9, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1496, 2, 10, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1497, 2, 11, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1498, 2, 12, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1499, 2, 13, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1500, 2, 14, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1501, 2, 15, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1502, 2, 16, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1513, 2, 29, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1514, 2, 30, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1515, 2, 31, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1516, 2, 32, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1517, 2, 27, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1518, 2, 28, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1519, 2, 34, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1520, 2, 35, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1521, 2, 61, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1522, 2, 62, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1524, 1, 36, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1525, 1, 37, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1526, 1, 38, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1527, 1, 39, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1528, 1, 150, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1529, 1, 168, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1530, 1, 169, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1531, 1, 130, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1532, 1, 153, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1533, 1, 161, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1534, 1, 151, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1535, 1, 99, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1536, 1, 100, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1537, 2, 162, '2024-11-01 10:51:28', '2024-12-05 18:53:34');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1538, 1, 101, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1539, 1, 166, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1540, 1, 167, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1541, 1, 163, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1542, 1, 140, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1543, 2, 120, '2024-11-01 10:51:28', '2024-12-05 18:52:05');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1544, 2, 152, '2024-11-01 10:51:28', '2024-12-05 18:50:15');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1545, 2, 164, '2024-11-01 10:51:28', '2024-12-05 18:49:01');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1546, 2, 159, '2024-11-01 10:51:28', '2024-12-05 18:49:41');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1547, 2, 160, '2024-11-01 10:51:28', '2024-12-05 18:48:24');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1548, 2, 157, '2024-11-01 10:51:28', '2024-11-19 23:09:51');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1549, 2, 158, '2024-11-01 10:51:28', '2024-11-19 23:09:25');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1550, 2, 165, '2024-11-01 10:51:28', '2024-11-19 23:09:11');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1551, 2, 154, '2024-11-01 10:51:28', '2024-11-19 23:12:36');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1552, 2, 155, '2024-11-01 10:51:28', '2024-11-19 23:11:22');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1553, 2, 156, '2024-11-01 10:51:28', '2024-11-19 23:11:25');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1554, 1, 1, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1555, 1, 2, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1556, 1, 3, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1557, 1, 4, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1558, 1, 5, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1559, 1, 6, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1560, 1, 33, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1561, 1, 7, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1562, 1, 8, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1563, 1, 9, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1564, 1, 10, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1565, 1, 11, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1566, 1, 12, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1567, 1, 13, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1568, 1, 14, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1569, 1, 15, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1570, 1, 16, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1581, 1, 29, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1582, 1, 30, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1583, 1, 31, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1584, 1, 32, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1585, 1, 27, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1586, 1, 28, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1587, 1, 34, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1588, 1, 35, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1589, 1, 61, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1590, 1, 62, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1604, 1, 51, '2024-11-15 00:40:40', '2024-11-15 00:40:40');
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1605, 1, 52, '2024-11-15 00:42:47', '2024-11-15 00:42:47');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int DEFAULT NULL COMMENT '角色id',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `email_verified` int NOT NULL DEFAULT '0' COMMENT '邮箱是否验证, 0否, 1是',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `sex` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '男' COMMENT '性别',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `introduction` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '个人简介',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态, 0正常, 1冻结',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='管理员用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `email_verified`, `password`, `nickname`, `phone`, `sex`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (123, 1, '2405824084@qq.com', 0, '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Yoko', '17877059806', '男', 'SystemDefaultFiles/images/avatar/avatar-admin1.png', '最高权限', 0, 0, '2024-11-09 23:16:54', '2024-12-05 19:03:42');
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `email_verified`, `password`, `nickname`, `phone`, `sex`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (456, 2, 'zhang@qq.com', 0, '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Izcw', '18269328567', '女', 'SystemDefaultFiles/images/avatar/avatar-admin2.png', '高级权限', 0, 0, '2024-11-09 23:57:30', '2024-12-05 19:03:47');
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `email_verified`, `password`, `nickname`, `phone`, `sex`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (789, 3, 'zhang2@qq.com', 0, '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'nike', '13472583897', '男', 'SystemDefaultFiles/images/avatar/avatar-admin3.png', '普通管理权限', 0, 0, '2024-11-09 23:57:30', '2024-12-05 19:03:14');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
