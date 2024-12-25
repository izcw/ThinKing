package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 模板中心
 * </p>
 *
 * @author izcw
 * @since 2024-12-26
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_template")
public class NoteTemplate implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(value = "template_id", type = IdType.AUTO)
    private Long templateId;

    /**
     * 页面id
     */
    private Long pageId;

    /**
     * 用户邮箱
     */
    private String email;

    /**
     * 用户或管理员
     */
    private String role;

    /**
     * 模板名称
     */
    private String templateName;

    /**
     * 预览图
     */
    private String preview;

    /**
     * 模板描述
     */
    private String comments;

    /**
     * 是否推荐 1 表示推荐，0 表示不推荐
     */
    private Integer recommend;

    /**
     * 状态, 0正常, 1下架
     */
    private Integer status;

    /**
     * 是否删除, 0否, 1是
     */
    private Integer deleted;

    /**
     * 注册时间
     */
    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;

    @TableField("update_time")  // 映射到数据库的 update_time 列
    @JsonProperty("update_time")  // 控制序列化时的字段名为 update_time
    private LocalDateTime updateTime;

}
