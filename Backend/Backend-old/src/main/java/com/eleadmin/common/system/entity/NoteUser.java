package com.eleadmin.common.system.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 客户
 * </p>
 *
 * @author izcw
 * @since 2024-11-04
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
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer id;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 邮箱/账号
     */
    private String email;

    /**
     * 密码
     *
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
     * 状态, 0正常, 1冻结
     */
    private Integer status;

    /**
     * 订阅套餐
     */
    private Integer subscribe;

    /**
     * 注册时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;


}
