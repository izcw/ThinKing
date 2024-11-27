package work.zhangchengwei.note.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import work.zhangchengwei.common.service.FileService;
import work.zhangchengwei.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.note.entity.NoteUser;
import work.zhangchengwei.note.mapper.NoteUserMapper;
import work.zhangchengwei.note.param.UpdateUserRequest;
import work.zhangchengwei.note.service.INoteUserService;
import work.zhangchengwei.note.service.PasswordService;

import java.util.Collections;
import java.util.List;

/**
 * <p>
 * 客户 前端控制器
 * </p>
 * @Author：izcw
 * @Date：2024/11/04
 * @Description：处理用户相关请求，包括增删改查。
 */
@RestController
@RequestMapping("/note/user")
public class NoteUserController {
    @Autowired
    private NoteUserMapper noteUserMapper;
    @Autowired
    private INoteUserService noteUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务
    @Autowired
    private FileService fileService;

    /**
     * 获取分页查询用户列表
     * @param page 当前页码（从 1 开始）
     * @param limit 每页显示条数
     * @param sort 排序字段（可选）
     * @param order 排序顺序（可选）
     * @return 分页查询的用户列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<NoteUser>> page(@RequestParam("page") int page,
                                               @RequestParam("limit") int limit,
                                               @RequestParam(value = "sort", required = false) String sort,
                                               @RequestParam(value = "order", required = false) String order,
                                               @ModelAttribute NoteUser noteUser) {
        // 检查页码和每页条数的合法性
        if (page < 1 || limit < 1) {
            return ResponseResult.error("分页参数错误：页码和每页条数必须大于0");
        }

        // 创建分页对象，页码从1开始
        Page<NoteUser> noteUserPage = new Page<>(page, limit);

        // 创建查询条件构造器
        QueryWrapper<NoteUser> queryWrapper = new QueryWrapper<>();

        // 动态添加查询条件
        if (noteUser.getUserId() != null) {
            queryWrapper.like("user_id", noteUser.getUserId());
        }
        if (noteUser.getEmail() != null && !noteUser.getEmail().isEmpty()) {
            queryWrapper.like("email", noteUser.getEmail());
        }
        if (noteUser.getNickname() != null && !noteUser.getNickname().isEmpty()) {
            queryWrapper.like("nickname", noteUser.getNickname());
        }
        if (noteUser.getStatus() != null) {
            queryWrapper.eq("status", noteUser.getStatus());
        }

        // 动态添加排序条件
        if (sort != null && !sort.isEmpty()) {
            if ("asc".equalsIgnoreCase(order)) {
                queryWrapper.orderByAsc(sort); // 升序
            } else if ("desc".equalsIgnoreCase(order)) {
                queryWrapper.orderByDesc(sort); // 降序
            } else {
                return ResponseResult.error("排序顺序参数错误：只允许 asc 或 desc");
            }
        } else {
            // 如果没有传递 sort 和 order，使用默认排序
            queryWrapper.orderByAsc("create_time"); // 默认为按创建时间升序排序
        }

        // 执行分页查询
        Page<NoteUser> pageResult;
        try {
            pageResult = noteUserService.page(noteUserPage, queryWrapper);
        } catch (Exception e) {
            return ResponseResult.error("分页查询失败：" + e.getMessage());
        }

        // 返回分页结果
        return ResponseResult.success("查询成功", pageResult);
    }


    /**
     * 添加用户
     * @return
     */
    @PostMapping("/add")
    public ResponseResult<String> add(@RequestBody NoteUser noteUser) {
        // 检查用户是否已存在
        NoteUser existingUser = noteUserService.getOne(new QueryWrapper<NoteUser>().eq("email", noteUser.getEmail()));
        if (existingUser != null) {
            return ResponseResult.created("该用户已注册");
        } else {
            // 如果用户不存在，注册新用户
            noteUser.setPassword(passwordService.hashPassword(noteUser.getPassword())); // 散列密码
            boolean inserted = noteUserService.save(noteUser); // 保存新用户
            if (inserted) {
                return ResponseResult.success("添加成功",null);
            } else {
                return ResponseResult.fail("添加失败");
            }
        }
    }

