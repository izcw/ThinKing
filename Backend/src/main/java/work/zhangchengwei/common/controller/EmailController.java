package work.zhangchengwei.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.core.utils.EmailUtil;
import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.system.entity.VerifyEmail;

import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * @Author：izcw
 * @Date： 2024/12/4 上午8:55
 * @Description：
 */
@RestController
@RequestMapping("/email")
public class EmailController {
    @Autowired
    private RedisTemplate<String, String> redisTemplate; // Redis 操作
    @Autowired
    private EmailUtil emailUtil; // 发送邮件工具


    /**
     * 生成并发送 6 位数的邮箱验证码
     *
     * @param email 用户邮箱
     * @return 响应结果
     */
    @GetMapping("/sendEmailCode")
    public ResponseResult<String> sendVerificationCode(@RequestParam String email) {
        // 生成 6 位数字验证码
        String verificationCode = generateVerificationCode();

        // 将验证码存入 Redis，设置过期时间 10 分钟
        redisTemplate.opsForValue().set("VERIFY_CODE_" + email, verificationCode, 10, TimeUnit.MINUTES);

        // 发送验证码到用户邮箱
        try {
            String title = "注册【ThinKing】 验证码 "+verificationCode;
            String content = "【ThinKing】您的注册验证码是：" + verificationCode+"，十分钟内有效，请不要透露给他人。";
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
        System.out.println(verifyEmail);
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
