package work.zhangchengwei.system.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import jakarta.servlet.http.HttpServletRequest;
import work.zhangchengwei.common.service.CaptchaService;
import work.zhangchengwei.core.config.RoleConstants;
import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.note.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.system.entity.SysMenu;
import work.zhangchengwei.system.entity.SysRole;
import work.zhangchengwei.system.entity.SysRoleMenu;
import work.zhangchengwei.system.entity.SysUser;
import work.zhangchengwei.system.mapper.SysMenuMapper;
import work.zhangchengwei.system.mapper.SysRoleMapper;
import work.zhangchengwei.system.mapper.SysRoleMenuMapper;
import work.zhangchengwei.system.mapper.SysUserMapper;
import work.zhangchengwei.system.service.ISysUserService;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 后台登录认证控制器
 *
 * @author Izcw
 * @Date 2024/11/11 下午7:07
 */
@RestController
@RequestMapping("/system")
public class SysMainController {
    @Autowired
    private SysUserMapper sysUserMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate; // Redis 操作
    @Autowired
    private ISysUserService sysUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务
    @Autowired
    private CaptchaService captchaService;

    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Autowired
    private SysMenuMapper sysMenuMapper;
    @Autowired
    private SysRoleMenuMapper sysRoleMenuMapper;

    /**
     * 获取登录用户信息
     * @return 用户信息
     */
    @GetMapping("/auth/user")
    public ResponseResult<SysUser> getUserById() {
        // 获取当前登录用户的 ID
        String userId = StpUtil.getLoginIdAsString();

        // 根据用户 ID 查找用户
        SysUser sysUser = sysUserMapper.selectById(userId);
        if (sysUser == null) {
            return ResponseResult.fail("用户未找到");
        }

        // 根据 role_id 查询角色信息
        SysRole role = sysRoleMapper.selectByRoleId(sysUser.getRoleId());
        List<SysRole> roles = new ArrayList<>();
        if (role != null) {
            roles.add(role);
        }
        sysUser.setRoles(roles);

        // 根据用户的 role_id 查询 sys_role_menu 中对应的菜单信息
        List<SysRoleMenu> roleMenus = sysRoleMenuMapper.selectByRoleId(sysUser.getRoleId());
        List<Integer> menuIds = roleMenus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList());

        // 根据 menu_id 查询 sys_menu 表
        List<SysMenu> menus = sysMenuMapper.selectByMenuIds(menuIds);

        // 按 sortNumber 排序菜单列表
        menus.sort(Comparator.comparingInt(SysMenu::getSortNumber));

        // 将排序后的菜单列表设置到用户信息中
        sysUser.setAuthorities(menus);

        return ResponseResult.success(sysUser);
    }


    /**
     * 登录
     * @param sysUser 管理用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/login")
    public ResponseResult<SaTokenInfo> login(@RequestBody SysUser sysUser,@RequestParam("verifycode") String verifycode, HttpServletRequest request) {
        // 验证验证码
//        System.out.println(verifycode);
//        if(verifycode == null || verifycode.isEmpty()) {
//            return ResponseResult.fail("验证码不能为空!");
//        }
//        // 调用 CaptchaService 进行验证码验证
//        boolean isCaptchaValid = captchaService.validateCaptcha(verifycode, request);
//
//        // 如果验证码无效，返回失败
//        if (!isCaptchaValid) {
//            return ResponseResult.fail("验证码错误或已失效，请重新获取!");
//        }
//        // 验证通过后清除验证码的尝试次数
//        captchaService.clearCaptchaAttempts(request);


        // 检查用户是否已存在
        SysUser existingUser = sysUserService.getOne(new QueryWrapper<SysUser>().eq("email", sysUser.getEmail()));

        if (existingUser != null) {
            // 如果用户已存在

            // 验证密码
            if (passwordService.verifyPassword(sysUser.getPassword(), existingUser.getPassword())) {
                // 第1步 设置登录账号id
                StpUtil.login(existingUser.getUserId());

                // 第2步，获取 Token  相关参数
                SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

                // 判断是否为管理员用户，这里假设根据用户的某个字段（比如isAdmin）来判断
                if (existingUser.getRoleId() == 1) {
                    StpUtil.getTokenSession().set("role", RoleConstants.ADMIN_ROLE_ADMIN);
                } else if (existingUser.getRoleId() == 2) {
                    StpUtil.getTokenSession().set("role", RoleConstants.ADMIN_ROLE_SENIOR);
                }else if (existingUser.getRoleId() == 3) {
                    StpUtil.getTokenSession().set("role", RoleConstants.ADMIN_ROLE_USER);
                }

                // 密码验证成功，返回用户信息
                return ResponseResult.success("登录成功", tokenInfo);
            } else {
                // 密码验证失败
                return ResponseResult.fail("密码错误");
            }
        } else {
            return ResponseResult.unauthorized("该用户未注册！");
        }
    }

}