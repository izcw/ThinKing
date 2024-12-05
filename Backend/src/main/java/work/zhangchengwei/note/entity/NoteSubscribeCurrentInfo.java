package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * @Author：izcw
 * @Date： 2024/12/5 上午10:02
 * @Description：我的套餐订单列表+套餐信息
 */
@Data
public class NoteSubscribeCurrentInfo {
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
     * 价格
     */
    private BigDecimal price;

    /**
     * 订阅天数
     */
    private Integer unit;

    /**
     * 空间个数
     */
    private Integer space;

    /**
     * 回收站最大天数
     */
    private Integer recycle;

    /**
     * 页面编辑历史记录最大天数
     */
    private Integer pageHistory;

    /**
     * 单页面最大字数，0等于无限
     */
    private Integer pageWordage;

    /**
     * AI 每天使用次数，0等于无限
     */
    private Integer ai;


//

    /**
     * 套餐订单id
     */
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
    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;

    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "当前订阅的套餐")
    private NoteSubscribeOrder subscribeOrder;
}
