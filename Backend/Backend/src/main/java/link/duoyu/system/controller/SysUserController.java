package link.duoyu.system.controller;


import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import link.duoyu.core.config.RoleConstants;
import link.duoyu.core.utils.EmailUtil;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.system.entity.NoteUser;
import link.duoyu.system.entity.SysUser;
import link.duoyu.system.mapper.SysRoleMapper;
import link.duoyu.system.mapper.SysUserMapper;
import link.duoyu.system.service.INoteUserService;
import link.duoyu.system.service.ISysUserService;
import link.duoyu.system.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
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
    private EmailUtil emailUtil; // 发送邮件工具
    @Autowired
    private ISysUserService sysUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务

    /**
     * 登录
     * @param sysUser 管理用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/login")
    public ResponseResult<SaTokenInfo> login(@RequestBody SysUser sysUser) {
        // 检查用户是否已存在
        SysUser existingUser = sysUserService.getOne(new QueryWrapper<SysUser>().eq("email", sysUser.getEmail()));

        if (existingUser != null) {
            // 如果用户已存在，验证密码
            if (passwordService.verifyPassword(sysUser.getPassword(), existingUser.getPassword())) {
                // 第1步 第一个参数设置登录账号id，第二个参数指定是否为[记住我]，当此值为false后，关闭浏览器后再次打开需要重新登录
                StpUtil.login(sysUser.getEmail(), false);

                // 第2步，获取 Token  相关参数
                SaTokenInfo tokenInfo = StpUtil.getTokenInfo();

                // 判断是否为管理员用户，这里假设根据用户的某个字段（比如isAdmin）来判断
                if (existingUser.getSysRoleId() == 1) {
                    StpUtil.getTokenSession().set("role", RoleConstants.ADMIN_ROLE_ADMIN);
                } else if (existingUser.getSysRoleId() == 2) {
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
