package work.zhangchengwei.note.param;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.entity.NoteSubscribeOrder;

/**
 * @Author：izcw
 * @Date： 2024/12/4 下午8:07
 * @Description：我的套餐订单列表+套餐信息
 */

@Data
public class NoteSubscribesListInfo {
    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "套餐信息")
    private NoteSubscribe noteSubscribe;

    @TableField(exist = false) // 表示这个字段不在 note_user 表中
    @ApiModelProperty(value = "订单信息")
    private NoteSubscribeOrder noteSubscribeOrder;
}
