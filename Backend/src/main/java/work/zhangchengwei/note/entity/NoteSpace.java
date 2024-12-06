package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 笔记空间
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_space")
public class NoteSpace implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 空间id
     */
    @TableId(value = "space_id", type = IdType.ASSIGN_ID)
    private Long spaceId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 空间名称
     */
    private String name;

    /**
     * 空间配色
     */
    private Integer color;

    /**
     * 默认空间, 0默认, 1其它
     */
    private Integer defaultSpace;

    /**
     * 排序号
     */
    private Integer sortNumber;

    /**
     * 是否删除, 0否, 1回收站
     */
    private Integer deleted;

    /**
     * 添加时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;


}
