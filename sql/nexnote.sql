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

 Date: 21/12/2024 19:49:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for note_page
-- ----------------------------
DROP TABLE IF EXISTS `note_page`;
CREATE TABLE `note_page` (
  `page_id` bigint NOT NULL AUTO_INCREMENT COMMENT '页面id',
  `space_id` bigint NOT NULL COMMENT '空间id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `parent_id` bigint DEFAULT '0' COMMENT '父id：0是顶级',
  `sort_number` int DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面图标',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New Page' COMMENT '页面标题',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面封面',
  `content` json DEFAULT NULL COMMENT '笔记内容',
  `collect` int DEFAULT '0' COMMENT '收藏：0否，1收藏',
  `layout` enum('big','default','small','mobile') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'default' COMMENT '页面布局',
  `font` enum('default','serif','monospace') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'default' COMMENT '字体',
  `size` enum('12','14','16','18') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '16' COMMENT '字体大小',
  `readonly` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '只读：0可以编辑，1只读',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码：NULL不加密',
  `share` int DEFAULT '0' COMMENT '分享: 0默认不分享，1公开分享',
  `template` int DEFAULT '0' COMMENT '模板：0普通页面，1~n 模板',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '是否删除： 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`page_id`) USING BTREE,
  KEY `note_page_user_id` (`user_id`),
  KEY `note_page_space_id` (`space_id`),
  CONSTRAINT `note_page_space_id` FOREIGN KEY (`space_id`) REFERENCES `note_space` (`space_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `note_page_user_id` FOREIGN KEY (`user_id`) REFERENCES `note_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1870190330865934339 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='页面';

-- ----------------------------
-- Records of note_page
-- ----------------------------
BEGIN;
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865163315842560002, 1865162461555109890, 1859329812227633153, 0, NULL, '🍏', '欢迎Hello', 'SystemDefaultFiles/images/cover/1.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"heading\", \"attrs\": {\"id\": \"9402c6fa-0a6e-47b6-a2ef-f765fe480ba0\", \"level\": 1, \"data-toc-id\": \"9402c6fa-0a6e-47b6-a2ef-f765fe480ba0\"}, \"content\": [{\"text\": \"欢迎使用ThinKing🎈🦋\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"ThinKing 是一个创新的在线笔记应用，旨在帮助用户以更高效、更有组织的方式记录和管理他们的想法、笔记和任务。无论您是一名学生、专业人士还是自由职业者，ThinKing 都能为您提供一个灵活且功能强大的平台，以支持您的日常笔记需求。\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"46be5aa6-0eba-4661-a07c-2a71f7f5b3ec\", \"level\": 4, \"data-toc-id\": \"46be5aa6-0eba-4661-a07c-2a71f7f5b3ec\"}, \"content\": [{\"text\": \"高效记录，\", \"type\": \"text\"}, {\"text\": \"灵感不丢失\", \"type\": \"text\", \"marks\": [{\"type\": \"highlight\", \"attrs\": {\"color\": \"#F8BBD0\"}}]}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"在快节奏的现代生活中，灵感和想法常常在一瞬间涌现。ThinKing 提供了一个快速记录的环境，让用户能够随时随地捕捉这些宝贵的想法。无论是会议中的灵感、学习时的笔记，还是日常生活中的待办事项，ThinKing 都能确保您的每一个想法都被妥善保存。\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"1a28ad93-fb58-415e-9dae-ba2d22820491\", \"level\": 4, \"data-toc-id\": \"1a28ad93-fb58-415e-9dae-ba2d22820491\"}, \"content\": [{\"text\": \"有组织的管理，\", \"type\": \"text\"}, {\"text\": \"轻松检索\", \"type\": \"text\", \"marks\": [{\"type\": \"highlight\", \"attrs\": {\"color\": \"#BBDEFB\"}}]}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"ThinKing 的核心优势在于其强大的组织和管理功能。用户可以通过创建不同的空间来对笔记进行分类，例如工作、学习、个人等。每个空间都可以包含无限数量的笔记，而每篇笔记都可以通过标签进行进一步的细分和标记。这种灵活的组织方式使得用户能够轻松地管理和检索他们的笔记，即使是在拥有大量笔记的情况下。\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"4e20f7c8-c8e1-4800-ad34-5625b4ace296\", \"level\": 4, \"data-toc-id\": \"4e20f7c8-c8e1-4800-ad34-5625b4ace296\"}, \"content\": [{\"text\": \"多功能笔记，\", \"type\": \"text\"}, {\"text\": \"满足多样化需求\", \"type\": \"text\", \"marks\": [{\"type\": \"highlight\", \"attrs\": {\"color\": \"#FFAB91\"}}]}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"ThinKing 支持多种笔记类型，包括但不限于文本、图片、链接和代码片段。用户可以根据自己的需求选择最适合的笔记格式。例如，学生可以使用文本和图片笔记来记录课堂内容，开发者可以使用代码片段笔记来保存重要的代码示例。这种多功能性确保了 ThinKing 能够满足不同用户群体的多样化需求。\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"8deccccc-8e14-4640-9ddb-041661409f62\", \"level\": 1, \"data-toc-id\": \"8deccccc-8e14-4640-9ddb-041661409f62\"}, \"content\": [{\"text\": \"支持以下格式\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"1881c0db-1fdf-491e-8f39-df38c10ef958\", \"level\": 3, \"data-toc-id\": \"1881c0db-1fdf-491e-8f39-df38c10ef958\"}, \"content\": [{\"text\": \"标题\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"89e823f8-c85c-4dac-b814-4ea8d398c0f0\", \"level\": 1, \"data-toc-id\": \"89e823f8-c85c-4dac-b814-4ea8d398c0f0\"}, \"content\": [{\"text\": \"标题一\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"47859c05-b893-468e-b3c7-d2a24d0d8a84\", \"level\": 2, \"data-toc-id\": \"47859c05-b893-468e-b3c7-d2a24d0d8a84\"}, \"content\": [{\"text\": \"标题二\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"685af503-3bc1-4926-9bb1-7d32122c2396\", \"level\": 3, \"data-toc-id\": \"685af503-3bc1-4926-9bb1-7d32122c2396\"}, \"content\": [{\"text\": \"标题三\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"e4e71418-50fd-4f15-8808-42e3af5f267e\", \"level\": 4, \"data-toc-id\": \"e4e71418-50fd-4f15-8808-42e3af5f267e\"}, \"content\": [{\"text\": \"标题四\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"2f37247b-b79a-4f8d-80f3-81bb6ab13451\", \"level\": 4, \"data-toc-id\": \"2f37247b-b79a-4f8d-80f3-81bb6ab13451\"}, \"content\": [{\"text\": \"标题五\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"f024f6f6-8f95-4c3e-93c4-7159de4ee7d0\", \"level\": 6, \"data-toc-id\": \"f024f6f6-8f95-4c3e-93c4-7159de4ee7d0\"}, \"content\": [{\"text\": \"标题六\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"405cac26-cfed-4fd5-a91e-0d898aa98806\", \"level\": 3, \"data-toc-id\": \"405cac26-cfed-4fd5-a91e-0d898aa98806\"}, \"content\": [{\"text\": \"表格\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"table\", \"content\": [{\"type\": \"tableRow\", \"content\": [{\"type\": \"tableHeader\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"姓名\", \"type\": \"text\"}]}]}, {\"type\": \"tableHeader\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"年龄\", \"type\": \"text\"}]}]}, {\"type\": \"tableHeader\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"性别\", \"type\": \"text\"}]}]}]}, {\"type\": \"tableRow\", \"content\": [{\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"张三\", \"type\": \"text\"}]}]}, {\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"李四\", \"type\": \"text\"}]}]}, {\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"男\", \"type\": \"text\"}]}]}]}, {\"type\": \"tableRow\", \"content\": [{\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\"}]}, {\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\"}]}, {\"type\": \"tableCell\", \"attrs\": {\"colspan\": 1, \"rowspan\": 1, \"colwidth\": null}, \"content\": [{\"type\": \"paragraph\"}]}]}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"ab0b009a-e000-47c1-8eaf-211b7b38f77b\", \"level\": 3, \"data-toc-id\": \"ab0b009a-e000-47c1-8eaf-211b7b38f77b\"}, \"content\": [{\"text\": \"清单\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"taskList\", \"content\": [{\"type\": \"taskItem\", \"attrs\": {\"checked\": true}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"阅读10本书\", \"type\": \"text\"}]}]}, {\"type\": \"taskItem\", \"attrs\": {\"checked\": false}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"12点前睡\", \"type\": \"text\"}]}]}, {\"type\": \"taskItem\", \"attrs\": {\"checked\": false}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"完成毕业设计\", \"type\": \"text\"}]}]}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"328fcf06-e73b-46a5-a43c-f04d61a2a5a7\", \"level\": 3, \"data-toc-id\": \"328fcf06-e73b-46a5-a43c-f04d61a2a5a7\"}, \"content\": [{\"text\": \"列表\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"bulletList\", \"content\": [{\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"无序列表\", \"type\": \"text\"}]}]}, {\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"无序列表\", \"type\": \"text\"}]}]}]}, {\"type\": \"orderedList\", \"attrs\": {\"start\": 1}, \"content\": [{\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"有序列表\", \"type\": \"text\"}]}]}, {\"type\": \"listItem\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"有序列表\", \"type\": \"text\"}]}]}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"97bb0b39-e480-4de9-bc3c-1d3aebc70b56\", \"level\": 3, \"data-toc-id\": \"97bb0b39-e480-4de9-bc3c-1d3aebc70b56\"}, \"content\": [{\"text\": \"代码\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"codeBlock\", \"attrs\": {\"language\": null}, \"content\": [{\"text\": \"export async function addSpace(data) {\\n    const res = await service.post(\'/note/space/add\', data);\\n    if (res.code === 200) {\\n        return res.data;\\n    }\\n    return Promise.reject(new Error(res.message));\\n}\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"heading\", \"attrs\": {\"id\": \"3fce4cfd-3686-4026-acac-50487336d682\", \"level\": 3, \"data-toc-id\": \"3fce4cfd-3686-4026-acac-50487336d682\"}, \"content\": [{\"text\": \"引用\", \"type\": \"text\"}]}, {\"type\": \"horizontalRule\"}, {\"type\": \"blockquote\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"这是一个引用\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"哈哈哈\", \"type\": \"text\"}]}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"382d172d-46de-4ded-aa15-52eb21ba18fe\", \"level\": 3, \"data-toc-id\": \"382d172d-46de-4ded-aa15-52eb21ba18fe\"}}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"等等还有许多功能开发中...\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\"}]}', 1, 'default', 'default', '16', '0', NULL, 1, 1, 0, '2024-12-07 06:36:02', '2024-12-21 05:25:22');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865163576329809921, 1865162461555109890, 1859329812227633153, 0, NULL, '🐣', 'New Page', 'SystemDefaultFiles/images/cover/2.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"codeBlock\", \"attrs\": {\"language\": \"java\"}, \"content\": [{\"text\": \"package work.zhangchengwei.note.controller;\\n\\n\\nimport cn.dev33.satoken.stp.StpUtil;\\nimport com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;\\nimport com.fasterxml.jackson.databind.JsonNode;\\nimport com.fasterxml.jackson.databind.ObjectMapper;\\nimport org.springframework.beans.factory.annotation.Autowired;\\nimport org.springframework.web.bind.annotation.*;\\n\\nimport work.zhangchengwei.core.web.ResponseResult;\\nimport work.zhangchengwei.note.entity.NotePage;\\nimport work.zhangchengwei.note.entity.NoteSpace;\\nimport work.zhangchengwei.note.entity.NoteSubscribe;\\nimport work.zhangchengwei.note.mapper.NotePageMapper;\\nimport work.zhangchengwei.note.service.INotePageService;\\nimport work.zhangchengwei.note.service.INoteSpaceService;\\nimport work.zhangchengwei.system.entity.SysUser;\\n\\nimport java.util.List;\\n\\n/**\\n * <p>\\n * 页面 前端控制器\\n * </p>\\n *\\n * @author izcw\\n * @since 2024-12-06\\n */\\n@RestController\\n@RequestMapping(\\\"/note/page\\\")\\npublic class NotePageController {\\n    @Autowired\\n    private INotePageService notePageService;\\n    @Autowired\\n    private NotePageMapper notePageMapper;\\n\\n\\n    /**\\n     * 获取空间下的所有笔记\\n     * @return 笔记列表\\n     */\\n    @GetMapping(\\\"/spacePage\\\")\\n    public ResponseResult<List<NotePage>> getSpacePage(@RequestParam(\\\"spaceId\\\") String spaceId) {\\n        // 获取登录用户的 userId 字符串\\n        String userIdStr = StpUtil.getLoginIdAsString();\\n        Long userId = Long.parseLong(userIdStr);\\n\\n        // 创建 QueryWrapper 并设置查询条件\\n        QueryWrapper<NotePage> queryWrapper = new QueryWrapper<>();\\n        queryWrapper.eq(\\\"user_id\\\", userId);\\n        queryWrapper.eq(\\\"space_id\\\", spaceId);\\n\\n        // 执行查询，假设你有一个 noteSpaceService 可以执行数据库查询\\n        List<NotePage> list = notePageService.list(queryWrapper);\\n\\n        // 返回查询结果\\n//        if (list != null && !list.isEmpty()) {\\n            return ResponseResult.success(\\\"查询成功\\\", list);\\n//        } else {\\n//            return ResponseResult.error(\\\"没有找到数据\\\");\\n//        }\\n    }\\n\\n    /**\\n     * 根据ID获取页面\\n     * @param id 笔记ID\\n     * @return 笔记\\n     */\\n    @GetMapping(\\\"/{id}\\\")\\n    public ResponseResult<NotePage> getPageById(@PathVariable String id) {\\n        NotePage notePage = notePageMapper.selectById(id);\\n        if (notePage == null) {\\n            return ResponseResult.fail(\\\"未找到该笔记\\\");\\n        }\\n        return ResponseResult.success(notePage);\\n    }\\n\\n    /**\\n     * 添加笔记\\n     * @return\\n     */\\n    @PostMapping(\\\"/add\\\")\\n    public ResponseResult<String> add(@RequestBody NotePage notePage) {\\n        // 获取当前登录用户的 ID\\n        String userIdStr = StpUtil.getLoginIdAsString();\\n        System.out.println(userIdStr);\\n        // 将字符串转换为长整型\\n        Long userId = Long.parseLong(userIdStr);\\n        notePage.setUserId(userId);\\n\\n        String jsonContent = \\\"{\\\\n\\\" +\\n                \\\"    \\\\\\\"type\\\\\\\": \\\\\\\"doc\\\\\\\",\\\\n\\\" +\\n                \\\"    \\\\\\\"content\\\\\\\": [\\\\n\\\" +\\n                \\\"        {\\\\n\\\" +\\n                \\\"            \\\\\\\"type\\\\\\\": \\\\\\\"paragraph\\\\\\\"\\\\n\\\" +\\n                \\\"        }\\\\n\\\" +\\n                \\\"    ]\\\\n\\\" +\\n                \\\"}\\\";\\n        // 使用 Jackson 的 ObjectMapper 将 String 转换为 JsonNode\\n        try {\\n            ObjectMapper objectMapper = new ObjectMapper();\\n            JsonNode jsonNode = objectMapper.readTree(jsonContent);\\n            notePage.setContent(jsonNode);\\n        } catch (Exception e) {\\n            e.printStackTrace();\\n            System.out.println(\\\"保存失败：\\\" + e.getMessage());\\n        }\\n\\n        boolean inserted = notePageService.save(notePage); // 保存\\n        if (inserted) {\\n            return ResponseResult.success(\\\"添加成功\\\",null);\\n        } else {\\n            return ResponseResult.fail(\\\"添加失败\\\");\\n        }\\n    }\\n\\n    /**\\n     * 更新信息\\n     * @return 更新结果\\n     */\\n    @PutMapping(\\\"/update\\\")\\n    public ResponseResult<NotePage> update(@RequestBody NotePage notePage) {\\n        // 执行更新操作，传入实体对象和更新条件\\n        boolean updated = notePageMapper.updateById(notePage) > 0;\\n\\n        if (updated) {\\n            // 更新成功后，重新从数据库中查询完整的记录\\n            NotePage updatedNotePage = notePageMapper.selectById(notePage.getPageId());\\n            return ResponseResult.success(\\\"修改成功\\\", updatedNotePage);\\n        } else {\\n            // 更新失败，返回失败消息\\n            return ResponseResult.error(\\\"修改失败\\\");\\n        }\\n    }\\n\\n}\\n\", \"type\": \"text\"}]}]}', 0, 'default', 'monospace', '16', '0', NULL, 1, 0, 0, '2024-12-07 06:37:04', '2024-12-21 04:12:20');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865163733544906754, 1865162461555109890, 1859329812227633153, 0, NULL, '🐭', '新页面', 'SystemDefaultFiles/images/cover/9.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"heading\", \"attrs\": {\"id\": \"548dfb33-134d-4e69-adad-d6e601523233\", \"level\": 1, \"data-toc-id\": \"548dfb33-134d-4e69-adad-d6e601523233\"}, \"content\": [{\"text\": \"ddhh \", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"/\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"\\\\\\\\\\\\\\\\\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\"}]}', 1, 'small', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 06:37:41', '2024-12-21 04:11:56');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865164565594157057, 1865162461555109890, 1859329812227633153, 1865163576329809921, NULL, '🦜', 'New Page', 'SystemDefaultFiles/images/cover/5.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 0, 'mobile', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 06:41:00', '2024-12-21 04:11:57');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865164578495836162, 1865162461555109890, 1859329812227633153, 1865164565594157057, NULL, '🌎', 'hhhh', 'SystemDefaultFiles/images/cover/6.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 1, 'big', 'default', '16', '0', NULL, 0, 1, 0, '2024-12-07 06:41:03', '2024-12-21 05:27:14');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865164608241840129, 1865162461555109890, 1859329812227633153, 1865163576329809921, NULL, '🍳', 'New Page', 'SystemDefaultFiles/images/cover/1.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 1, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 06:41:10', '2024-12-21 04:12:00');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865172440588689409, 1865162594686513153, 1859329812227633153, 0, NULL, '🥣', 'New Page', 'SystemDefaultFiles/images/cover/2.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 1, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 07:12:17', '2024-12-21 04:12:01');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865174933133533186, 1865162594686513153, 1859329812227633153, 0, NULL, '🧊', 'New Page', 'SystemDefaultFiles/images/cover/3.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 1, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 07:22:11', '2024-12-21 04:12:02');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865174957473079298, 1865162594686513153, 1859329812227633153, 1865174933133533186, NULL, '🧂', 'New Page', 'SystemDefaultFiles/images/cover/4.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"开始你的笔记之旅！\", \"type\": \"text\"}]}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-07 07:22:17', '2024-12-21 04:12:04');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1865180814776672258, 1865162461555109890, 1859329812227633153, 1865163315842560002, NULL, '🍐', '新手引导', 'SystemDefaultFiles/images/cover/3.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"heading\", \"attrs\": {\"id\": \"b911495d-0840-45be-b7bb-87ed783a228e\", \"level\": 1, \"data-toc-id\": \"b911495d-0840-45be-b7bb-87ed783a228e\"}, \"content\": [{\"text\": \"n你好\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"深爱的\", \"type\": \"text\"}]}, {\"type\": \"heading\", \"attrs\": {\"id\": \"89870ee9-9dab-4ac8-907d-ebc566a716ea\", \"level\": 1, \"data-toc-id\": \"89870ee9-9dab-4ac8-907d-ebc566a716ea\"}, \"content\": [{\"text\": \"的说法\", \"type\": \"text\"}]}, {\"type\": \"paragraph\"}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"的说法是的分段时光的风格的风格和风格和符号的话\", \"type\": \"text\"}]}]}', 1, 'default', 'monospace', '16', '0', NULL, 0, 0, 0, '2024-12-07 07:45:34', '2024-12-21 04:20:50');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1866018553628798978, 1865162461555109890, 1859329812227633153, 1865163733544906754, NULL, '🚌', 'dsff', 'SystemDefaultFiles/images/cover/2.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"type\": \"text\"}]}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-09 15:14:26', '2024-12-21 04:12:06');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1866579544442032129, 1865162461555109890, 1859329812227633153, 1865164578495836162, NULL, NULL, '你好', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-11 04:23:37', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1866579564327227394, 1865162461555109890, 1859329812227633153, 1866579544442032129, NULL, '👮', 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-11 04:23:42', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705072525533185, 1865162594686513153, 1859329812227633153, 0, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"fdf fdsfd\", \"type\": \"text\"}]}]}', 0, 'default', 'default', '14', '0', NULL, 0, 0, 0, '2024-12-14 06:56:04', '2024-12-21 04:58:18');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705082390536194, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:06', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705084525436930, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:07', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705085766950914, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:07', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705086538702849, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:07', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705087247540225, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:07', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705087847325697, 1865162594686513153, 1859329812227633153, 1867705072525533185, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:07', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705097754271745, 1865162594686513153, 1859329812227633153, 1867705082390536194, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:10', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1867705105530511361, 1865162594686513153, 1859329812227633153, 1867705084525436930, NULL, NULL, 'New Page', NULL, '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-14 06:56:12', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1870171433861275650, 1865162461555109890, 1859329812227633153, 1865163733544906754, NULL, NULL, 'New Page', 'SystemDefaultFiles/images/cover/3.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-21 02:16:30', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1870171719803756545, 1865162461555109890, 1859329812227633153, 1866018553628798978, NULL, '📱', 'New Page', 'SystemDefaultFiles/images/cover/2.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"paragraph\"}]}', 1, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-21 02:17:38', '2024-12-21 04:12:11');
INSERT INTO `note_page` (`page_id`, `space_id`, `user_id`, `parent_id`, `sort_number`, `icon`, `title`, `cover`, `content`, `collect`, `layout`, `font`, `size`, `readonly`, `password`, `share`, `template`, `deleted`, `create_time`, `update_time`) VALUES (1870190330865934338, 1865162461555109890, 1859329812227633153, 0, NULL, '🍊', 'Hello', 'SystemDefaultFiles/images/cover/11.jpg', '{\"type\": \"doc\", \"content\": [{\"type\": \"heading\", \"attrs\": {\"id\": \"a357978f-3b76-4877-b092-55ba4f86d253\", \"level\": 1, \"data-toc-id\": \"a357978f-3b76-4877-b092-55ba4f86d253\"}, \"content\": [{\"text\": \"你好\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"dsjkfh\", \"type\": \"text\"}]}, {\"type\": \"blockquote\", \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"的方式\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"的说法\", \"type\": \"text\"}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"是对方\", \"type\": \"text\"}]}]}, {\"type\": \"taskList\", \"content\": [{\"type\": \"taskItem\", \"attrs\": {\"checked\": true}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"的地方\", \"type\": \"text\"}]}]}, {\"type\": \"taskItem\", \"attrs\": {\"checked\": true}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"是对方\", \"type\": \"text\"}]}]}, {\"type\": \"taskItem\", \"attrs\": {\"checked\": true}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"的说法\", \"type\": \"text\"}]}]}, {\"type\": \"taskItem\", \"attrs\": {\"checked\": false}, \"content\": [{\"type\": \"paragraph\", \"content\": [{\"text\": \"的说法\", \"type\": \"text\"}]}]}]}, {\"type\": \"paragraph\", \"content\": [{\"text\": \"/\", \"type\": \"text\"}]}]}', 0, 'default', 'default', '16', '0', NULL, 0, 0, 0, '2024-12-21 03:31:36', '2024-12-21 04:12:11');
COMMIT;

