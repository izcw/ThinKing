package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
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
     * 实付价格
     */
    private BigDecimal price;

    /**
     * 交易方式
     */
    private String transactions;

    /**
     * 状态, 0订单完成, 1订单异常，2退款、3支付失败
     */
    private Integer status;

    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;
}
