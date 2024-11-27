package work.zhangchengwei.note.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import jakarta.servlet.http.HttpServletRequest;
import work.zhangchengwei.core.utils.EmailUtil;
import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.system.entity.VerifyEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.note.entity.NoteUser;
import work.zhangchengwei.note.service.INoteUserService;
import work.zhangchengwei.note.service.PasswordService;

import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * 前台登录认证控制器
 *
 * @author Izcw
 * @Date 2024/11/18 下午9:26
 */

@RestController
@RequestMapping("/note")
public class NoteMainController {
    @Autowired
    private RedisTemplate<String, String> redisTemplate; // Redis 操作
    @Autowired
    private EmailUtil emailUtil; // 发送邮件工具
    @Autowired
    private INoteUserService noteUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务

    /**
     * 登录
     * @param noteUser 用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/login")
    public ResponseResult<SaTokenInfo> login(@RequestBody NoteUser noteUser) {
        // 检查用户是否已存在
        NoteUser existingUser = noteUserService.getOne(new QueryWrapper<NoteUser>().eq("email", noteUser.getEmail()));

        if (existingUser != null) {
            // 如果用户已存在，验证密码
            if (passwordService.verifyPassword(noteUser.getPassword(), existingUser.getPassword())) {
                // 第1步 设置登录账号id
                StpUtil.login(noteUser.getEmail());

                // 第2步，获取 Token  相关参数
                SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
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

    @PostMapping("/islogin")
    public String islogin(@RequestBody NoteUser noteUser , HttpServletRequest request){
        String token = request.getHeader("Authorization");
        System.out.println(token);
        return "当前会话是否登录：" + StpUtil.isLogin(noteUser.getEmail());
    }

    /**
     * 注销接口，使用 Sa-Token 实现用户注销
     */
    @PostMapping("/logout")
    public String logout() {
        StpUtil.logout();
        return "注销成功";
    }

    /**
     * 注册
     * @param noteUser 用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/register")
    public ResponseResult<NoteUser> Register(@RequestBody NoteUser noteUser) {
        // 检查用户是否已存在
        NoteUser existingUser = noteUserService.getOne(new QueryWrapper<NoteUser>().eq("email", noteUser.getEmail()));
        System.out.println(existingUser+"检查用户是否已存在");
        if (existingUser != null) {
            return ResponseResult.created("该用户已注册，请登录", existingUser);
        } else {
            // 如果用户不存在，注册新用户

            noteUser.setPassword(passwordService.hashPassword(noteUser.getPassword())); // 散列密码
            boolean inserted = noteUserService.save(noteUser); // 保存新用户
            System.out.println(inserted);
            if (inserted) {
                return ResponseResult.success("注册成功",null);
            } else {
                return ResponseResult.fail("注册失败");
            }
        }
    }


    /**
     * 生成并发送 6 位数的邮箱验证码
     *
     * @param email 用户邮箱
     * @return 响应结果
     */
    @GetMapping("/sendVerificationCode")
    public ResponseResult<String> sendVerificationCode(@RequestParam String email) {
        // 生成 6 位数字验证码
        String verificationCode = generateVerificationCode();

        // 将验证码存入 Redis，设置过期时间 10 分钟
        redisTemplate.opsForValue().set("VERIFY_CODE_" + email, verificationCode, 10, TimeUnit.MINUTES);

        // 发送验证码到用户邮箱
        try {
            String title = "注册【NexNote】 验证码 "+verificationCode;
            String content = "【NexNote】您的注册验证码是：" + verificationCode+"，十分钟内有效，请不要透露给他人。";
            emailUtil.sendMail(email, title, content);
            return ResponseResult.success("验证码已发送到您的邮箱",null);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("发送验证码失败：" + e.getMessage());
        }
    }

    /**
     * 校验邮箱验证码
     *
     * @param verifyEmail            验证用户邮箱实体
     * @return 响应结果
     */
    @PostMapping("/verifyEmailCode")
    public ResponseResult<String> verifyVerificationCode(@RequestBody VerifyEmail verifyEmail) {
        String email = verifyEmail.getEmail();
        String verificationCode = verifyEmail.getCode();
        // 从 Redis 获取存储的验证码
        String storedCode = (String) redisTemplate.opsForValue().get("VERIFY_CODE_" + email);

        // 检查验证码是否存在
        if (storedCode == null) {
            return ResponseResult.fail("验证码已失效，请重新获取");
        }

        // 校验验证码是否正确
        if (storedCode.equals(verificationCode)) {
            // 验证成功后，删除验证码
            redisTemplate.delete("VERIFY_CODE_" + email);
            return ResponseResult.success("验证码验证成功",null);
        } else {
            // 验证失败后，删除验证码
            redisTemplate.delete("VERIFY_CODE_" + email);
            return ResponseResult.fail("验证码错误，验证失败，请重新获取");
        }
    }


    /**
     * 生成 6 位数字验证码
     *
     * @return 验证码
     */
    private String generateVerificationCode() {
        Random random = new Random();
        StringBuilder verificationCode = new StringBuilder(6);
        for (int i = 0; i < 6; i++) {
            verificationCode.append(random.nextInt(10)); // 生成0-9的随机数
        }
        return verificationCode.toString();
    }
}
