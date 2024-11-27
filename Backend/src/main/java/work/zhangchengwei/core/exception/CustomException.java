package work.zhangchengwei.core.exception;

/**
 * 自定义异常类
 *
 * @author Izcw
 * @Date 2024/11/5 下午5:22
 */
public class CustomException extends RuntimeException {
    private int code;

    public CustomException(int code, String message) {
        super(message);
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
