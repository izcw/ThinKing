package link.duoyu.utils;

import link.duoyu.core.utils.EmailUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

/**
 * EmailUtilTest
 *
 * @author Izcw
 * @Date 2024/11/5 下午5:30
 */

@SpringBootTest
public class EmailUtilTest {

    @Autowired
    private EmailUtil emailUtil;

    @Test
    public void testSendMail() {
        String recipient = "zhangchengwei.work@hotmail.com";
        String verificationCode = "668688";
        String title = "注册【NexNote】 验证码";
        String content = "您的验证码是：" + verificationCode;

        try {
            emailUtil.sendMail(recipient,title, content);
            System.out.println("邮件已发送至: " + recipient+"，内容："+content);
        } catch (Exception e) {
            e.printStackTrace();
            fail("邮件发送失败：" + e.getMessage());
        }
    }
//PBKDF2 加密用户密码
//AES 加密笔记数据
}