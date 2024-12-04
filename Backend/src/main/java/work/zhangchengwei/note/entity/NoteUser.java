package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import work.zhangchengwei.system.entity.SysRole;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 客户
 * </p>
 *
 * @author izcw
 * @since 2024-11-17
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_user")
@JsonIgnoreProperties(value = { "password" }, allowGetters = false, allowSetters = true) // 序列化忽略
public class NoteUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 客户id
     */
    @TableId(value = "user_id", type = IdType.ASSIGN_ID)
    private Long userId;

    /**
     * 邮箱/账号
     */
    private String email;

    /**
     * 密码
     */
    private String password;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 订阅套餐：默认0（普通）
     */
    private Integer subscribeId;

    /**
     * 状态, 0正常, 1冻结
     */
    private Integer status;

    /**
     * 注册时间
     */

    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;

    @TableField("update_time")  // 映射到数据库的 update_time 列
    @JsonProperty("update_time")  // 控制序列化时的字段名为 update_time
    private LocalDateTime updateTime;

//    @TableField(exist = false) // 表示这个字段不在 note_user 表中
//    @ApiModelProperty(value = "套餐订单")
//    private List<NoteSubscribeOrder> noteSubscribeOrders;

    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "套餐订单+套餐信息")
    private List<NoteSubscribesListInfo> noteSubscribesListInfos;

    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "当前订阅的套餐")
    private NoteSubscribe currentSubscription;

    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "空间列表")
    private List<NoteSpace> noteSpaces;
}
