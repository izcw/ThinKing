package work.zhangchengwei.core.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 发送邮件的实体类
 *
 * @author Izcw
 * @Date 2024/11/5 下午5:13
 */


@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class EmailBean {
    /**
     * 邮件接收人
     */
    private String recipient;

    /**
     * 邮件主题
     */
    private String subject;

    /**
     * 邮件内容
     */
    private String content;

}
