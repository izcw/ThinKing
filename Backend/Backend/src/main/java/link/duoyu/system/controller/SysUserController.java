package link.duoyu.system.controller;


import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import link.duoyu.core.web.ResponseResult;
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
    @GetMapping("/all")
    public ResponseResult<List<SysUser>> getAllUsers() {
        List<SysUser> list = sysUserMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }

    /**
     * 获取分页查询用户列表
     * @param page 当前页码
     * @param limit 每页显示条数
     * @return 分页查询的用户列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<SysUser>> page(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        // 创建Page对象，设置当前页和每页显示条数
        Page<SysUser> sysUserPage = new Page<>(page, limit);

        // 执行分页查询
        Page<SysUser> pageResult = sysUserService.page(sysUserPage);

        // 为每个用户查询角色信息并设置到 roles 属性
        for (SysUser sysUser : pageResult.getRecords()) {
            // 根据 sysRoleId 查询角色信息
            SysRole role = sysRoleMapper.selectByRoleId(sysUser.getRoleId());
            List<SysRole> roles = new ArrayList<>();
            if (role != null) {
                roles.add(role);
            }
            sysUser.setRoles(roles);
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
