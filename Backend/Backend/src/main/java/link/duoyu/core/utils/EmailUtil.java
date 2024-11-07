package link.duoyu.core.utils;

import link.duoyu.core.exception.CustomException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

/**
 * 发送邮件工具类
 *
 * @author Izcw
 * @Date 2024/11/5 下午5:14
 */


@Component
@RequiredArgsConstructor
public class EmailUtil {
    /**
     * 邮件发送者
     */
    @Value("${spring.mail.username}")
    private String MAIL_SENDER;

    /**
     * 注入QQ发送邮件的bean
     */
    private final JavaMailSender javaMailSender;

    public void sendMail(String mail,String title,String content) {
        EmailBean emailBean = new EmailBean();
        //接收者
        emailBean.setRecipient(mail);
        //标题
        emailBean.setSubject(title);
        //内容主体
        emailBean.setContent(content);
        try {
            SimpleMailMessage mailMessage = new SimpleMailMessage();
            //发送者
            mailMessage.setFrom(MAIL_SENDER);
            //接收者
            mailMessage.setTo(emailBean.getRecipient());
            //邮件标题
            mailMessage.setSubject(emailBean.getSubject());
            //邮件内容
            mailMessage.setText(emailBean.getContent());
            //发送邮箱
            javaMailSender.send(mailMessage);
        } catch (Exception e) {
            throw new CustomException(500,"邮件发送失败");
        }
    }
}
