package work.zhangchengwei.system.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 管理员用户
 * </p>
 *
 * @author izcw
 * @since 2024-11-10
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("sys_user")
@JsonIgnoreProperties(value = { "password" }, allowGetters = false, allowSetters = true) // 序列化忽略
@ApiModel(value="SysUser对象", description="管理员用户")
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户id")
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer UserId;

    @ApiModelProperty(value = "角色id")
    private Integer RoleId;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "头像")
    private String avatar;

    @ApiModelProperty(value = "手机号")
    private String phone;

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "个人简介")
    private String introduction;

    @ApiModelProperty(value = "状态, 0正常, 1冻结")
    private Integer status;

    @ApiModelProperty(value = "是否删除, 0否, 1是")
    private Integer deleted;

    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;

    @TableField("update_time")  // 映射到数据库的 update_time 列
    @JsonProperty("update_time")  // 控制序列化时的字段名为 update_time
    private LocalDateTime updateTime;

    @TableField(exist = false) // 表示这个字段不在 sys_user 表中
    @ApiModelProperty(value = "角色列表")
    private List<SysRole> roles;

    @TableField(exist = false) // 表示这个字段不在 sys_user 表中
    @ApiModelProperty(value = "菜单列表")
    private List<SysMenu> authorities;


    public boolean isAccountNonExpired() {
        return true;
    }


    public boolean isAccountNonLocked() {
        return this.status != null && this.status == 0;
    }


    public boolean isCredentialsNonExpired() {
        return true;
    }


    public boolean isEnabled() {
        return true;
    }
}
