package work.zhangchengwei.note.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.entity.NoteSubscribeOrder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import work.zhangchengwei.note.entity.NoteSubscribesListInfo;

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


    // 根据用户ID查询套餐列表，并按create_time降序排列
    @Select("SELECT \n" +
            "ns.subscribe_name,\n" +
            "ns.comments,\n" +
            "ns.price,\n" +
            "ns.unit,\n" +
            "ns.space,\n" +
            "ns.recycle,\n" +
            "ns.page_history,\n" +
            "ns.page_wordage,\n" +
            "ns.ai,\n" +
            "nsorder.subscribe_order_id,\n" +
            "nsorder.user_id,\n" +
            "nsorder.subscribe_id,\n" +
            "nsorder.create_time\n" +
            "FROM note_subscribe_order AS nsorder\n" +
            "LEFT JOIN note_subscribe AS ns ON nsorder.subscribe_id = ns.subscribe_id\n" +
            "WHERE nsorder.user_id = #{userId} " +
            "ORDER BY nsorder.create_time DESC")  // 按 create_time 降序排列
    List<NoteSubscribesListInfo> selectListByUserIdSubscribesListInfo(@Param("userId") Long userId);


    // 根据用户ID查询当前的套餐，为空则没有订阅
    @Select("SELECT \n" +
            "ns.*,\n" +
            "nsorder.*\n" +
            "FROM note_subscribe_order AS nsorder\n" +
            "LEFT JOIN note_subscribe AS ns ON nsorder.subscribe_id = ns.subscribe_id\n" +
            "WHERE nsorder.user_id = #{userId}\n" +
            "  AND DATEDIFF(CURRENT_DATE, nsorder.create_time) < ns.unit\n" +
            "LIMIT 1;\n")
    NoteSubscribesListInfo selectListByUserIdCurrentSubscriptionListInfo(@Param("userId") Long userId);
}
