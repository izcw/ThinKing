package work.zhangchengwei.common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import work.zhangchengwei.common.service.CaptchaService;
import work.zhangchengwei.core.utils.VerifyUtil;
import work.zhangchengwei.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.concurrent.TimeUnit;

/**
 * 生成图片验证码
 *
 * @author Izcw
 * @Date 2024/11/6 下午8:35
 */
@RestController
@RequestMapping("/verify")
public class VerifyController {

    @Autowired
    RedisTemplate redisTemplate;
    @Autowired
    private CaptchaService captchaService;

    @GetMapping("/captcha")
    public ResponseResult<String> getCaptcha(HttpServletResponse response, HttpServletRequest request) throws Exception {
        // 获取当前会话的 sessionId
        HttpSession session = request.getSession();
        String sessionId = session.getId();  // 生成的 sessionId 是由服务器生成的

        // 返回给前端
        System.out.println("Session ID: " + sessionId);  // 生成 sessionId，并可以用于后续的请求

        // 将验证码生成逻辑放在这里
        Object[] objs = VerifyUtil.newBuilder()
                .setWidth(100)   // 设置图片的宽度
                .setHeight(40)   // 设置图片的高度
                .setSize(4)      // 设置字符的个数
                .setLines(6)     // 设置干扰线的条数
                .setFontSize(32) // 设置字体的大小
                .setTilt(false)   // 设置是否需要倾斜
                .setBackgroundColor(Color.WHITE) // 设置验证码的背景颜色
                .build()         // 构建验证码
                .createImage();  // 生成验证码图片

        // 将验证码存入 Session，删除原有的验证码
        session.setAttribute("SESSION_VERIFY_CODE_" + sessionId, objs[0]);

        // 返回 Base64 编码的图片
        BufferedImage image = (BufferedImage) objs[1];
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ImageIO.write(image, "png", byteArrayOutputStream);
        byte[] imageBytes = byteArrayOutputStream.toByteArray();
        String base64Image = "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);  // 转为 base64 字符串

        return ResponseResult.success(base64Image);
    }




    /**
     * 验证验证码
     * @param code 前端传入的验证码
     * @param request 请求对象
     * @return 验证结果
     */
    @PostMapping("/checkcode")
    public ResponseResult<String> checkCode(@RequestParam String code, HttpServletRequest request, HttpServletResponse response) {

        // 调用 CaptchaService 进行验证码验证
        boolean isCaptchaValid = captchaService.validateCaptcha(code, request);

        // 如果验证码无效，返回失败
        if (!isCaptchaValid) {
            return ResponseResult.fail("验证码错误或已失效，请重新获取!");
        }

        // 验证通过后清除验证码的尝试次数
        captchaService.clearCaptchaAttempts(request);

        // 这里可以继续执行具体的业务操作
        return ResponseResult.success("验证码正确!");
    }

}
