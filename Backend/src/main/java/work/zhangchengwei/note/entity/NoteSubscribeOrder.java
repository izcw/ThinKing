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
 * 用户套餐订单
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_subscribe_order")
public class NoteSubscribeOrder implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 套餐订单id
     */
    @TableId(value = "subscribe_order_id", type = IdType.AUTO)
    private Long subscribeOrderId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 套餐id
     */
    private Long subscribeId;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;


}
