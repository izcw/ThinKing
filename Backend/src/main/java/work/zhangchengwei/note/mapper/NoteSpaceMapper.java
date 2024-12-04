package work.zhangchengwei.note.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import work.zhangchengwei.note.entity.NoteSpace;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import work.zhangchengwei.note.entity.NoteSubscribeOrder;

import java.util.List;

/**
 * <p>
 * 笔记空间 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
public interface NoteSpaceMapper extends BaseMapper<NoteSpace> {
    // 根据用户ID查询套餐列表
    @Select("SELECT * FROM note_space WHERE user_id = #{userId}")
    List<NoteSpace> selectListByUserId(@Param("userId") Long userId);
}
