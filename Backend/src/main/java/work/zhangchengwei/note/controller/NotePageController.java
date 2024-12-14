package work.zhangchengwei.note.controller;


import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.note.entity.NotePage;
import work.zhangchengwei.note.entity.NoteSpace;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.mapper.NotePageMapper;
import work.zhangchengwei.note.service.INotePageService;
import work.zhangchengwei.note.service.INoteSpaceService;
import work.zhangchengwei.system.entity.SysUser;

import java.util.List;

/**
 * <p>
 * 页面 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-12-06
 */
@RestController
@RequestMapping("/note/page")
public class NotePageController {
    @Autowired
    private INotePageService notePageService;
    @Autowired
    private NotePageMapper notePageMapper;


    /**
     * 获取空间下的所有笔记
     * @return 笔记列表
     */
    @GetMapping("/spacePage")
    public ResponseResult<List<NotePage>> getSpacePage(@RequestParam("spaceId") String spaceId) {
        // 获取登录用户的 userId 字符串
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);

        // 创建 QueryWrapper 并设置查询条件
        QueryWrapper<NotePage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("space_id", spaceId);

        // 默认过滤逻辑删除字段
        queryWrapper.eq("deleted", 0);

        // 执行查询，假设你有一个 noteSpaceService 可以执行数据库查询
        List<NotePage> list = notePageService.list(queryWrapper);

        // 返回查询结果
//        if (list != null && !list.isEmpty()) {
            return ResponseResult.success("查询成功", list);
//        } else {
//            return ResponseResult.error("没有找到数据");
//        }
    }

    /**
     * 根据ID获取页面
     * @param id 笔记ID
     * @return 笔记
     */
    @GetMapping("/{id}")
    public ResponseResult<NotePage> getPageById(@PathVariable String id) {
        NotePage notePage = notePageMapper.selectById(id);
        if (notePage == null) {
            return ResponseResult.fail("未找到该笔记");
        }
        return ResponseResult.success(notePage);
    }

    /**
     * 根据ID获取页面(分享的)
     * @param id 笔记ID
     * @return 笔记
     */
    @GetMapping("/sharepage/{id}")
    public ResponseResult<NotePage> getSharePageById(@PathVariable String id) {
        NotePage notePage = notePageMapper.selectById(id);
        if (notePage == null) {
            return ResponseResult.fail("未找到该笔记");
        }
        return ResponseResult.success(notePage);
    }

    /**
     * 添加笔记
     * @return
     */
    @PostMapping("/add")
    public ResponseResult<String> add(@RequestBody NotePage notePage) {
        // 获取当前登录用户的 ID
        String userIdStr = StpUtil.getLoginIdAsString();
        System.out.println(userIdStr);
        // 将字符串转换为长整型
        Long userId = Long.parseLong(userIdStr);
        notePage.setUserId(userId);

        String jsonContent = "{\n" +
                "    \"type\": \"doc\",\n" +
                "    \"content\": [\n" +
                "        {\n" +
                "            \"type\": \"paragraph\"\n" +
                "        }\n" +
                "    ]\n" +
                "}";
        // 使用 Jackson 的 ObjectMapper 将 String 转换为 JsonNode
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(jsonContent);
            notePage.setContent(jsonNode);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("保存失败：" + e.getMessage());
        }

        boolean inserted = notePageService.save(notePage); // 保存
        if (inserted) {
            return ResponseResult.success("添加成功",null);
        } else {
            return ResponseResult.fail("添加失败");
        }
    }

    /**
     * 更新信息
     * @return 更新结果
     */
    @PutMapping("/update")
    public ResponseResult<NotePage> update(@RequestBody NotePage notePage) {
        // 执行更新操作，传入实体对象和更新条件
        boolean updated = notePageMapper.updateById(notePage) > 0;

        if (updated) {
            // 更新成功后，重新从数据库中查询完整的记录
            NotePage updatedNotePage = notePageMapper.selectById(notePage.getPageId());
            return ResponseResult.success("修改成功", updatedNotePage);
        } else {
            // 更新失败，返回失败消息
            return ResponseResult.error("修改失败");
        }
    }


    /**
     * 逻辑删除或恢复
     * @param pageId 页面ID
     * @param status 1 为删除，0 为恢复
     * @return 结果
     */
    @PutMapping("/recycle")
    public ResponseResult<String> recycle(@RequestParam("pageId") String pageId, @RequestParam("status") int status) {
        int updated = notePageMapper.updateDeletedByPageId(pageId, status);

        String info = "";
        if(status == 1){
            info = "删除";
        }else {
            info = "恢复";
        }

        if (updated > 0) {
            return ResponseResult.success(info+"成功",null);
        } else {
            // 更新失败，返回失败消息
            return ResponseResult.error(info+"失败");
        }
    }


