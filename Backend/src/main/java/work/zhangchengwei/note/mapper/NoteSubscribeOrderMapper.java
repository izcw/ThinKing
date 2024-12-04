package work.zhangchengwei.note.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.entity.NoteSubscribeOrder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 用户套餐订单 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
public interface NoteSubscribeOrderMapper extends BaseMapper<NoteSubscribeOrder> {
    // 根据用户ID查询套餐列表
    @Select("SELECT * FROM note_subscribe_order WHERE user_id = #{userId}")
    List<NoteSubscribeOrder> selectListByUserId(@Param("userId") Long userId);
}