-- ----------------------------
-- Table structure for note_page_history
-- ----------------------------
DROP TABLE IF EXISTS `note_page_history`;
CREATE TABLE `note_page_history` (
  `page_history_id` int NOT NULL AUTO_INCREMENT COMMENT '页面历史id',
  `page_id` bigint NOT NULL COMMENT '页面id',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '历史版本',
  `is_current_version` int DEFAULT '0' COMMENT '当前使用版本：0历史版本，1当前使用',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面图标',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面标题',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '页面封面',
  `content` json DEFAULT NULL COMMENT '笔记内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`page_history_id`) USING BTREE,
  KEY `note_page_history_page_id` (`page_id`),
  CONSTRAINT `note_page_history_page_id` FOREIGN KEY (`page_id`) REFERENCES `note_page` (`page_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='笔记编辑历史版本';

-- ----------------------------
-- Records of note_page_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for note_setting
-- ----------------------------
DROP TABLE IF EXISTS `note_setting`;
CREATE TABLE `note_setting` (
  `setting_id` bigint NOT NULL AUTO_INCREMENT COMMENT '笔记软件设置id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `language` enum('简体中文','English') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '简体中文' COMMENT '语言',
  `theme` int DEFAULT '0' COMMENT '主题：0白，1黑',
  `sidebar` int DEFAULT '300' COMMENT '侧边栏：0收起，n宽度',
  `tools_sidebar` int DEFAULT '300' COMMENT '工具侧边栏：0收起，n宽度',
  `start_page` bigint DEFAULT '0' COMMENT '启动时展示页面：0默认空间主页，n上次操作的页面',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`setting_id`) USING BTREE,
  KEY `note_setting_user_id` (`user_id`),
  CONSTRAINT `note_setting_user_id` FOREIGN KEY (`user_id`) REFERENCES `note_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
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
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New Space' COMMENT '空间名称',
  `color` int DEFAULT '1' COMMENT '空间主题色',
  `sort_number` int DEFAULT NULL COMMENT '排序',
  `default_space` int DEFAULT '1' COMMENT '默认空间： 0默认, 1其它',
  `deleted` int DEFAULT '0' COMMENT '是否删除： 0否, 1回收站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`space_id`) USING BTREE,
  KEY `note_space_` (`user_id`),
  CONSTRAINT `note_space_` FOREIGN KEY (`user_id`) REFERENCES `note_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1870224504075214850 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='笔记空间';

-- ----------------------------
-- Records of note_space
-- ----------------------------
BEGIN;
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `sort_number`, `default_space`, `deleted`, `create_time`, `update_time`) VALUES (1865162461555109890, 1859329812227633153, '默认空间', 1, 9, 0, 0, '2024-12-07 06:32:38', '2024-12-21 00:46:40');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `sort_number`, `default_space`, `deleted`, `create_time`, `update_time`) VALUES (1865162594686513153, 1859329812227633153, '外语学习', 2, 9, 1, 0, '2024-12-07 06:33:10', '2024-12-21 03:12:10');
INSERT INTO `note_space` (`space_id`, `user_id`, `name`, `color`, `sort_number`, `default_space`, `deleted`, `create_time`, `update_time`) VALUES (1870224504075214849, 1859329812227633153, '编程', 1, 9, 1, 0, '2024-12-21 05:47:23', '2024-12-21 05:47:23');
COMMIT;

-- ----------------------------
-- Table structure for note_subscribe
-- ----------------------------
DROP TABLE IF EXISTS `note_subscribe`;
CREATE TABLE `note_subscribe` (
  `subscribe_id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐id',
  `subscribe_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '套餐名称',
  `subscribe_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '套餐标识',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `oldprice` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '原价',
  `unit` int DEFAULT '30' COMMENT '订阅天数：0为无限',
  `space` int DEFAULT '3' COMMENT '空间个数',
  `page_wordage` int DEFAULT '10000' COMMENT '页面最大字数：0等于无限',
  `recycle` int DEFAULT '30' COMMENT '回收站最大天数',
  `page_history` int DEFAULT '30' COMMENT '页面编辑历史记录最大天数',
  `ai` int DEFAULT '5' COMMENT 'AI 每天使用次数：0等于无限',
  `recommend` tinyint DEFAULT '0' COMMENT '是否推荐： 1 表示推荐，0 表示不推荐',
  `status` int DEFAULT '0' COMMENT '状态： 0正常, 1下架',
  `comments` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `deleted` int DEFAULT '0' COMMENT '逻辑删除,：0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`subscribe_id`) USING BTREE,
  KEY `subscribe_id` (`subscribe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of note_subscribe
-- ----------------------------
BEGIN;
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `price`, `oldprice`, `unit`, `space`, `page_wordage`, `recycle`, `page_history`, `ai`, `recommend`, `status`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (1, '个人普通版', 'Lite', 0.00, 0.00, 0, 3, 10000, 30, 30, 5, 0, 0, '普通用户Lite', 0, '2024-11-21 23:49:51', '2024-12-05 17:03:02');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `price`, `oldprice`, `unit`, `space`, `page_wordage`, `recycle`, `page_history`, `ai`, `recommend`, `status`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (2, '个人Plus+', 'Plus', 12.00, 24.00, 30, 5, 100000, 30, 30, 10, 1, 0, '个人Plus版', 0, '2024-11-21 23:50:47', '2024-12-05 18:40:24');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `price`, `oldprice`, `unit`, `space`, `page_wordage`, `recycle`, `page_history`, `ai`, `recommend`, `status`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (3, '团队版', 'Team', 48.00, 68.00, 90, 10, 0, 90, 90, 100, 0, 0, '团队版', 0, '2024-11-21 23:51:35', '2024-12-05 18:41:23');
INSERT INTO `note_subscribe` (`subscribe_id`, `subscribe_name`, `subscribe_code`, `price`, `oldprice`, `unit`, `space`, `page_wordage`, `recycle`, `page_history`, `ai`, `recommend`, `status`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (4, '企业版', 'Business', 88.00, 120.00, 366, 20, 0, 365, 365, 0, 0, 0, '企业版：AI、字数不限', 0, '2024-11-21 23:54:11', '2024-12-05 18:41:20');
COMMIT;

-- ----------------------------
-- Table structure for note_subscribe_order
-- ----------------------------
DROP TABLE IF EXISTS `note_subscribe_order`;
CREATE TABLE `note_subscribe_order` (
  `subscribe_order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐订阅订单id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `subscribe_id` bigint NOT NULL COMMENT '套餐id',
  `price` decimal(10,0) unsigned NOT NULL DEFAULT '0' COMMENT '实付价格',
  `transactions` enum('Alipay','Wechat') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Alipay' COMMENT '交易方式',
  `status` int DEFAULT '0' COMMENT '状态：0订单完成, 1订单异常，2已退款、3支付失败',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`subscribe_order_id`) USING BTREE,
  KEY `note_subscribe_order_user_id` (`user_id`),
  KEY `note_subscribe_order_subscribe_id` (`subscribe_id`),
  CONSTRAINT `note_subscribe_order_subscribe_id` FOREIGN KEY (`subscribe_id`) REFERENCES `note_subscribe` (`subscribe_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `note_subscribe_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `note_user` (`user_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=53453645777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户套餐订单';

-- ----------------------------
-- Records of note_subscribe_order
-- ----------------------------
BEGIN;
INSERT INTO `note_subscribe_order` (`subscribe_order_id`, `user_id`, `subscribe_id`, `price`, `transactions`, `status`, `create_time`) VALUES (53453645776, 1859329812227633153, 4, 88, 'Alipay', 0, '2024-12-14 06:08:48');
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
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱/账号',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New ThinKing' COMMENT '昵称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'SystemDefaultFiles/images/avatar/avatar-default.png' COMMENT '头像',
  `status` int DEFAULT '0' COMMENT '状态：0正常, 1冻结，2异常，3注销',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1865183706388570115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户';

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
INSERT INTO `note_user` (`user_id`, `email`, `password`, `nickname`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1865183706388570114, '24058240843@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$Vmpuzyjd3QIEnWrT+7eZaw$Wqp63CQ55rj9mY0ABRmIunBdqwRSbQf/o0y2ugAOuh8', 'dass', 'UserFiles/images/avatar/5a6eac50-0877-45ae-b5c3-a957216b0b9b.png', 2, '2024-12-07 07:57:03', '2024-12-16 05:26:44');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int DEFAULT '0' COMMENT '父id,：0是顶级',
  `authority` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单图标',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'New Menu' COMMENT '菜单名称',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单路由地址',
  `component` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单组件地址, 目录可为空',
  `menu_type` int DEFAULT '0' COMMENT '类型：0菜单, 1按钮',
  `sort_number` int DEFAULT NULL COMMENT '排序',
  `hide` int DEFAULT '0' COMMENT '是否隐藏：0否, 1是(仅注册路由不显示在左侧菜单)',
  `meta` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它路由元信息',
  `deleted` int DEFAULT '0' COMMENT '逻辑删除：0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (1, 0, NULL, 'Setting', '系统管理', '/system', NULL, 0, 500, 0, '{\"badge\": \"New\", \"badgeColor\": \"warning\"}', 0, '2020-02-26 12:51:23', '2024-10-14 00:19:14');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (2, 1, NULL, 'el-icon-_user-group', '系统用户管理', '/system/user', '/system/user', 0, 2, 0, NULL, 0, '2020-02-26 12:51:55', '2024-11-14 20:42:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (3, 2, 'sys:user:list', NULL, '查询用户', NULL, NULL, 1, 1, 0, NULL, 0, '2020-02-26 12:52:06', '2020-09-16 11:05:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (4, 2, 'sys:user:save', NULL, '添加用户', NULL, NULL, 1, 2, 0, NULL, 0, '2020-02-26 12:52:26', '2020-03-21 18:45:29');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (5, 2, 'sys:user:update', NULL, '修改用户', NULL, NULL, 1, 3, 0, NULL, 0, '2020-02-26 12:52:50', '2020-03-21 18:45:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (6, 2, 'sys:user:remove', NULL, '删除用户', NULL, NULL, 1, 4, 0, NULL, 0, '2020-02-26 12:53:13', '2020-03-21 18:45:32');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (7, 1, NULL, 'el-icon-postcard', '系统角色管理', '/system/role', '/system/role', 0, 3, 0, NULL, 0, '2020-03-13 13:29:08', '2024-11-14 20:42:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (8, 7, 'sys:role:list', NULL, '查询角色', NULL, NULL, 1, 1, 0, NULL, 0, '2020-03-13 13:30:41', '2020-03-21 18:45:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (9, 7, 'sys:role:save', NULL, '添加角色', NULL, NULL, 1, 2, 0, NULL, 0, '2020-03-15 13:02:07', '2020-03-21 18:45:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (10, 7, 'sys:role:update', NULL, '修改角色', NULL, NULL, 1, 3, 0, NULL, 0, '2020-03-15 13:02:49', '2020-03-21 18:45:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (11, 7, 'sys:role:remove', NULL, '删除角色', NULL, NULL, 1, 4, 0, NULL, 0, '2020-03-20 17:58:51', '2020-03-21 18:45:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (12, 1, NULL, 'el-icon-s-operation', '系统菜单管理', '/system/menu', '/system/menu', 0, 4, 0, NULL, 0, '2020-03-21 01:07:13', '2024-11-14 20:42:39');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (13, 12, 'sys:menu:list', NULL, '查询菜单', NULL, NULL, 1, 1, 0, NULL, 0, '2020-03-21 16:43:30', '2020-03-21 18:45:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (14, 12, 'sys:menu:save', NULL, '添加菜单', NULL, NULL, 1, 2, 0, NULL, 0, '2020-03-21 16:43:54', '2020-03-21 18:45:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (15, 12, 'sys:menu:update', NULL, '修改菜单', NULL, NULL, 1, 3, 0, NULL, 0, '2020-03-21 18:24:17', '2020-03-21 18:45:43');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (16, 12, 'sys:menu:remove', NULL, '删除菜单', NULL, NULL, 1, 4, 0, NULL, 0, '2020-03-21 18:24:18', '2020-03-21 18:45:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (27, 1, 'sys:login-record:list', 'el-icon-date', '系统登录日志', '/system/login-record', '/system/login-record', 0, 5, 0, NULL, 0, '2020-03-21 18:24:33', '2024-11-14 20:42:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (28, 1, 'sys:operation-record:list', 'el-icon-_retrieve', '系统操作日志', '/system/operation-record', '/system/operation-record', 0, 6, 0, NULL, 0, '2020-03-21 18:24:34', '2024-11-14 20:42:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (29, 1, NULL, 'el-icon-folder', '文件管理', '/system/file', '/system/file', 0, 6, 1, NULL, 0, '2020-09-17 23:19:43', '2022-03-11 22:13:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (30, 29, 'sys:file:upload', NULL, '上传文件', NULL, NULL, 1, 1, 0, NULL, 0, '2020-09-17 23:21:04', '2022-07-20 16:40:21');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (31, 29, 'sys:file:remove', NULL, '删除文件', NULL, NULL, 1, 2, 0, NULL, 0, '2020-09-17 23:21:53', '2022-07-20 16:40:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (32, 29, 'sys:file:list', NULL, '查看记录', NULL, NULL, 1, 3, 0, NULL, 0, '2020-09-17 23:20:29', '2022-07-20 16:40:24');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (33, 2, NULL, 'el-icon-user', '用户详情', '/system/user/details', '/system/user/details', 0, 5, 1, '{\"active\": \"/system/user\"}', 0, '2021-05-21 11:07:54', '2022-07-20 16:39:29');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (34, 1, 'sys:auth:password', NULL, '修改个人密码', NULL, NULL, 1, 9, 0, NULL, 0, '2020-09-17 23:22:45', '2022-07-20 16:40:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (35, 1, 'sys:auth:user', NULL, '修改个人资料', NULL, NULL, 1, 10, 0, NULL, 0, '2020-09-17 23:23:24', '2022-07-20 16:40:55');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (36, 0, NULL, 'House', '仪表板', '/dashboard', NULL, 0, 0, 0, NULL, 0, '2021-02-02 20:00:34', '2024-10-11 21:38:02');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (37, 36, NULL, 'el-icon-monitor', '工作台', '/dashboard/workplace', '/dashboard/workplace', 0, 1, 0, NULL, 0, '2021-02-02 20:00:37', '2021-11-05 16:36:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (38, 36, NULL, 'el-icon-data-analysis', '分析页', '/dashboard/analysis', '/dashboard/analysis', 0, 2, 0, '{\"badge\": 1}', 0, '2021-02-02 20:00:40', '2022-03-11 16:45:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (39, 36, NULL, 'el-icon-odometer', '监控页', '/dashboard/monitor', '/dashboard/monitor', 0, 3, 0, NULL, 0, '2021-02-02 20:03:12', '2021-11-05 16:36:56');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (40, 0, NULL, 'el-icon-tickets', '表单页面0001', '/form', NULL, 0, 2, 0, NULL, 0, '2021-02-02 20:03:28', '2024-10-11 13:08:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (41, 40, NULL, 'el-icon-_feedback', '基础表单', '/form/basic', '/form/basic', 0, 1, 0, NULL, 0, '2021-02-02 20:03:51', '2021-11-05 16:36:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (42, 40, NULL, 'el-icon-_visa', '复杂表单', '/form/advanced', '/form/advanced', 0, 2, 0, NULL, 0, '2021-02-02 20:03:56', '2021-11-05 16:36:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (43, 40, NULL, 'el-icon-c-scale-to-original', '分步表单', '/form/step', '/form/step', 0, 3, 0, NULL, 0, '2021-02-02 20:04:06', '2021-11-05 16:36:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (44, 0, NULL, 'el-icon-_table', '列表页面', '/list', NULL, 0, 3, 0, NULL, 0, '2021-02-02 20:05:07', '2021-11-05 16:36:49');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (45, 44, NULL, 'el-icon-document', '基础列表', '/list/basic', '/list/basic', 0, 1, 0, NULL, 0, '2021-02-02 20:05:10', '2021-11-05 16:36:48');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (46, 44, NULL, 'el-icon-_cols', '复杂列表', '/list/advanced', '/list/advanced', 0, 2, 0, NULL, 0, '2021-02-02 20:05:26', '2021-11-05 16:36:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (47, 44, NULL, 'el-icon-_menu', '卡片列表', '/list/card', '/list/card', 0, 3, 0, NULL, 0, '2021-02-02 20:05:30', '2021-11-05 16:36:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (48, 47, NULL, 'el-icon-_menu', '项目列表', '/list/card/project', '/list/card/project', 0, 1, 0, NULL, 0, '2021-02-02 20:06:35', '2021-11-05 16:36:44');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (49, 47, NULL, 'el-icon-_menu', '应用列表', '/list/card/application', '/list/card/application', 0, 2, 0, NULL, 0, '2021-02-02 20:06:39', '2021-11-05 16:36:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (50, 47, NULL, 'el-icon-_menu', '文章列表', '/list/card/article', '/list/card/article', 0, 3, 0, NULL, 0, '2021-02-02 20:06:48', '2021-11-05 16:36:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (51, 45, NULL, 'el-icon-user', '添加用户', '/list/basic/add', '/list/basic/add', 0, 1, 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:25');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (52, 45, NULL, 'el-icon-user', '修改用户', '/list/basic/edit', '/list/basic/edit', 0, 2, 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:26');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (53, 45, NULL, 'el-icon-user', '用户详情', '/list/basic/details/:id', '/list/basic/details', 0, 3, 1, '{\"active\": \"/list/basic\"}', 0, '2022-03-11 21:56:38', '2022-07-20 16:42:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (54, 0, NULL, 'el-icon-circle-check', '结果页面', '/result', NULL, 0, 4, 0, NULL, 0, '2021-02-02 20:07:33', '2021-11-05 16:36:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (55, 54, NULL, 'el-icon-circle-check', '成功页', '/result/success', '/result/success', 0, 1, 0, NULL, 0, '2021-02-02 20:07:40', '2021-11-05 16:36:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (56, 54, NULL, 'el-icon-circle-close', '失败页', '/result/fail', '/result/fail', 0, 2, 0, NULL, 0, '2021-02-02 20:07:41', '2021-11-05 16:36:37');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (57, 0, NULL, 'el-icon-document-delete', '异常页面', '/exception', NULL, 0, 5, 0, NULL, 0, '2021-02-02 20:08:44', '2021-11-05 16:36:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (58, 57, NULL, 'el-icon-document-checked', '403', '/exception/403', '/exception/403', 0, 1, 0, NULL, 0, '2021-02-02 20:08:47', '2021-11-05 16:36:35');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (59, 57, NULL, 'el-icon-document-remove', '404', '/exception/404', '/exception/404', 0, 2, 0, NULL, 0, '2021-02-02 20:08:49', '2021-11-05 16:36:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (60, 57, NULL, 'el-icon-document-delete', '500', '/exception/500', '/exception/500', 0, 3, 0, NULL, 0, '2021-02-02 20:08:52', '2021-11-05 16:36:33');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (61, 1, NULL, 'Tickets', '个人中心', '/user', NULL, 0, 1, 0, NULL, 0, '2021-02-02 20:09:54', '2024-11-14 20:42:13');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (62, 61, NULL, 'el-icon-user', '我的资料', '/user/profile', '/user/profile', 0, 1, 0, NULL, 0, '2021-02-02 20:09:58', '2021-11-05 16:36:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (64, 0, NULL, 'el-icon-open', '扩展组件', '/extension', NULL, 0, 7, 0, NULL, 0, '2021-02-02 20:10:52', '2021-11-05 16:36:26');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (65, 64, NULL, 'el-icon-_heart', '图标扩展', '/extension/icon', '/extension/icon', 0, 1, 0, NULL, 0, '2021-02-02 20:10:55', '2022-03-11 21:36:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (66, 64, NULL, 'el-icon-price-tag', '标签组件', '/extension/tag', '/extension/tag', 0, 2, 0, NULL, 0, '2021-10-05 11:13:35', '2022-03-11 21:42:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (67, 64, NULL, 'el-icon-copy-document', '弹窗扩展', '/extension/dialog', '/extension/dialog', 0, 3, 0, NULL, 0, '2021-10-05 11:32:12', '2022-03-11 21:42:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (68, 64, NULL, 'el-icon-folder', '文件列表', '/extension/file', '/extension/file', 0, 4, 0, NULL, 0, '2021-02-02 20:10:58', '2022-03-11 21:37:16');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (69, 64, NULL, 'el-icon-picture-outline', '图片上传', '/extension/upload', '/extension/upload', 0, 5, 0, NULL, 0, '2021-02-02 20:10:58', '2022-07-20 16:49:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (70, 64, NULL, 'el-icon-rank', '拖拽排序', '/extension/dragsort', '/extension/dragsort', 0, 6, 0, NULL, 0, '2021-02-02 20:11:48', '2022-07-20 16:43:38');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (71, 64, NULL, 'el-icon-chat-line-square', '消息提示', '/extension/message', '/extension/message', 0, 7, 0, NULL, 0, '2021-10-05 11:14:28', '2022-07-20 16:43:39');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (72, 64, NULL, 'el-icon-office-building', '城市选择', '/extension/regions', '/extension/regions', 0, 8, 0, NULL, 0, '2021-10-05 11:25:15', '2022-07-20 16:43:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (73, 64, NULL, 'el-icon-printer', '打印插件', '/extension/printer', '/extension/printer', 0, 9, 0, NULL, 0, '2021-02-02 20:11:00', '2022-07-20 16:43:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (74, 64, NULL, 'el-icon-_table', 'excel插件', '/extension/excel', '/extension/excel', 0, 10, 0, NULL, 0, '2021-02-02 20:11:03', '2022-07-20 16:43:43');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (75, 64, NULL, 'el-icon-more', '滚动数字', '/extension/count-up', '/extension/count-up', 0, 11, 0, NULL, 0, '2021-10-05 11:29:03', '2022-07-20 16:43:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (76, 64, NULL, 'el-icon-receiving', '空状态', '/extension/empty', '/extension/empty', 0, 12, 0, NULL, 0, '2021-10-05 11:20:35', '2022-07-20 16:43:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (77, 64, NULL, 'el-icon-_timeline', '步骤条', '/extension/steps', '/extension/steps', 0, 13, 0, NULL, 0, '2021-10-05 11:16:39', '2022-07-20 16:43:49');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (78, 64, NULL, 'el-icon-s-operation', '菜单导航', '/extension/menu', '/extension/menu', 0, 14, 0, NULL, 0, '2021-10-05 11:18:35', '2022-07-20 16:43:51');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (79, 64, NULL, 'el-icon-_condition', '树形下拉', '/extension/tree-select', '/extension/tree-select', 0, 15, 0, NULL, 0, '2021-10-10 16:21:12', '2022-07-20 16:43:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (80, 64, NULL, 'el-icon-_table', '表格下拉', '/extension/table-select', '/extension/table-select', 0, 16, 0, NULL, 0, '2021-10-10 16:21:45', '2022-07-20 16:43:54');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (81, 64, NULL, NULL, '分割布局', '/extension/split-layout', '/extension/split-layout', 0, 17, 0, NULL, 1, '2021-10-10 16:21:45', '2022-07-20 16:45:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (82, 64, NULL, 'el-icon-_video', '视频播放', '/extension/player', '/extension/player', 0, 18, 0, NULL, 0, '2021-02-02 20:13:49', '2022-07-20 16:44:01');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (83, 64, NULL, 'el-icon-map-location', '地图组件', '/extension/map', '/extension/map', 0, 19, 0, NULL, 0, '2021-02-02 20:11:49', '2022-07-20 16:44:03');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (84, 64, NULL, 'el-icon-_qrcode', '二维码', '/extension/qr-code', '/extension/qr-code', 0, 20, 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:44:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (85, 64, NULL, 'el-icon-_barcode', '条形码', '/extension/bar-code', '/extension/bar-code', 0, 21, 0, NULL, 0, '2021-10-05 11:29:56', '2022-07-20 16:49:58');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (86, 64, NULL, 'el-icon-_font-family', '富文本框', '/extension/editor', '/extension/editor', 0, 22, 0, NULL, 0, '2021-02-02 20:13:57', '2022-07-20 16:44:07');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (87, 64, NULL, 'el-icon-_feedback', 'markdown', '/extension/markdown', '/extension/markdown', 0, 23, 0, NULL, 0, '2022-03-11 21:58:13', '2022-07-20 16:44:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (90, 0, NULL, 'el-icon-_integral', '常用实例', '/example', NULL, 0, 8, 0, NULL, 0, '2021-02-02 20:15:01', '2021-11-05 16:52:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (91, 90, NULL, 'el-icon-_table', '表格实例', '/example/table', '/example/table', 0, 1, 0, NULL, 0, '2021-10-06 22:26:55', '2022-03-11 21:53:34');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (92, 90, NULL, 'el-icon-_menu', '菜单徽章', '/example/menu-badge', '/example/menu-badge', 0, 2, 0, NULL, 1, '2022-03-11 21:57:35', '2022-03-11 21:57:47');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (93, 90, NULL, 'el-icon-connection', '内嵌页面', '/example/eleadmin', 'https://www.eleadmin.com', 0, 3, 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:55');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (94, 90, NULL, 'el-icon-connection', '内嵌文档', '/example/eleadmin-doc', 'https://eleadmin.com/doc/eleadmin/', 0, 4, 0, NULL, 0, '2021-05-21 11:11:57', '2022-07-20 16:45:56');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (95, 90, NULL, 'el-icon-finished', '批量选择', '/example/choose', '/example/choose', 0, 5, 0, NULL, 0, '2021-02-02 20:15:11', '2022-07-20 16:45:57');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (96, 90, NULL, 'el-icon-files', '案卷调整', '/example/document', '/example/document', 0, 6, 0, NULL, 0, '2021-02-02 20:15:03', '2022-07-20 16:45:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (97, 90, NULL, NULL, '预留1', NULL, NULL, 0, 7, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (98, 90, NULL, NULL, '预留2', NULL, NULL, 0, 8, 0, NULL, 1, '2021-02-02 20:15:03', '2022-07-20 16:46:46');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (99, 0, NULL, 'Ticket', '套餐管理', '/subscribe', '', 0, 30, 0, NULL, 0, '2021-02-02 20:15:18', '2024-11-19 23:17:52');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (100, 99, NULL, 'Ticket', '套餐管理', '/subscribe/membership', '/subscribe/membership', 0, 1, 0, NULL, 0, '2021-02-02 20:15:18', '2024-11-21 15:01:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (101, 0, '', 'Handbag', '订单管理', '/order', '', 0, 40, 0, NULL, 0, '2021-02-02 20:15:18', '2024-10-14 00:34:50');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (120, 163, NULL, 'AppstoreAddOutlined', '插件管理', '/templateplugin/plugin', '/templateplugin/plugin', 0, 2, 0, NULL, 0, '2024-10-11 21:21:17', '2024-11-22 16:31:37');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (130, 0, NULL, 'Coin', '数据管理', '/data', NULL, 0, 20, 0, NULL, 0, '2024-10-11 21:24:12', '2024-10-14 00:26:27');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (140, 163, NULL, 'DataAnalysis', '模板管理', '/templateplugin/template', '/templateplugin/template', 0, 1, 0, NULL, 0, '2024-10-11 21:32:11', '2024-11-22 16:31:24');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (150, 0, NULL, 'User', '用户管理', '/customer', NULL, 0, 10, 0, NULL, 0, '2024-10-11 21:34:48', '2024-11-20 01:26:33');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (151, 130, '', 'MostlyCloudy', '数据备份', '/data/databackup', '/data/databackup', 0, 3, 0, '', 0, '2024-10-13 22:50:27', '2024-12-11 06:40:19');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (152, 0, '', 'Upload', '笔记公开', '/release', '', 0, 50, 0, '', 0, '2024-10-13 23:05:22', '2024-10-14 00:57:23');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (153, 130, '', 'MessageBox', '笔记数据管理', '/data/notesdata', '', 0, 1, 0, '', 0, '2024-10-13 23:08:46', '2024-11-01 10:15:30');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (154, 0, '', 'Warning', '隐私政策', '/term', '', 0, 300, 0, '', 0, '2024-10-14 00:12:17', '2024-10-14 00:39:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (155, 154, '', 'ToiletPaper', '隐私政策', '/term/privacypolicy', '', 0, 1, 0, '', 0, '2024-10-14 00:13:26', '2024-11-01 10:17:07');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (156, 154, '', 'Tickets', '条件与条款', '/term/conditionclause', '', 0, 2, 0, '', 0, '2024-10-14 00:14:08', '2024-11-01 10:17:12');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (157, 0, '', 'WarnTriangleFilled', '报告与反馈', '/feedback', '', 0, 60, 0, '', 0, '2024-10-14 00:14:56', '2024-10-14 01:05:46');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (158, 157, '', 'Service', '客服中心', '/feedback/customer', '', 0, 1, 0, '', 0, '2024-10-14 00:16:43', '2024-11-01 10:16:53');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (159, 152, '', 'QuestionFilled', '敏感词检测警告', '/feedback/sensitive', '', 0, 2, 0, '', 0, '2024-10-14 00:17:33', '2024-11-01 10:16:36');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (160, 152, '', 'DocumentRemove', '敏感词库管理', '/feedback/sensitivelibrary', '', 0, 3, 0, '', 0, '2024-10-14 00:24:12', '2024-11-01 10:16:41');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (161, 130, '', 'MessageBox', '文件存储管理', '/data/file', '', 0, 4, 0, '', 0, '2024-10-14 00:30:22', '2024-12-11 06:15:10');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (162, 99, '', 'Warning', '增值服务条款管理', '/subscribe/term', '', 0, 2, 0, '', 0, '2024-10-14 00:48:10', '2024-11-19 23:20:57');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (163, 0, '', 'Orange', '模板管理', '/templateplugin', '', 0, 50, 0, '', 0, '2024-10-14 00:52:18', '2024-12-05 18:51:42');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (164, 152, '', 'Compass', '笔记发布管理', '/release/notespublicly', '', 0, 1, 0, '', 0, '2024-10-14 00:57:59', '2024-11-01 10:16:31');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (165, 157, '', 'InfoFilled', '意见反馈中心', '/feedback/opinion', '', 0, 2, 0, '', 0, '2024-10-14 01:07:58', '2024-11-01 10:16:59');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (166, 101, '', 'GoodsFilled', '订单管理', '/order/orderlist', '/order/orderlist', 0, 1, 0, '', 0, '2024-10-14 01:18:37', '2024-12-05 17:46:40');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (167, 101, '', 'PieChart', '订单统计', '/order/statistics', '/dashboard/analysis', 0, 2, 0, '', 0, '2024-10-14 01:19:47', '2024-11-23 18:12:04');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (168, 150, '', 'Avatar', '用户管理', '/customer/user', '/customer/user', 0, 1, 0, '', 0, '2024-11-01 10:13:21', '2024-11-20 01:26:45');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `authority`, `icon`, `title`, `path`, `component`, `menu_type`, `sort_number`, `hide`, `meta`, `deleted`, `create_time`, `update_time`) VALUES (169, 150, '', 'Aim', '用户统计分析', '/customer/analysis', '/dashboard/monitor', 0, 2, 0, '', 0, '2024-11-01 10:19:51', '2024-11-23 18:11:27');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色标识',
  `role_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名称',
  `comments` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `deleted` int DEFAULT '0' COMMENT '逻辑删除：0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_code`, `role_name`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (1, 'admin', '最高管理员', '最高管理员', 0, '2024-11-09 23:44:17', '2024-11-23 17:31:07');
INSERT INTO `sys_role` (`role_id`, `role_code`, `role_name`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (2, 'senior', '高级管理员', '高级管理员', 0, '2024-11-09 23:45:32', '2024-11-23 17:31:10');
INSERT INTO `sys_role` (`role_id`, `role_code`, `role_name`, `comments`, `deleted`, `create_time`, `update_time`) VALUES (3, 'user', '普通管理员', '普通管理员', 0, '2024-11-09 23:45:32', '2024-11-23 17:30:18');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_menu_id` int NOT NULL AUTO_INCREMENT COMMENT '角色菜单id',
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
INSERT INTO `sys_role_menu` (`role_menu_id`, `role_id`, `menu_id`, `create_time`, `update_time`) VALUES (1532, 2, 153, '2024-11-01 10:51:28', '2024-12-11 06:14:30');
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
  `role_id` int NOT NULL COMMENT '角色id',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `introduction` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '简介',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态：0正常, 1冻结',
  `deleted` int NOT NULL DEFAULT '0' COMMENT '逻辑删除：0否, 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `sys_user_role_id` (`role_id`),
  CONSTRAINT `sys_user_role_id` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`role_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='管理员用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `password`, `nickname`, `phone`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (123, 1, '2405824084@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Yoko', '17877059806', 'SystemDefaultFiles/images/avatar/avatar-admin1.png', '最高权限', 0, 0, '2024-11-09 23:16:54', '2024-12-05 19:03:42');
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `password`, `nickname`, `phone`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (456, 2, 'zhang@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'Izcw', '18269328567', 'SystemDefaultFiles/images/avatar/avatar-admin2.png', '高级权限', 0, 0, '2024-11-09 23:57:30', '2024-12-05 19:03:47');
INSERT INTO `sys_user` (`user_id`, `role_id`, `email`, `password`, `nickname`, `phone`, `avatar`, `introduction`, `status`, `deleted`, `create_time`, `update_time`) VALUES (789, 3, 'zhang2@qq.com', '$argon2i$v=19$m=65536,t=2,p=1$zNCXciWe2RiG16IEJcTDcA$SKaCzqNex1uBZOHO61pGNedZ3ZOfyU4x4WMFvJy+ffc', 'nike', '13472583897', 'SystemDefaultFiles/images/avatar/avatar-admin3.png', '普通管理权限', 0, 0, '2024-11-09 23:57:30', '2024-12-05 19:03:14');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
