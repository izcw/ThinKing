/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3306
 Source Schema         : nexnote

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 19/11/2024 02:18:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for note_page
-- ----------------------------
DROP TABLE IF EXISTS `note_page`;
CREATE TABLE `note_page`  (
  `page_id` int NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `page_space_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '空间id',
  `user_id` int NOT NULL COMMENT '用户id',
  `parent_id` int NULL DEFAULT NULL COMMENT '上级id，0是顶级',
  `sort_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '排序号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'space' COMMENT '页面标题',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面图标',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '笔记内容',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面封面',
  `collect` int NULL DEFAULT NULL COMMENT '收藏：0否，1收藏',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除, 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`page_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '页面' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_page
-- ----------------------------

-- ----------------------------
-- Table structure for note_page_history
-- ----------------------------
DROP TABLE IF EXISTS `note_page_history`;
CREATE TABLE `note_page_history`  (
  `page_history_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `page_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '页面id',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '历史版本',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'space' COMMENT '页面标题',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面图标',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '笔记内容',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面封面',
  `time_limit` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '期限，默认7天',
  `is_current_version` int NULL DEFAULT 0 COMMENT '当前使用版本：0历史版本，1当前使用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`page_history_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '笔记编辑历史版本' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_page_history
-- ----------------------------

-- ----------------------------
-- Table structure for note_page_setting
-- ----------------------------
DROP TABLE IF EXISTS `note_page_setting`;
CREATE TABLE `note_page_setting`  (
  `page_setting_id` int NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `page_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '空间id',
  `font` enum('默认','衬线体','等宽体') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '默认' COMMENT '字体',
  `size` enum('12','14','16','18','20') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '14' COMMENT '字体大小',
  `layout` enum('large','default','mobile') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'default' COMMENT '页面布局',
  `read` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '只读：0可以编辑，1只读',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码：NULL不加密',
  `titlenumber` int NULL DEFAULT NULL COMMENT '标题自动编号, 0默认不编号, 1自动编号',
  `bottominfo` int NULL DEFAULT NULL COMMENT '底部信息，0默认开启，1关闭',
  `template` int NULL DEFAULT NULL COMMENT '模板：0普通页面，1~n 模板',
  `background` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面背景',
  PRIMARY KEY (`page_setting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '页面设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_page_setting
-- ----------------------------

-- ----------------------------
-- Table structure for note_setting
-- ----------------------------
DROP TABLE IF EXISTS `note_setting`;
CREATE TABLE `note_setting`  (
  `setting_id` int NOT NULL AUTO_INCREMENT COMMENT '笔记全局设置id',
  `user_id` int NOT NULL COMMENT '用户id',
  `sidebar` int NULL DEFAULT 300 COMMENT '侧边栏：0收起，n宽度',
  `tools_sidebar` int NULL DEFAULT 300 COMMENT '工具侧边栏：0收起，n宽度',
  `language` enum('简体中文','English') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '简体中文' COMMENT '语言',
  `theme` int NULL DEFAULT 0 COMMENT '主题：0白，1黑',
  `start_page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '启动时展示页面：0默认主页，n上次操作的页面',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`setting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '笔记全局设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_setting
-- ----------------------------

-- ----------------------------
-- Table structure for note_space
-- ----------------------------
DROP TABLE IF EXISTS `note_space`;
CREATE TABLE `note_space`  (
  `space_id` int NOT NULL AUTO_INCREMENT COMMENT '空间id',
  `user_id` int NOT NULL COMMENT '用户id',
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路由名称',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'space' COMMENT '空间名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '空间图标',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '空间配色',
  `default` int NOT NULL DEFAULT 0 COMMENT '默认空间, 0默认, 1其它',
  `sort_number` int NOT NULL DEFAULT 1 COMMENT '排序号',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除, 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`space_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '笔记空间' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_space
-- ----------------------------

-- ----------------------------
-- Table structure for note_space_collect
-- ----------------------------
DROP TABLE IF EXISTS `note_space_collect`;
CREATE TABLE `note_space_collect`  (
  `space_collect_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `page_space_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '空间id',
  `sort_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`space_collect_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '空间页面收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_space_collect
-- ----------------------------

-- ----------------------------
-- Table structure for note_template
-- ----------------------------
DROP TABLE IF EXISTS `note_template`;
CREATE TABLE `note_template`  (
  `template_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'space' COMMENT '模板名称',
  PRIMARY KEY (`template_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '模板中心' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_template
-- ----------------------------

-- ----------------------------
-- Table structure for note_user
-- ----------------------------
DROP TABLE IF EXISTS `note_user`;
CREATE TABLE `note_user`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱/账号',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Nex笔记' COMMENT '昵称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/images/avatar-default.png' COMMENT '头像',
  `subscribe` int NOT NULL DEFAULT 0 COMMENT '订阅套餐',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态, 0正常, 1冻结',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of note_user
-- ----------------------------
INSERT INTO `note_user` VALUES (11, 'zhangchengwei.work@outlook.com', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Nex笔记1', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-08 16:19:18', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (12, '2405824084@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记2', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (13, 'zhang1@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记3', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (14, 'zhang2@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记4', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (15, 'zhang3@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记5', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 1, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (16, 'zhang4@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记6', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (17, 'zhang5@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记7', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 1, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (18, 'zhang6@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记8', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (19, 'zhang7@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记9', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (20, 'zhang8@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (21, 'zhang9@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (22, 'zhang10@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (23, 'zhang11@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 1, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (24, 'zhang12@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$yls0M2L2vH5YJOdcs+eOEg$Tk595pC49HBHvA5NpAPA75hSgdutH1VoZO0zUa/M3eY', 'Nex笔记', '/file_warehouse/images/avatar/default/avatar-default.png', 0, 0, '2024-11-09 19:43:57', '2024-11-19 01:46:28');
INSERT INTO `note_user` VALUES (25, 'zhang88@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$lvL6h6xxkiOod02YwiKDnw$FErkyV8whjdGkXKd32pcnCMCWnr3sv35gG9aKgc5SHo', 'HaHa', '/user.png', 0, 0, '2024-11-18 22:47:16', '2024-11-18 22:47:16');
INSERT INTO `note_user` VALUES (26, 'IzcwYoko@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$RrmveCwqxZ/d1ut1INcU2w$ohJaUD6t/WlP8o3FIbK3A5fKYyjDSpTggA/VyqPtd58', 'Lan', '', 0, 0, '2024-11-19 02:00:56', '2024-11-19 02:00:56');
INSERT INTO `note_user` VALUES (27, 'BaoZi@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$/YPt4qPE48oNnW6GelBx/w$5HHIS7OuEc0QAKwLOIvCTTAGSp7/4G35h8eoz/f2Qis', 'end', 'http://127.0.0.1:8071/api/file_warehouse/images/avatar/users/b844a30a-52ce-45c8-aa85-5233b8d9de08.png', 0, 0, '2024-11-19 02:03:54', '2024-11-19 02:03:54');
INSERT INTO `note_user` VALUES (28, 'WanCai@gmail.com', '$argon2i$v=19$m=65536,t=2,p=1$Z2xBh7FnJQBZyzhs+5CyZQ$orVBcwwXiHfwiB67Gi+ULepVrr94VX8umhn6y9wz7Ug', '晚上', 'http://localhost:8071/api/file_warehouse/images/avatar/users/e4020ad7-eafb-4bc9-89ab-1e42518d37a6.png', 0, 0, '2024-11-19 02:07:59', '2024-11-19 02:07:59');
INSERT INTO `note_user` VALUES (29, '996@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$RsatkrJQK5qPkp8AQhB9eg$ln5M5dT4WGevkw0bECz5g4Um/cgUznOTwG/TYh95XBY', '8848钛金手机', 'http://localhost:8071/api/file_warehouse/images/avatar/users/39f7e473-c96a-4651-b1b7-35d930a36282.png', 0, 0, '2024-11-19 02:09:26', '2024-11-19 02:09:26');
INSERT INTO `note_user` VALUES (30, 'DaLei@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$cubI+tDmepGo/v9C6yWBMg$8NfWTkR08EgGpkC8fFT32YWgUmN2YzHYP5rb7G68lCo', '打雷', '/file_warehouse/images/avatar/users/0aa236df-16cc-4c37-a936-241df3c6b80d.png', 0, 0, '2024-11-19 02:12:51', '2024-11-19 02:12:51');
INSERT INTO `note_user` VALUES (31, '12333@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$dMvHXeZp480TjIaKkN5Xow$mUcU4MVFEF39Y9+8QodXcv7V7r6R+p8V6mVTx6L/hgU', '321', '/file_warehouse/images/avatar/users/b116a3b6-d060-4e3c-8149-08ea84bd171f.png', 0, 0, '2024-11-19 02:13:43', '2024-11-19 02:13:43');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int NOT NULL DEFAULT 0 COMMENT '上级id, 0是顶级',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单路由地址',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单组件地址, 目录可为空',
  `menu_type` int NULL DEFAULT 0 COMMENT '类型, 0菜单, 1按钮',
  `sort_number` int NOT NULL DEFAULT 1 COMMENT '排序号',
  `authority` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `hide` int NOT NULL DEFAULT 0 COMMENT '是否隐藏, 0否, 1是(仅注册路由不显示在左侧菜单)',
  `meta` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它路由元信息',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 170 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', '/system', NULL, 0, 500, NULL, 'Setting', 0, '{\"badge\": \"New\", \"badgeColor\": \"warning\"}', 0, '2020-02-26 12:51:23', '2024-10-14 00:19:14');
INSERT INTO `sys_menu` VALUES (2, 1, '系统用户管理', '/system/user', '/system/user', 0, 2, NULL, 'el-icon-_user-group', 0, NULL, 0, '2020-02-26 12:51:55', '2024-11-14 20:42:30');
INSERT INTO `sys_menu` VALUES (3, 2, '查询用户', NULL, NULL, 1, 1, 'sys:user:list', NULL, 0, NULL, 0, '2020-02-26 12:52:06', '2020-09-16 11:05:35');
INSERT INTO `sys_menu` VALUES (4, 2, '添加用户', NULL, NULL, 1, 2, 'sys:user:save', NULL, 0, NULL, 0, '2020-02-26 12:52:26', '2020-03-21 18:45:29');
INSERT INTO `sys_menu` VALUES (5, 2, '修改用户', NULL, NULL, 1, 3, 'sys:user:update', NULL, 0, NULL, 0, '2020-02-26 12:52:50', '2020-03-21 18:45:30');
INSERT INTO `sys_menu` VALUES (6, 2, '删除用户', NULL, NULL, 1, 4, 'sys:user:remove', NULL, 0, NULL, 0, '2020-02-26 12:53:13', '2020-03-21 18:45:32');
INSERT INTO `sys_menu` VALUES (7, 1, '系统角色管理', '/system/role', '/system/role', 0, 3, NULL, 'el-icon-postcard', 0, NULL, 0, '2020-03-13 13:29:08', '2024-11-14 20:42:34');
INSERT INTO `sys_menu` VALUES (8, 7, '查询角色', NULL, NULL, 1, 1, 'sys:role:list', NULL, 0, NULL, 0, '2020-03-13 13:30:41', '2020-03-21 18:45:34');
INSERT INTO `sys_menu` VALUES (9, 7, '添加角色', NULL, NULL, 1, 2, 'sys:role:save', NULL, 0, NULL, 0, '2020-03-15 13:02:07', '2020-03-21 18:45:35');
INSERT INTO `sys_menu` VALUES (10, 7, '修改角色', NULL, NULL, 1, 3, 'sys:role:update', NULL, 0, NULL, 0, '2020-03-15 13:02:49', '2020-03-21 18:45:36');
INSERT INTO `sys_menu` VALUES (11, 7, '删除角色', NULL, NULL, 1, 4, 'sys:role:remove', NULL, 0, NULL, 0, '2020-03-20 17:58:51', '2020-03-21 18:45:38');
INSERT INTO `sys_menu` VALUES (12, 1, '系统菜单管理', '/system/menu', '/system/menu', 0, 4, NULL, 'el-icon-s-operation', 0, NULL, 0, '2020-03-21 01:07:13', '2024-11-14 20:42:39');
INSERT INTO `sys_menu` VALUES (13, 12, '查询菜单', NULL, NULL, 1, 1, 'sys:menu:list', NULL, 0, NULL, 0, '2020-03-21 16:43:30', '2020-03-21 18:45:40');
INSERT INTO `sys_menu` VALUES (14, 12, '添加菜单', NULL, NULL, 1, 2, 'sys:menu:save', NULL, 0, NULL, 0, '2020-03-21 16:43:54', '2020-03-21 18:45:41');
INSERT INTO `sys_menu` VALUES (15, 12, '修改菜单', NULL, NULL, 1, 3, 'sys:menu:update', NULL, 0, NULL, 0, '2020-03-21 18:24:17', '2020-03-21 18:45:43');
INSERT INTO `sys_menu` VALUES (16, 12, '删除菜单', NULL, NULL, 1, 4, 'sys:menu:remove', NULL, 0, NULL, 0, '2020-03-21 18:24:18', '2020-03-21 18:45:44');
INSERT INTO `sys_menu` VALUES (27, 1, '系统登录日志', '/system/login-record', '/system/login-record', 0, 5, 'sys:login-record:list', 'el-icon-date', 0, NULL, 0, '2020-03-21 18:24:33', '2024-11-14 20:42:42');
INSERT INTO `sys_menu` VALUES (28, 1, '系统操作日志', '/system/operation-record', '/system/operation-record', 0, 6, 'sys:operation-record:list', 'el-icon-_retrieve', 0, NULL, 0, '2020-03-21 18:24:34', '2024-11-14 20:42:44');
INSERT INTO `sys_menu` VALUES (29, 1, '文件管理', '/system/file', '/system/file', 0, 6, NULL, 'el-icon-folder', 1, NULL, 0, '2020-09-17 23:19:43', '2022-03-11 22:13:53');
INSERT INTO `sys_menu` VALUES (30, 29, '上传文件', NULL, NULL, 1, 1, 'sys:file:upload', NULL, 0, NULL, 0, '2020-09-17 23:21:04', '2022-07-20 16:40:21');
INSERT INTO `sys_menu` VALUES (31, 29, '删除文件', NULL, NULL, 1, 2, 'sys:file:remove', NULL, 0, NULL, 0, '2020-09-17 23:21:53', '2022-07-20 16:40:23');
INSERT INTO `sys_menu` VALUES (32, 29, '查看记录', NULL, NULL, 1, 3, 'sys:file:list', NULL, 0, NULL, 0, '2020-09-17 23:20:29', '2022-07-20 16:40:24');
INSERT INTO `sys_menu` VALUES (33, 2, '用户详情', '/system/user/details', '/system/user/details', 0, 5, NULL, 'el-icon-user', 1, '{\"active\": \"/system/user\"}', 0, '2021-05-21 11:07:54', '2022-07-20 16:39:29');
INSERT INTO `sys_menu` VALUES (34, 1, '修改个人密码', NULL, NULL, 1, 9, 'sys:auth:password', NULL, 0, NULL, 0, '2020-09-17 23:22:45', '2022-07-20 16:40:53');
INSERT INTO `sys_menu` VALUES (35, 1, '修改个人资料', NULL, NULL, 1, 10, 'sys:auth:user', NULL, 0, NULL, 0, '2020-09-17 23:23:24', '2022-07-20 16:40:55');
INSERT INTO `sys_menu` VALUES (36, 0, '仪表板', '/dashboard', NULL, 0, 0, NULL, 'House', 0, NULL, 0, '2021-02-02 20:00:34', '2024-10-11 21:38:02');
INSERT INTO `sys_menu` VALUES (37, 36, '工作台', '/dashboard/workplace', '/dashboard/workplace', 0, 1, NULL, 'el-icon-monitor', 0, NULL, 0, '2021-02-02 20:00:37', '2021-11-05 16:36:59');
INSERT INTO `sys_menu` VALUES (38, 36, '分析页', '/dashboard/analysis', '/dashboard/analysis', 0, 2, NULL, 'el-icon-data-analysis', 0, '{\"badge\": 1}', 0, '2021-02-02 20:00:40', '2022-03-11 16:45:44');
INSERT INTO `sys_menu` VALUES (39, 36, '监控页', '/dashboard/monitor', '/dashboard/monitor', 0, 3, NULL, 'el-icon-odometer', 0, NULL, 0, '2021-02-02 20:03:12', '2021-11-05 16:36:56');
INSERT INTO `sys_menu` VALUES (40, 0, '表单页面0001', '/form', NULL, 0, 2, NULL, 'el-icon-tickets', 0, NULL, 0, '2021-02-02 20:03:28', '2024-10-11 13:08:35');
INSERT INTO `sys_menu` VALUES (41, 40, '基础表单', '/form/basic', '/form/basic', 0, 1, NULL, 'el-icon-_feedback', 0, NULL, 0, '2021-02-02 20:03:51', '2021-11-05 16:36:53');
INSERT INTO `sys_menu` VALUES (42, 40, '复杂表单', '/form/advanced', '/form/advanced', 0, 2, NULL, 'el-icon-_visa', 0, NULL, 0, '2021-02-02 20:03:56', '2021-11-05 16:36:52');
INSERT INTO `sys_menu` VALUES (43, 40, '分步表单', '/form/step', '/form/step', 0, 3, NULL, 'el-icon-c-scale-to-original', 0, NULL, 0, '2021-02-02 20:04:06', '2021-11-05 16:36:50');
INSERT INTO `sys_menu` VALUES (44, 0, '列表页面', '/list', NULL, 0, 3, NULL, 'el-icon-_table', 0, NULL, 0, '2021-02-02 20:05:07', '2021-11-05 16:36:49');
INSERT INTO `sys_menu` VALUES (45, 44, '基础列表', '/list/basic', '/list/basic', 0, 1, NULL, 'el-icon-document', 0, NULL, 0, '2021-02-02 20:05:10', '2021-11-05 16:36:48');
INSERT INTO `sys_menu` VALUES (46, 44, '复杂列表', '/list/advanced', '/list/advanced', 0, 2, NULL, 'el-icon-_cols', 0, NULL, 0, '2021-02-02 20:05:26', '2021-11-05 16:36:47');
INSERT INTO `sys_menu` VALUES (47, 44, '卡片列表', '/list/card', '/list/card', 0, 3, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:05:30', '2021-11-05 16:36:45');
INSERT INTO `sys_menu` VALUES (48, 47, '项目列表', '/list/card/project', '/list/card/project', 0, 1, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:35', '2021-11-05 16:36:44');
INSERT INTO `sys_menu` VALUES (49, 47, '应用列表', '/list/card/application', '/list/card/application', 0, 2, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:39', '2021-11-05 16:36:42');
INSERT INTO `sys_menu` VALUES (50, 47, '文章列表', '/list/card/article', '/list/card/article', 0, 3, NULL, 'el-icon-_menu', 0, NULL, 0, '2021-02-02 20:06:48', '2021-11-05 16:36:41');
INSERT INTO `sys_menu` VALUES (51, 45, '添加用户', '/list/basic/add', '/list/basic/add', 0, 1, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:25');
INSERT INTO `sys_menu` VALUES (52, 45, '修改用户', '/list/basic/edit', '/list/basic/edit', 0, 2, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:26');
INSERT INTO `sys_menu` VALUES (53, 45, '用户详情', '/list/basic/details/:id', '/list/basic/details', 0, 3, NULL, 'el-icon-user', 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:27');
INSERT INTO `sys_menu` VALUES (54, 0, '结果页面', '/result', NULL, 0, 4, NULL, 'el-icon-circle-check', 0, NULL, 0, '2021-02-02 20:07:33', '2021-11-05 16:36:40');
INSERT INTO `sys_menu` VALUES (55, 54, '成功页', '/result/success', '/result/success', 0, 1, NULL, 'el-icon-circle-check', 0, NULL, 0, '2021-02-02 20:07:40', '2021-11-05 16:36:38');
INSERT INTO `sys_menu` VALUES (56, 54, '失败页', '/result/fail', '/result/fail', 0, 2, NULL, 'el-icon-circle-close', 0, NULL, 0, '2021-02-02 20:07:41', '2021-11-05 16:36:37');
INSERT INTO `sys_menu` VALUES (57, 0, '异常页面', '/exception', NULL, 0, 5, NULL, 'el-icon-document-delete', 0, NULL, 0, '2021-02-02 20:08:44', '2021-11-05 16:36:36');
INSERT INTO `sys_menu` VALUES (58, 57, '403', '/exception/403', '/exception/403', 0, 1, NULL, 'el-icon-document-checked', 0, NULL, 0, '2021-02-02 20:08:47', '2021-11-05 16:36:35');
INSERT INTO `sys_menu` VALUES (59, 57, '404', '/exception/404', '/exception/404', 0, 2, NULL, 'el-icon-document-remove', 0, NULL, 0, '2021-02-02 20:08:49', '2021-11-05 16:36:34');
INSERT INTO `sys_menu` VALUES (60, 57, '500', '/exception/500', '/exception/500', 0, 3, NULL, 'el-icon-document-delete', 0, NULL, 0, '2021-02-02 20:08:52', '2021-11-05 16:36:33');
INSERT INTO `sys_menu` VALUES (61, 1, '个人中心', '/user', NULL, 0, 1, NULL, 'Tickets', 0, NULL, 0, '2021-02-02 20:09:54', '2024-11-14 20:42:13');
INSERT INTO `sys_menu` VALUES (62, 61, '我的资料', '/user/profile', '/user/profile', 0, 1, NULL, 'el-icon-user', 0, NULL, 0, '2021-02-02 20:09:58', '2021-11-05 16:36:30');
INSERT INTO `sys_menu` VALUES (64, 0, '扩展组件', '/extension', NULL, 0, 7, NULL, 'el-icon-open', 0, NULL, 0, '2021-02-02 20:10:52', '2021-11-05 16:36:26');
INSERT INTO `sys_menu` VALUES (65, 64, '图标扩展', '/extension/icon', '/extension/icon', 0, 1, NULL, 'el-icon-_heart', 0, NULL, 0, '2021-02-02 20:10:55', '2022-03-11 21:36:27');
INSERT INTO `sys_menu` VALUES (66, 64, '标签组件', '/extension/tag', '/extension/tag', 0, 2, NULL, 'el-icon-price-tag', 0, NULL, 0, '2021-10-05 11:13:35', '2022-03-11 21:42:50');
INSERT INTO `sys_menu` VALUES (67, 64, '弹窗扩展', '/extension/dialog', '/extension/dialog', 0, 3, NULL, 'el-icon-copy-document', 0, NULL, 0, '2021-10-05 11:32:12', '2022-03-11 21:42:52');
INSERT INTO `sys_menu` VALUES (68, 64, '文件列表', '/extension/file', '/extension/file', 0, 4, NULL, 'el-icon-folder', 0, NULL, 0, '2021-02-02 20:10:58', '2022-03-11 21:37:16');
INSERT INTO `sys_menu` VALUES (69, 64, '图片上传', '/extension/upload', '/extension/upload', 0, 5, NULL, 'el-icon-picture-outline', 0, NULL, 0, '2021-02-02 20:10:58', '2022-07-20 16:49:27');
INSERT INTO `sys_menu` VALUES (70, 64, '拖拽排序', '/extension/dragsort', '/extension/dragsort', 0, 6, NULL, 'el-icon-rank', 0, NULL, 0, '2021-02-02 20:11:48', '2022-07-20 16:43:38');
INSERT INTO `sys_menu` VALUES (71, 64, '消息提示', '/extension/message', '/extension/message', 0, 7, NULL, 'el-icon-chat-line-square', 0, NULL, 0, '2021-10-05 11:14:28', '2022-07-20 16:43:39');
INSERT INTO `sys_menu` VALUES (72, 64, '城市选择', '/extension/regions', '/extension/regions', 0, 8, NULL, 'el-icon-office-building', 0, NULL, 0, '2021-10-05 11:25:15', '2022-07-20 16:43:40');
INSERT INTO `sys_menu` VALUES (73, 64, '打印插件', '/extension/printer', '/extension/printer', 0, 9, NULL, 'el-icon-printer', 0, NULL, 0, '2021-02-02 20:11:00', '2022-07-20 16:43:42');
INSERT INTO `sys_menu` VALUES (74, 64, 'excel插件', '/extension/excel', '/extension/excel', 0, 10, NULL, 'el-icon-_table', 0, NULL, 0, '2021-02-02 20:11:03', '2022-07-20 16:43:43');
INSERT INTO `sys_menu` VALUES (75, 64, '滚动数字', '/extension/count-up', '/extension/count-up', 0, 11, NULL, 'el-icon-more', 0, NULL, 0, '2021-10-05 11:29:03', '2022-07-20 16:43:45');
INSERT INTO `sys_menu` VALUES (76, 64, '空状态', '/extension/empty', '/extension/empty', 0, 12, NULL, 'el-icon-receiving', 0, NULL, 0, '2021-10-05 11:20:35', '2022-07-20 16:43:47');
INSERT INTO `sys_menu` VALUES (77, 64, '步骤条', '/extension/steps', '/extension/steps', 0, 13, NULL, 'el-icon-_timeline', 0, NULL, 0, '2021-10-05 11:16:39', '2022-07-20 16:43:49');
INSERT INTO `sys_menu` VALUES (78, 64, '菜单导航', '/extension/menu', '/extension/menu', 0, 14, NULL, 'el-icon-s-operation', 0, NULL, 0, '2021-10-05 11:18:35', '2022-07-20 16:43:51');
INSERT INTO `sys_menu` VALUES (79, 64, '树形下拉', '/extension/tree-select', '/extension/tree-select', 0, 15, NULL, 'el-icon-_condition', 0, NULL, 0, '2021-10-10 16:21:12', '2022-07-20 16:43:52');
INSERT INTO `sys_menu` VALUES (80, 64, '表格下拉', '/extension/table-select', '/extension/table-select', 0, 16, NULL, 'el-icon-_table', 0, NULL, 0, '2021-10-10 16:21:45', '2022-07-20 16:43:54');
INSERT INTO `sys_menu` VALUES (81, 64, '分割布局', '/extension/split-layout', '/extension/split-layout', 0, 17, NULL, NULL, 0, NULL, 1, '2021-10-10 16:21:45', '2022-07-20 16:45:04');
INSERT INTO `sys_menu` VALUES (82, 64, '视频播放', '/extension/player', '/extension/player', 0, 18, NULL, 'el-icon-_video', 0, NULL, 0, '2021-02-02 20:13:49', '2022-07-20 16:44:01');
INSERT INTO `sys_menu` VALUES (83, 64, '地图组件', '/extension/map', '/extension/map', 0, 19, NULL, 'el-icon-map-location', 0, NULL, 0, '2021-02-02 20:11:49', '2022-07-20 16:44:03');
INSERT INTO `sys_menu` VALUES (84, 64, '二维码', '/extension/qr-code', '/extension/qr-code', 0, 20, NULL, 'el-icon-_qrcode', 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:44:04');
INSERT INTO `sys_menu` VALUES (85, 64, '条形码', '/extension/bar-code', '/extension/bar-code', 0, 21, NULL, 'el-icon-_barcode', 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:49:58');
INSERT INTO `sys_menu` VALUES (86, 64, '富文本框', '/extension/editor', '/extension/editor', 0, 22, NULL, 'el-icon-_font-family', 0, NULL, 0, '2021-02-02 20:13:57', '2022-07-20 16:44:07');
INSERT INTO `sys_menu` VALUES (87, 64, 'markdown', '/extension/markdown', '/extension/markdown', 0, 23, NULL, 'el-icon-_feedback', 0, NULL, 0, '2022-03-11 21:58:13', '2022-07-20 16:44:40');
INSERT INTO `sys_menu` VALUES (90, 0, '常用实例', '/example', NULL, 0, 8, NULL, 'el-icon-_integral', 0, NULL, 0, '2021-02-02 20:15:01', '2021-11-05 16:52:47');
INSERT INTO `sys_menu` VALUES (91, 90, '表格实例', '/example/table', '/example/table', 0, 1, NULL, 'el-icon-_table', 0, NULL, 0, '2021-10-06 22:26:55', '2022-03-11 21:53:34');
INSERT INTO `sys_menu` VALUES (92, 90, '菜单徽章', '/example/menu-badge', '/example/menu-badge', 0, 2, NULL, 'el-icon-_menu', 0, NULL, 1, '2022-03-11 21:57:35', '2022-03-11 21:57:47');
INSERT INTO `sys_menu` VALUES (93, 90, '内嵌页面', '/example/eleadmin', 'https://www.eleadmin.com', 0, 3, NULL, 'el-icon-connection', 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:55');
INSERT INTO `sys_menu` VALUES (94, 90, '内嵌文档', '/example/eleadmin-doc', 'https://eleadmin.com/doc/eleadmin/', 0, 4, NULL, 'el-icon-connection', 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:56');
INSERT INTO `sys_menu` VALUES (95, 90, '批量选择', '/example/choose', '/example/choose', 0, 5, NULL, 'el-icon-finished', 0, NULL, 0, '2021-02-02 20:15:11', '2022-07-20 16:45:57');
INSERT INTO `sys_menu` VALUES (96, 90, '案卷调整', '/example/document', '/example/document', 0, 6, NULL, 'el-icon-files', 0, NULL, 0, '2021-02-02 20:15:03', '2022-07-20 16:45:59');
INSERT INTO `sys_menu` VALUES (97, 90, '预留1', NULL, NULL, 0, 7, NULL, NULL, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:45');
INSERT INTO `sys_menu` VALUES (98, 90, '预留2', NULL, NULL, 0, 8, NULL, NULL, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:46');
INSERT INTO `sys_menu` VALUES (99, 0, '套餐管理', '/vip', '', 0, 30, NULL, 'Ticket', 0, NULL, 0, '2021-02-02 20:15:18', '2024-10-14 00:27:15');
INSERT INTO `sys_menu` VALUES (100, 99, '套餐管理', '/vip/valueadded', '/vip/valueadded', 0, 1, NULL, 'Ticket', 0, NULL, 0, '2021-02-02 20:15:18', '2024-11-01 10:15:51');
INSERT INTO `sys_menu` VALUES (101, 0, '订单管理', '/order', '', 0, 40, '', 'Handbag', 0, NULL, 0, '2021-02-02 20:15:18', '2024-10-14 00:34:50');
INSERT INTO `sys_menu` VALUES (120, 163, '插件管理', '/templateplugin/plugin', NULL, 0, 2, NULL, 'AppstoreAddOutlined', 0, NULL, 0, '2024-10-11 21:21:17', '2024-11-01 10:16:24');
INSERT INTO `sys_menu` VALUES (130, 0, '数据管理', '/data', NULL, 0, 20, NULL, 'Coin', 0, NULL, 0, '2024-10-11 21:24:12', '2024-10-14 00:26:27');
INSERT INTO `sys_menu` VALUES (140, 163, '模板管理', '/templateplugin/template', NULL, 0, 1, NULL, 'DataAnalysis', 0, NULL, 0, '2024-10-11 21:32:11', '2024-11-01 10:16:19');
INSERT INTO `sys_menu` VALUES (150, 0, '客户管理', '/customer', NULL, 0, 10, NULL, 'User', 0, NULL, 0, '2024-10-11 21:34:48', '2024-11-01 10:58:04');
INSERT INTO `sys_menu` VALUES (151, 130, '数据备份', '/data/databackup', '', 0, 3, '', 'MostlyCloudy', 0, '', 0, '2024-10-13 22:50:27', '2024-11-01 10:15:43');
INSERT INTO `sys_menu` VALUES (152, 0, '笔记公开', '/release', '', 0, 50, '', 'Upload', 0, '', 0, '2024-10-13 23:05:22', '2024-10-14 00:57:23');
INSERT INTO `sys_menu` VALUES (153, 130, '笔记数据管理', '/data/notesdata', '', 0, 1, '', 'MessageBox', 0, '', 0, '2024-10-13 23:08:46', '2024-11-01 10:15:30');
INSERT INTO `sys_menu` VALUES (154, 0, '隐私政策', '/term', '', 0, 300, '', 'Warning', 0, '', 0, '2024-10-14 00:12:17', '2024-10-14 00:39:59');
INSERT INTO `sys_menu` VALUES (155, 154, '隐私政策', '/term/privacypolicy', '', 0, 1, '', 'ToiletPaper', 0, '', 0, '2024-10-14 00:13:26', '2024-11-01 10:17:07');
INSERT INTO `sys_menu` VALUES (156, 154, '条件与条款', '/term/conditionclause', '', 0, 2, '', 'Tickets', 0, '', 0, '2024-10-14 00:14:08', '2024-11-01 10:17:12');
INSERT INTO `sys_menu` VALUES (157, 0, '报告与反馈', '/feedback', '', 0, 60, '', 'WarnTriangleFilled', 0, '', 0, '2024-10-14 00:14:56', '2024-10-14 01:05:46');
INSERT INTO `sys_menu` VALUES (158, 157, '客服中心', '/feedback/customer', '', 0, 1, '', 'Service', 0, '', 0, '2024-10-14 00:16:43', '2024-11-01 10:16:53');
INSERT INTO `sys_menu` VALUES (159, 152, '敏感词检测警告', '/feedback/sensitive', '', 0, 2, '', 'QuestionFilled', 0, '', 0, '2024-10-14 00:17:33', '2024-11-01 10:16:36');
INSERT INTO `sys_menu` VALUES (160, 152, '敏感词库管理', '/feedback/sensitivelibrary', '', 0, 3, '', 'DocumentRemove', 0, '', 0, '2024-10-14 00:24:12', '2024-11-01 10:16:41');
INSERT INTO `sys_menu` VALUES (161, 130, '文件存储管理', '/data/file', '', 0, 2, '', 'MessageBox', 0, '', 0, '2024-10-14 00:30:22', '2024-11-01 10:15:37');
INSERT INTO `sys_menu` VALUES (162, 99, '增值服务条款管理', '/vip/term', '', 0, 2, '', 'Warning', 0, '', 0, '2024-10-14 00:48:10', '2024-11-01 10:15:57');
INSERT INTO `sys_menu` VALUES (163, 0, '模板与插件', '/templateplugin', '', 0, 40, '', 'Orange', 0, '', 0, '2024-10-14 00:52:18', '2024-10-14 00:52:18');
INSERT INTO `sys_menu` VALUES (164, 152, '笔记发布管理', '/release/notespublicly', '', 0, 1, '', 'Compass', 0, '', 0, '2024-10-14 00:57:59', '2024-11-01 10:16:31');
INSERT INTO `sys_menu` VALUES (165, 157, '意见反馈中心', '/feedback/opinion', '', 0, 2, '', 'InfoFilled', 0, '', 0, '2024-10-14 01:07:58', '2024-11-01 10:16:59');
INSERT INTO `sys_menu` VALUES (166, 101, '订单管理', '/order/orderlist', '', 0, 1, '', 'GoodsFilled', 0, '', 0, '2024-10-14 01:18:37', '2024-11-01 10:16:05');
INSERT INTO `sys_menu` VALUES (167, 101, '订单统计', '/order/statistics', '', 0, 2, '', 'PieChart', 0, '', 0, '2024-10-14 01:19:47', '2024-11-01 10:16:11');
INSERT INTO `sys_menu` VALUES (168, 150, '客户账户管理', '/customer/user', '/customer/user', 0, 1, '', 'Avatar', 0, '', 0, '2024-11-01 10:13:21', '2024-11-01 10:58:17');
INSERT INTO `sys_menu` VALUES (169, 150, '客户统计分析', '/customer/analysis', '/customer/analysis', 0, 2, '', 'Aim', 0, '', 0, '2024-11-01 10:19:51', '2024-11-01 10:58:38');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色标识',
  `comments` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', '最高管理员', 0, '2024-11-09 23:44:17', '2024-11-09 23:45:41');
INSERT INTO `sys_role` VALUES (2, '普通用户', 'user', '普通用户', 0, '2024-11-09 23:45:32', '2024-11-09 23:45:32');
INSERT INTO `sys_role` VALUES (3, '游客', 'tourist', '游客', 0, '2024-11-09 23:45:32', '2024-11-15 00:07:21');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_menu_id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int NOT NULL COMMENT '角色id',
  `menu_id` int NOT NULL COMMENT '菜单id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_menu_id`) USING BTREE,
  INDEX `sys_role_menu_role_id`(`role_id` ASC) USING BTREE,
  INDEX `sys_role_menu_menu_id`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `sys_role_menu_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`menu_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sys_role_menu_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1606 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色权限' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (315, 3, 40, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` VALUES (316, 3, 41, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` VALUES (317, 3, 42, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` VALUES (318, 3, 43, '2022-07-29 13:59:39', '2022-07-29 13:59:39');
INSERT INTO `sys_role_menu` VALUES (1430, 2, 36, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1431, 2, 37, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1432, 2, 38, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1433, 2, 39, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1434, 2, 40, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1435, 2, 41, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1436, 2, 42, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1437, 2, 43, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1438, 2, 44, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1439, 2, 45, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1440, 2, 51, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1441, 2, 52, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1442, 2, 53, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1443, 2, 46, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1444, 2, 47, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1445, 2, 48, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1446, 2, 49, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1447, 2, 50, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1448, 2, 54, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1449, 2, 55, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1450, 2, 56, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1451, 2, 57, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1452, 2, 58, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1453, 2, 59, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1454, 2, 60, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1455, 2, 64, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1456, 2, 65, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1457, 2, 66, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1458, 2, 67, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1459, 2, 68, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1460, 2, 69, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1461, 2, 70, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1462, 2, 71, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1463, 2, 72, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1464, 2, 73, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1465, 2, 74, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1466, 2, 75, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1467, 2, 76, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1468, 2, 77, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1469, 2, 78, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1470, 2, 79, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1471, 2, 80, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1472, 2, 82, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1473, 2, 83, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1474, 2, 84, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1475, 2, 85, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1476, 2, 86, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1477, 2, 87, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1480, 2, 90, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1481, 2, 91, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1482, 2, 93, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1483, 2, 94, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1484, 2, 95, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1485, 2, 96, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1486, 2, 1, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1487, 2, 2, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1488, 2, 3, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1489, 2, 4, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1490, 2, 5, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1491, 2, 6, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1492, 2, 33, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1493, 2, 7, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1494, 2, 8, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1495, 2, 9, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1496, 2, 10, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1497, 2, 11, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1498, 2, 12, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1499, 2, 13, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1500, 2, 14, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1501, 2, 15, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1502, 2, 16, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1513, 2, 29, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1514, 2, 30, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1515, 2, 31, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1516, 2, 32, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1517, 2, 27, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1518, 2, 28, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1519, 2, 34, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1520, 2, 35, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1521, 2, 61, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1522, 2, 62, '2024-10-20 15:30:18', '2024-10-20 15:30:18');
INSERT INTO `sys_role_menu` VALUES (1524, 1, 36, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1525, 1, 37, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1526, 1, 38, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1527, 1, 39, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1528, 1, 150, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1529, 1, 168, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1530, 1, 169, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1531, 1, 130, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1532, 1, 153, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1533, 1, 161, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1534, 1, 151, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1535, 1, 99, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1536, 1, 100, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1537, 1, 162, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1538, 1, 101, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1539, 1, 166, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1540, 1, 167, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1541, 1, 163, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1542, 1, 140, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1543, 1, 120, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1544, 1, 152, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1545, 1, 164, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1546, 1, 159, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1547, 1, 160, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1548, 1, 157, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1549, 1, 158, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1550, 1, 165, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1551, 1, 154, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1552, 1, 155, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1553, 1, 156, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1554, 1, 1, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1555, 1, 2, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1556, 1, 3, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1557, 1, 4, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1558, 1, 5, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1559, 1, 6, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1560, 1, 33, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1561, 1, 7, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1562, 1, 8, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1563, 1, 9, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1564, 1, 10, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1565, 1, 11, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1566, 1, 12, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1567, 1, 13, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1568, 1, 14, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1569, 1, 15, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1570, 1, 16, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1581, 1, 29, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1582, 1, 30, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1583, 1, 31, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1584, 1, 32, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1585, 1, 27, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1586, 1, 28, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1587, 1, 34, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1588, 1, 35, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1589, 1, 61, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1590, 1, 62, '2024-11-01 10:51:28', '2024-11-01 10:51:28');
INSERT INTO `sys_role_menu` VALUES (1604, 1, 51, '2024-11-15 00:40:40', '2024-11-15 00:40:40');
INSERT INTO `sys_role_menu` VALUES (1605, 1, 52, '2024-11-15 00:42:47', '2024-11-15 00:42:47');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int NULL DEFAULT NULL COMMENT '角色id',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `sex` enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '男' COMMENT '性别',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `email_verified` int NOT NULL DEFAULT 0 COMMENT '邮箱是否验证, 0否, 1是',
  `introduction` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态, 0正常, 1冻结',
  `deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除, 0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员用户' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (123, 1, 'Yoko', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Yoko', '/file_warehouse/images/avatar/default/avatar-admin1.png', '男', '17877059806', '2405824084@qq.com', 0, '这个人很懒', 0, 0, '2024-11-09 23:16:54', '2024-11-19 01:44:57');
INSERT INTO `sys_user` VALUES (456, 2, 'Izcw', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Izcw', '/file_warehouse/images/avatar/default/avatar-admin2.png', '女', '18269328567', 'zhang@qq.com', 0, '这个人很懒', 0, 0, '2024-11-09 23:57:30', '2024-11-19 01:45:01');
INSERT INTO `sys_user` VALUES (789, 3, 'Izcw', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'nike', '/file_warehouse/images/avatar/default/avatar-admin3.png', '男', '13472583897', 'zhang@qq.com', 0, '这个人很懒', 0, 0, '2024-11-09 23:57:30', '2024-11-19 01:45:04');

SET FOREIGN_KEY_CHECKS = 1;
