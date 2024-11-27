package work.zhangchengwei.system.entity;

/**
 * 验证邮箱验证码实体类
 *
 * @author Izcw
 * @Date 2024/11/8 上午12:05
 */
public class VerifyEmail {
    private String email;
    private String code;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
