package link.duoyu.note.entity;

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
 * 订阅套餐
 * </p>
 *
 * @author izcw
 * @since 2024-11-19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_subscribe")
public class NoteSubscribe implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 套餐id
     */
    @TableId(value = "subscribe_id", type = IdType.AUTO)
    private Integer subscribeId;

    /**
     * 套餐名称
     */
    private String subscribeName;

    /**
     * 套餐标识
     */
    private String subscribeCode;

    /**
     * 备注
     */
    private String comments;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;


}