    /**
     * 更新用户信息
     * @param avatar 头像
     * @param email 邮箱
     * @param nickname 昵称
     * @param status 状态
     * @return 更新结果
     */
    @PutMapping("/update")
    public ResponseResult<NoteUser> update(@RequestBody UpdateUserRequest request) {
        Long userId = request.getUserId();
        String avatar = request.getAvatar();
        String email = request.getEmail();
        String nickname = request.getNickname();
        String status = request.getStatus();


        // 使用 UpdateWrapper 来构建条件和更新字段
        UpdateWrapper<NoteUser> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("user_id", userId);  // 根据 userId 查找要更新的用户

        // 如果传入了某些字段，添加对应的更新条件
        if (avatar != null) {
            updateWrapper.set("avatar", avatar);
        }
        if (email != null) {
            updateWrapper.set("email", email);
        }
        if (nickname != null) {
            updateWrapper.set("nickname", nickname);
        }
        if (status != null) {
            updateWrapper.set("status", status);
        }

        // 执行更新操作，返回是否成功
        boolean updated = noteUserMapper.update(null, updateWrapper) > 0;

        if (updated) {
            // 更新成功，返回更新后的用户信息
            NoteUser updatedUser = noteUserMapper.selectById(userId);
            return ResponseResult.success("修改成功", updatedUser);
        } else {
            // 更新失败，返回失败消息
            return ResponseResult.error("修改失败");
        }
    }

    /**
     * 删除用户及其头像
     *
     * @param noteUser 包含用户ID和头像路径的对象
     * @return 响应结果，包含操作状态
     */
    @PostMapping("/deleteUser")
    public ResponseResult<Void> deleteUser(@RequestBody NoteUser noteUser) {
        // 打印日志，方便调试
        System.out.println("开始删除用户，用户信息: " + noteUser);

        // 检查用户ID是否有效
        String userId = String.valueOf(noteUser.getUserId());
        String avatar = noteUser.getAvatar();
        if (userId == null || userId.trim().isEmpty()) {
            return ResponseResult.error("用户ID不能为空");
        }

        // 删除用户记录
        int rowsAffected = noteUserMapper.deleteById(userId);

        // 检查删除用户的结果
        if (rowsAffected > 0) {
            System.out.println("用户删除成功，用户ID: " + userId);

            // 如果提供了头像路径，调用 FileService 删除文件
            if (avatar != null && !avatar.trim().isEmpty()) {
                ResponseResult<List<String>> deleteResult = fileService.deleteFiles(Collections.singletonList(avatar));
                if (deleteResult.getCode() != 200) {
                    System.out.println("头像删除失败: " + deleteResult.getMessage());
                } else {
                    System.out.println("头像删除成功，路径: " + avatar);
                }
            }

            return ResponseResult.success("删除成功", null);
        } else {
            System.out.println("用户删除失败，用户ID: " + userId + " 不存在");
            return ResponseResult.error("用户删除失败，用户ID不存在");
        }
    }


    /**
     * 批量删除用户及其头像
     *
     * @param noteUsers 包含多个用户ID和头像路径的对象列表
     * @return 响应结果，包含操作状态
     */
    @PostMapping("/batchDeleteUsers")
    public ResponseResult<Void> batchDeleteUsers(@RequestBody List<NoteUser> noteUsers) {
        // 打印日志，方便调试
        System.out.println("开始批量删除用户，用户信息列表: " + noteUsers);

        // 检查用户列表是否为空
        if (noteUsers == null || noteUsers.isEmpty()) {
            return ResponseResult.error("用户列表不能为空");
        }

        // 遍历用户列表，逐一删除
        for (NoteUser noteUser : noteUsers) {
            String userId = String.valueOf(noteUser.getUserId());
            String avatar = noteUser.getAvatar();

            if (userId == null || userId.trim().isEmpty()) {
                System.out.println("用户ID为空，跳过此用户");
                continue; // 如果用户ID为空，则跳过此用户
            }

            // 删除用户记录
            int rowsAffected = noteUserMapper.deleteById(userId);

            // 检查删除用户的结果
            if (rowsAffected > 0) {
                System.out.print("用户删除成功，用户ID: " + userId+"；");

                // 如果提供了头像路径，调用 FileService 删除文件
                if (avatar != null && !avatar.trim().isEmpty()) {
                    ResponseResult<List<String>> deleteResult = fileService.deleteFiles(Collections.singletonList(avatar));
                    if (deleteResult.getCode() != 200) {
                        System.out.println("头像删除失败，用户ID: " + userId + "，路径: " + avatar);
                    } else {
                        System.out.println("头像删除成功，路径: " + avatar);
                    }
                }
            } else {
                System.out.println("用户删除失败，用户ID: " + userId + " 不存在");
            }
        }

        // 返回成功响应
        return ResponseResult.success("批量删除成功", null);
    }

}
