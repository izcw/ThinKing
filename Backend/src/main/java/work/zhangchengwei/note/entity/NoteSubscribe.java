package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author izcw
 * @since 2024-11-22
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_subscribe")
//@JsonIgnoreProperties(value = { "create_time","update_time" }, allowGetters = false, allowSetters = true) // 序列化忽略
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
     * 价格
     */
    private BigDecimal price;

    /**
     * 原价
     */
    private BigDecimal oldprice;

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

    @TableField("create_time")  // 映射到数据库的 create_time 列
    @JsonProperty("create_time")  // 控制序列化时的字段名为 create_time
    private LocalDateTime createTime;

    @TableField("update_time")  // 映射到数据库的 update_time 列
    @JsonProperty("update_time")  // 控制序列化时的字段名为 update_time
    private LocalDateTime updateTime;

}
