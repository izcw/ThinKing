package work.zhangchengwei.note.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import work.zhangchengwei.note.entity.NoteSubscribe;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-11-21
 */
public interface NoteSubscribeMapper extends BaseMapper<NoteSubscribe> {
    // 根据订单ID查询套餐信息，为空则返回普遍套餐
    @Select("SELECT * \n" +
            "FROM note_subscribe\n" +
            "WHERE subscribe_id = IFNULL(#{subscribeId}, 1)")
    NoteSubscribe selectBySubscribeOrderIdSubscribe(@Param("subscribeId") Long subscribeId);
}
