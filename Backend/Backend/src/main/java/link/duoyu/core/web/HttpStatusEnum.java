package link.duoyu.core.web;

import lombok.Getter;

/**
 * @Author：izcw
 * @Date：2024/11/4 下午5:37
 * @Description：HTTP状态返回枚举
 */
@Getter
public enum HttpStatusEnum {

    SUCCESS(200, "成功"),
    CREATED(201, "对象创建成功"),
    ACCEPTED(202, "请求已经被接受"),
    NO_CONTENT(204, "操作已经执行成功，但是没有返回数据"),
    MOVED_PERM(301, "资源已被移除"),
    SEE_OTHER(303, "重定向"),
    NOT_MODIFIED(304, "资源没有被修改"),
    BAD_REQUEST(400, "参数列表错误（缺少，格式不匹配）"),
    UNAUTHORIZED(401, "未授权"),
    FORBIDDEN(403, "访问受限，授权过期"),
    NOT_FOUND(404, "资源，服务未找！"),
    BAD_METHOD(405, "不允许的http方法"),
    CONFLICT(409, "资源冲突，或者资源被锁"),
    UNSUPPORTED_TYPE(415, "不支持的数据，媒体类型"),
    ERROR(500, "系统内部错误"),
    NOT_IMPLEMENTED(501, "接口未实现"),
    WARN(601, "系统警告消息");

    private final Integer code;
    private final String message;

    HttpStatusEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