//    递归删子孙
//    @PutMapping("/recycle")
//    public ResponseResult<String> recycle(@RequestParam("pageId") String pageId, @RequestParam("status") int status) {
//        try {
//            // 根据 status 判断是删除还是恢复
//            int updatedCount = notePageMapper.updateDeletedByPageId(pageId, status);
//            if (updatedCount > 0) {
//                // 如果更新成功，递归更新子节点的 deleted 状态
//                updateChildPagesDeleted(pageId, status);
//                String action = (status == 1) ? "删除" : "恢复";
//                return ResponseResult.success(action + "成功，共" + action + " " + pageId + " 及其子页面", null);
//            } else {
//                return ResponseResult.error("操作失败");
//            }
//        } catch (Exception e) {
//            return ResponseResult.error("操作异常: " + e.getMessage());
//        }
//    }


    /**
     * 递归更新子孙节点的 deleted 状态
     * @param parentId 父节点 ID
     * @param status 1 为删除，0 为恢复
     */
    private void updateChildPagesDeleted(String parentId, int status) {
        try {
            List<String> childPageIds = notePageMapper.findChildPagesByParentId(parentId);
            if (childPageIds != null && !childPageIds.isEmpty()) {
                for (String childPageId : childPageIds) {
                    notePageMapper.updateDeletedByPageId(childPageId, status);
                    updateChildPagesDeleted(childPageId, status);
                }
            }
        } catch (Exception e) {
            // 捕获并记录异常
            System.err.println("更新子节点删除状态失败: " + e.getMessage());
        }
    }


    /**
     * 彻底删除页面及其所有子页面
     * @param pageId 页面ID
     * @return 结果
     */
    @DeleteMapping("/delete")
    public ResponseResult<String> delete(@RequestParam("pageId") String pageId) {
        try {
            // 先删除当前页面
            int deletedCount = notePageMapper.deletePageByPageId(pageId);
            if (deletedCount > 0) {
                // 如果当前页面删除成功，递归删除子页面
                deleteChildPages(pageId);
                return ResponseResult.success("删除成功", null);
            } else {
                return ResponseResult.error("删除失败");
            }
        } catch (Exception e) {
            return ResponseResult.error("删除操作异常: " + e.getMessage());
        }
    }

    /**
     * 递归删除子页面
     * @param parentId 父节点 ID
     */
    private void deleteChildPages(String parentId) {
        try {
            List<String> childPageIds = notePageMapper.findChildPagesByParentId(parentId);
            if (childPageIds != null && !childPageIds.isEmpty()) {
                for (String childPageId : childPageIds) {
                    notePageMapper.deletePageByPageId(childPageId);
                    deleteChildPages(childPageId);
                }
            }
        } catch (Exception e) {
            // 捕获并记录异常
            System.err.println("删除子节点失败: " + e.getMessage());
        }
    }


//    /**
//     * 删除页面(彻底删除)
//     * @param pageId 要删除ID
//     * @return 删除结果
//     */
//    @DeleteMapping("/delete")
//    public ResponseResult<String> deleteById(@RequestParam("pageId") String pageId) {
//        boolean deleted = notePageMapper.deleteById(pageId) > 0;
//        if (deleted) {
//            return ResponseResult.success("删除成功",null);
//        } else {
//            return ResponseResult.error("删除失败，未找到对应记录");
//        }
//    }


    /**
     * 获取空间下的所有笔记
     * @return 笔记列表
     */
    @GetMapping("/RecyclePage")
    public ResponseResult<List<NotePage>> getRecyclePage() {
        // 获取登录用户的 userId 字符串
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);

        // 创建 QueryWrapper 并设置查询条件
        QueryWrapper<NotePage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
//        queryWrapper.eq("parent_id", 0);

        // 默认过滤逻辑删除字段
        queryWrapper.eq("deleted", 1);

        // 执行查询，假设你有一个 noteSpaceService 可以执行数据库查询
        List<NotePage> list = notePageService.list(queryWrapper);

        // 返回查询结果
        return ResponseResult.success("查询成功", list);
    }

}
