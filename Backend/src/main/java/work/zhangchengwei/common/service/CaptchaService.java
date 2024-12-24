package work.zhangchengwei.common.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

/**
 * @Author：izcw
 * @Date： 2024/12/24 上午1:24
 * @Description：
 */

@Service
public class CaptchaService {

    @Autowired
    RedisTemplate redisTemplate;


    /**
     * 验证验证码的方法
     * @param code 用户输入的验证码
     * @param request HTTP 请求对象，用来获取 session
     * @return 验证结果
     */
    public boolean validateCaptcha(String code, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        System.out.println(sessionId+"   验证sessionId");

        // 获取 Redis 中存储的验证码尝试次数，并减少尝试次数
        String verifyCodeKey = "VERIFY_CODE_" + sessionId;
        long remainingAttempts = redisTemplate.opsForValue().decrement(verifyCodeKey);

        // 如果尝试次数小于0，验证码已经失效
        if (remainingAttempts < 0) {
            return false;
        }

        // 从 session 中获取服务器存储的验证码
        String serverCaptcha = (String) session.getAttribute("SESSION_VERIFY_CODE_" + sessionId);

        // 校验验证码的有效性
        if (code == null || code.isEmpty() || code.length() != 4) {
            return false; // 验证码无效
        }

        // 比较验证码（忽略大小写）
        return serverCaptcha != null && serverCaptcha.equalsIgnoreCase(code);
    }

    /**
     * 清除验证码的尝试次数，验证码验证通过后调用此方法
     * @param request HTTP 请求对象
     */
    public void clearCaptchaAttempts(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        String verifyCodeKey = "VERIFY_CODE_" + sessionId;
        redisTemplate.delete(verifyCodeKey); // 清除验证码相关的尝试次数
    }
}
