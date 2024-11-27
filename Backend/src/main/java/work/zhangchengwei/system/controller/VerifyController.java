package work.zhangchengwei.system.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

    /**
     * 生成验证码的接口
     *
     * @param response Response对象
     * @param request  Request对象
     * @throws Exception
     */
    @GetMapping("/captcha")
    public ResponseResult<String> getCode(HttpServletResponse response, HttpServletRequest request) throws Exception {
        // 获取到session
        HttpSession session = request.getSession();
        // 获取sessionid
        String id = session.getId();

        // 如果Redis中已经有旧的验证码尝试次数，先删除
        redisTemplate.delete("VERIFY_CODE_" + id);

        // 利用图片工具生成图片
        Object[] objs = VerifyUtil.newBuilder()
                .setWidth(100)   // 设置图片的宽度
                .setHeight(40)   // 设置图片的高度
                .setSize(4)      // 设置字符的个数
                .setLines(6)     // 设置干扰线的条数
                .setFontSize(32) // 设置字体的大小
                .setTilt(false)   // 设置是否需要倾斜
                .setBackgroundColor(Color.WHITE) // 设置验证码的背景颜色
                .build()         // 构建VerifyUtil项目
                .createImage();  // 生成图片

        // 将验证码存入Session，删除原有的验证码
        session.setAttribute("SESSION_VERIFY_CODE_" + id, objs[0]);

        // 设置验证码尝试次数为 3，过期时间为 10 分钟
        redisTemplate.setValueSerializer(new StringRedisSerializer());
        redisTemplate.opsForValue().set("VERIFY_CODE_" + id, "3", 10 * 60, TimeUnit.SECONDS);

        // 将图片转换为 Base64 字符串
        BufferedImage image = (BufferedImage) objs[1];
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ImageIO.write(image, "png", byteArrayOutputStream);
        byte[] imageBytes = byteArrayOutputStream.toByteArray();
        String base64Image = "data:image/png;base64," + Base64.getEncoder().encodeToString(imageBytes);  // 转为 base64 字符串

        // 返回 Base64 字符串
        return ResponseResult.success(base64Image);
    }


    /**
     * 业务接口包含了验证码的验证
     *
     * @param code    前端传入的验证码
     * @param request Request对象
     * @return ResponseResult
     */
    @PostMapping("/checkcode")
    public ResponseResult<String> checkCode(@RequestParam String code, HttpServletRequest request,HttpServletResponse response) {
        HttpSession session = request.getSession();
        String id = session.getId();

        // 将redis中的尝试次数减一
        String verifyCodeKey = "VERIFY_CODE_" + id;
        long num = redisTemplate.opsForValue().decrement(verifyCodeKey);

        // 如果次数小于0说明验证码已经失效
        if (num < 0) {
            return ResponseResult.fail("验证码失效! 请重新获取!");
        }

        // 从session中取出对应session id生成的验证码
        String serverCode = (String) session.getAttribute("SESSION_VERIFY_CODE_" + id);

        // 校验验证码
        if (null == code || code.isEmpty() || code.length() != 4) {
            return ResponseResult.fail("验证码不能为空! 或验证码不是4位!");
        }
        if (null == serverCode || !serverCode.toUpperCase().equals(code.toUpperCase())) {
            return ResponseResult.fail("验证码错误!");
        }

        // 验证通过之后手动将验证码失效
        redisTemplate.delete(verifyCodeKey);

        // 这里做具体业务相关操作
        return ResponseResult.success("验证码正确!");
    }

}
