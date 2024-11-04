package link.duoyu.core.web;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author：izcw
 * @Date：2024/11/4 下午5:36
 * @Description：返回结果集
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("统一结果集处理器")
public class ResponseResult<T> {

    // 状态码
    @ApiModelProperty(value = "状态码")
    private Integer code;

    // 状态信息
    @ApiModelProperty(value = "状态信息")
    private Boolean status;

    // 返回信息
    @ApiModelProperty(value = "返回信息")
    private String message;

    // 数据
    @ApiModelProperty(value = "数据")
    private T data;

    /**
     * 全参数构造方法
     *
     * @param code    状态码
     * @param status  状态
     * @param message 返回信息
     * @param data    返回数据
     * @param <T>     泛型
     * @return {@link ResponseResult<T>}
     */
    private static <T> ResponseResult<T> response(Integer code, Boolean status, String message, T data) {
        ResponseResult<T> responseResult = new ResponseResult<>();
        responseResult.setCode(code);
        responseResult.setStatus(status);
        responseResult.setMessage(message);
        responseResult.setData(data);
        return responseResult;
    }

    // 成功返回（无参）
    public static <T> ResponseResult<T> success() {
        return response(HttpStatusEnum.SUCCESS.getCode(), true, HttpStatusEnum.SUCCESS.getMessage(), null);
    }

    // 成功返回（状态码+返回信息）
    public static <T> ResponseResult<T> success(Integer code, String message) {
        return response(code, true, message, null);
    }

    // 成功返回（返回信息 + 数据）
    public static <T> ResponseResult<T> success(String message, T data) {
        return response(HttpStatusEnum.SUCCESS.getCode(), true, message, data);
    }

    // 成功返回（数据）
    public static <T> ResponseResult<T> success(T data) {
        return response(HttpStatusEnum.SUCCESS.getCode(), true, HttpStatusEnum.SUCCESS.getMessage(), data);
    }

    // 错误返回（无参）
    public static <T> ResponseResult<T> error() {
        return response(HttpStatusEnum.ERROR.getCode(), false, HttpStatusEnum.ERROR.getMessage(), null);
    }

    // 错误返回（返回信息）
    public static <T> ResponseResult<T> error(String message) {
        return response(HttpStatusEnum.ERROR.getCode(), false, message, null);
    }

    // 错误返回（状态码+返回信息）
    public static <T> ResponseResult<T> error(Integer code, String message) {
        return response(code, false, message, null);
    }

    // 失败返回（无参）
    public static <T> ResponseResult<T> fail() {
        return response(HttpStatusEnum.ERROR.getCode(), false, HttpStatusEnum.ERROR.getMessage(), null);
    }

    // 失败返回（状态码+返回信息）
    public static <T> ResponseResult<T> fail(Integer code, String message) {
        return response(code, false, message, null);
    }

    // 失败返回（返回信息）
    public static <T> ResponseResult<T> fail(String message) {
        return response(HttpStatusEnum.ERROR.getCode(), false, message, null);
    }

    // 失败返回（返回信息 + 数据）
    public static <T> ResponseResult<T> fail(String message, T data) {
        return response(HttpStatusEnum.ERROR.getCode(), false, message, data);
    }

    // 失败返回（状态码+返回信息+数据）
    public static <T> ResponseResult<T> fail(Integer code, String message, T data) {
        return response(code, false, message, data);
    }

    // 其他状态返回示例
    public static <T> ResponseResult<T> created(String message, T data) {
        return response(HttpStatusEnum.CREATED.getCode(), true, message, data);
    }
    public static <T> ResponseResult<T> created(T data) {
        return response(HttpStatusEnum.CREATED.getCode(), true, HttpStatusEnum.CREATED.getMessage(), data);
    }

    public static <T> ResponseResult<T> accepted(String message) {
        return response(HttpStatusEnum.ACCEPTED.getCode(), true, message, null);
    }

    public static <T> ResponseResult<T> noContent() {
        return response(HttpStatusEnum.NO_CONTENT.getCode(), true, HttpStatusEnum.NO_CONTENT.getMessage(), null);
    }
}
