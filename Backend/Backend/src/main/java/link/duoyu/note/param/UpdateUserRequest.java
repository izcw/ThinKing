package link.duoyu.note.param;

import lombok.Data;

/**
 * @Author：izcw
 * @Date： 2024/11/20 下午12:55
 * @Description：
 */

@Data
public class UpdateUserRequest {
    private Long userId;
    private String avatar;
    private String email;
    private String nickname;
    private String status;
}
