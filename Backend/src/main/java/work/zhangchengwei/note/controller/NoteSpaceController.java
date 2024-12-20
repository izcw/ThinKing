package work.zhangchengwei.note.controller;


import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.note.entity.NotePage;
import work.zhangchengwei.note.entity.NoteSpace;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.mapper.NoteSpaceMapper;
import work.zhangchengwei.note.mapper.NoteSubscribeMapper;
import work.zhangchengwei.note.mapper.NoteUserMapper;
import work.zhangchengwei.note.service.INotePageService;
import work.zhangchengwei.note.service.INoteSpaceService;

import java.util.List;

/**
 * <p>
 * 笔记空间 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
@RestController
@RequestMapping("/note/space")
public class NoteSpaceController {
    @Autowired
    private INoteSpaceService noteSpaceService;
    @Autowired
    private NoteSpaceMapper noteSpaceMapper;
    @Autowired
    private INotePageService notePageService;

    /**
     * 获取用户列表
     * @return 用户列表
     */
    @GetMapping("/all")
    public ResponseResult<List<NoteSpace>> getAllUsers() {
        // 获取登录用户的 userId 字符串
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);

        // 创建 QueryWrapper 并设置查询条件
        QueryWrapper<NoteSpace> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);

        // 执行查询，假设你有一个 noteSpaceService 可以执行数据库查询
        List<NoteSpace> list = noteSpaceService.list(queryWrapper);

        // 返回查询结果
        if (list != null && !list.isEmpty()) {
            return ResponseResult.success("查询成功", list);
        } else {
            return ResponseResult.error("没有找到数据");
        }
    }


    /**
     * 获取默认的空间
     * @return 用户默认的空间
     */
    @GetMapping("/defaultSpace")
    public ResponseResult<NoteSpace> getDefaultSpace() {
        // 获取当前登录用户的 ID
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);

        QueryWrapper<NoteSpace> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(NoteSpace::getUserId, userId)
                .eq(NoteSpace::getDefaultSpace, 0);
        queryWrapper.last("LIMIT 1");

        System.out.println(queryWrapper);

        // 执行查询并获取默认空间
        NoteSpace defaultNoteSpace = noteSpaceMapper.selectOne(queryWrapper);
        return ResponseResult.success("查询成功", defaultNoteSpace);
    }

    /**
     * 添加空间
     * @return
     */
    @PostMapping("/add")
    public ResponseResult<String> add(@RequestBody NoteSpace noteSpace) {
        // 获取当前登录用户的 ID
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);
        noteSpace.setUserId(userId);

        boolean inserted = noteSpaceService.save(noteSpace); // 保存
        if (inserted) {
            return ResponseResult.success("添加成功",null);
        } else {
            return ResponseResult.fail("添加失败");
        }
    }

    /**
     * 改变默认空间
     * @return
     */
    @PutMapping("/defaultspace")
    public ResponseResult<String> changedefault(@RequestParam("spaceId") String spaceId) {
        // 获取当前登录用户的 ID
        String userIdStr = StpUtil.getLoginIdAsString();
        Long userId = Long.parseLong(userIdStr);

        try {
            // 检查当前用户是否有默认空间
            UpdateWrapper<NoteSpace> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("user_id", userId)
                    .eq("default_space", 0);
            Long count = noteSpaceMapper.selectCount(updateWrapper);

            if (count > 0) {
                // 更新现有默认空间为非默认
                noteSpaceMapper.update(null, new UpdateWrapper<NoteSpace>()
                        .eq("user_id", userId)
                        .eq("default_space", 0)
                        .set("default_space", 1));
            }

            // 设置新的默认空间
            int result = noteSpaceMapper.update(null, new UpdateWrapper<NoteSpace>()
                    .eq("space_id", spaceId)
                    .set("default_space", 0));

            if (result > 0) {
                return ResponseResult.success("修改成功",null);
            } else {
                return ResponseResult.fail("修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("操作异常");
        }
    }

    /**
     * 修改空间
     * @return
     */
    @PutMapping("/update")
    public ResponseResult<String> update(@RequestBody NoteSpace noteSpace) {
        // 执行更新操作，传入实体对象和更新条件
        boolean updated = noteSpaceMapper.updateById(noteSpace) > 0;

        if (updated) {
            // 更新成功，直接返回传入的实体对象即可，因为 updateById 已更新
            return ResponseResult.success("修改成功", null);
        } else {
            // 更新失败，返回失败消息
            return ResponseResult.error("修改失败");
        }
    }


    /**
     * 删除空间
     * @param spaceId 要删除ID
     * @return 删除结果
     */
    @DeleteMapping("/delete")
    public ResponseResult<String> deleteById(@RequestParam("spaceId") String spaceId) {
        // 检查是否为默认空间
        QueryWrapper<NoteSpace> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("space_id", spaceId)
                .eq("default_space", 0); // 假设0表示默认空间
        Long count = noteSpaceMapper.selectCount(queryWrapper);


        // 如果该空间下有笔记，则也不能删除
        QueryWrapper<NotePage> queryPageWrapper = new QueryWrapper<>();
        queryPageWrapper.eq("space_id", spaceId);

        // 执行查询，假设你有一个 noteSpaceService 可以执行数据库查询
        List<NotePage> list = notePageService.list(queryPageWrapper);
        System.out.println(list+"list");

        if (count > 0) {
            // 是默认空间，不允许删除
            return ResponseResult.error("删除失败，不能删除默认空间");
        } else if (list != null && !list.isEmpty()) {
            return ResponseResult.error("删除失败，该空间下有笔记，若要删除此空间，必须先删除该空间的所有笔记，以及回收站中的笔记");
        }

        // 不是默认空间，执行删除操作
        boolean deleted = noteSpaceMapper.deleteById(spaceId) > 0;
        if (deleted) {
            return ResponseResult.success("删除成功",null);
        } else {
            return ResponseResult.error("删除失败，未找到对应记录");
        }
    }
}
