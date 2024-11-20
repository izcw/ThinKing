package link.duoyu.note.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.models.auth.In;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.note.entity.NoteUser;
import link.duoyu.note.mapper.NoteUserMapper;
import link.duoyu.note.param.UpdateUserRequest;
import link.duoyu.note.service.INoteUserService;
import link.duoyu.note.service.PasswordService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

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
     * @param avatar 头像（可选）
     * @param email 邮箱（可选）
     * @param nickname 昵称（可选）
     * @return 更新结果
     */
    @PutMapping("/update")
    public ResponseResult<NoteUser> update(@RequestBody UpdateUserRequest request) {
        Long userId = request.getUserId();
        String avatar = request.getAvatar();
        String email = request.getEmail();
        String nickname = request.getNickname();
        String status = request.getStatus();

        // 打印调试信息
        System.out.println(userId + " " + avatar + " " + email + " " + nickname);

        // 使用 UpdateWrapper 来构建条件和更新字段
        UpdateWrapper<NoteUser> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("user_id", userId);  // 根据 userId 查找要更新的用户
        System.out.println(updateWrapper.getSqlSegment());  // 输出生成的 SQL

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
     * 上传用户头像
     * @return
     */
    @Value("${custom.warehouse.path}") // 从配置文件获取上传路径
    private String File_Warehouse_Path;

    @Value("${custom.agreement-host}") // 协议+主机
    private String agreementHost;

    @Value("${server.port}") // 从配置文件获取服务端口
    private int serverPort;



    @PostMapping("/upload-avatar")
    public ResponseResult<String> uploadAvatar(@RequestParam("avatar") MultipartFile file) {
        String uploadTo_Path = "images/avatar/users/"; // 具体上传到基础路径哪

        if (file.isEmpty()) {
            return ResponseResult.error("上传失败，文件为空");
        }

        try {
            // 确保外部目录存在
            File uploadDir = new File(File_Warehouse_Path+uploadTo_Path);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename != null ? originalFilename.substring(originalFilename.lastIndexOf(".")) : "";
            String fileName = UUID.randomUUID() + extension;
            File dest = new File(uploadDir, fileName);

            // 保存文件到外部路径
            file.transferTo(dest);

            // 构造文件访问的 URL，动态获取主机地址和端口
            String imageUrl = "/file_warehouse/"+uploadTo_Path + fileName;
            return ResponseResult.success("上传成功",imageUrl);
        } catch (IOException e) {
            return ResponseResult.error("上传失败: " + e.getMessage());
        }
    }



    /**
     * 获取用户列表
     * @return 用户列表
     */
    // @GetMapping("/all")
    // public ResponseResult<List<NoteUser>> getAllUsers() {
    //     List<NoteUser> list = noteUserMapper.selectList(null);
    //     return ResponseResult.success("查询成功",list);
    // }



    /**
     * 根据ID获取用户信息
     * @param id 用户ID
     * @return 用户信息
     */
    // @GetMapping("/{id}")
    // public ResponseResult<NoteUser> getUserById(@PathVariable Integer id) { // 改为 Integer
    //     NoteUser user = noteUserMapper.selectById(id);
    //     if (user == null) {
    //         return ResponseResult.fail("用户未找到");
    //     }
    //     return ResponseResult.success(user);
    // }





    /**
     * 删除用户
     * @param id 用户ID
     * @return 响应结果
     */
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteUser(@PathVariable Integer id) { // 改为 Integer
        noteUserMapper.deleteById(id);
        return ResponseResult.success(); // 返回成功状态
    }

}
