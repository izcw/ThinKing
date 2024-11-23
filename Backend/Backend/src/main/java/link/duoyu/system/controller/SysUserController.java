package link.duoyu.system.controller;


import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.note.entity.NoteUser;
import link.duoyu.system.entity.SysRole;
import link.duoyu.system.entity.SysUser;
import link.duoyu.system.mapper.SysRoleMapper;
import link.duoyu.system.mapper.SysUserMapper;
import link.duoyu.system.service.ISysUserService;
import link.duoyu.note.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-11-04
 */
@RestController
@RequestMapping("/system/user")
public class SysUserController {
    @Autowired
    private SysUserMapper sysUserMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate; // Redis 操作
    @Autowired
    private ISysUserService sysUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务
    @Autowired
    private SysRoleMapper sysRoleMapper;


    /**
     * 获取用户列表
     * @return 用户列表
     */
    // @GetMapping("/all")
    // public ResponseResult<List<SysUser>> getAllUsers() {
    //     List<SysUser> list = sysUserMapper.selectList(null);
    //     return ResponseResult.success("查询成功",list);
    // }

    /**
     * 获取分页查询用户列表
     * @param page 当前页码
     * @param limit 每页显示条数
     * @return 分页查询的用户列表
     */
    // @GetMapping("/page")
    // public ResponseResult<Page<SysUser>> page(@RequestParam("page") int page, @RequestParam("limit") int limit) {
    //     // 创建Page对象，设置当前页和每页显示条数
    //     Page<SysUser> sysUserPage = new Page<>(page, limit);
    //
    //     // 执行分页查询
    //     Page<SysUser> pageResult = sysUserService.page(sysUserPage);
    //
    //     // 为每个用户查询角色信息并设置到 roles 属性
    //     for (SysUser sysUser : pageResult.getRecords()) {
    //         // 根据 sysRoleId 查询角色信息
    //         SysRole role = sysRoleMapper.selectByRoleId(sysUser.getRoleId());
    //         List<SysRole> roles = new ArrayList<>();
    //         if (role != null) {
    //             roles.add(role);
    //         }
    //         sysUser.setRoles(roles);
    //     }
    //
    //     // 返回分页结果
    //     return ResponseResult.success("查询成功", pageResult);
    // }

    /**
     * 获取分页查询用户列表
     * @param page 当前页码（从 1 开始）
     * @param limit 每页显示条数
     * @param sort 排序字段（可选）
     * @param order 排序顺序（可选）
     * @return 分页查询的用户列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<SysUser>> page(@RequestParam("page") int page,
                                               @RequestParam("limit") int limit,
                                               @RequestParam(value = "sort", required = false) String sort,
                                               @RequestParam(value = "order", required = false) String order,
                                               @ModelAttribute SysUser sysUser) {
        // 检查页码和每页条数的合法性
        if (page < 1 || limit < 1) {
            return ResponseResult.error("分页参数错误：页码和每页条数必须大于0");
        }

        // 创建分页对象，页码从1开始
        Page<SysUser> sysUserPage = new Page<>(page, limit);

        // 创建查询条件构造器
        QueryWrapper<SysUser> queryWrapper = new QueryWrapper<>();

        // 动态添加查询条件
        if (sysUser.getUserId() != null) {
            queryWrapper.like("user_id", sysUser.getUserId());
        }
        if (sysUser.getEmail() != null && !sysUser.getEmail().isEmpty()) {
            queryWrapper.like("email", sysUser.getEmail());
        }
        if (sysUser.getNickname() != null && !sysUser.getNickname().isEmpty()) {
            queryWrapper.like("nickname", sysUser.getNickname());
        }
        if (sysUser.getStatus() != null) {
            queryWrapper.eq("status", sysUser.getStatus());
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
        Page<SysUser> pageResult;

        try {
            pageResult = sysUserService.page(sysUserPage, queryWrapper);
            // 为每个用户查询角色信息并设置到 roles 属性
            for (SysUser sysUserRoles : pageResult.getRecords()) {
                // 根据 sysRoleId 查询角色信息
                SysRole role = sysRoleMapper.selectByRoleId(sysUserRoles.getRoleId());
                List<SysRole> roles = new ArrayList<>();
                if (role != null) {
                    roles.add(role);
                }
                sysUserRoles.setRoles(roles);
            }
        } catch (Exception e) {
            return ResponseResult.error("分页查询失败：" + e.getMessage());
        }

        // 返回分页结果
        return ResponseResult.success("查询成功", pageResult);
    }


    /**
     * 根据ID获取用户信息
     * @param id 用户ID
     * @return 用户信息
     */
    @GetMapping("/{id}")
    public ResponseResult<SysUser> getUserById(@PathVariable Integer id) { // 改为 Integer
        // 获取当前登录用户的 ID
        String userId = (String) StpUtil.getLoginId();
        System.out.println("用户ID: " + userId);

        SysUser sysUser = sysUserMapper.selectById(userId);
        if (sysUser == null) {
            return ResponseResult.fail("用户未找到");
        }
        return ResponseResult.success(sysUser);
    }


}
