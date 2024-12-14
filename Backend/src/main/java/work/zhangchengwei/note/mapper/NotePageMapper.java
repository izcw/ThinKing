package work.zhangchengwei.note.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import work.zhangchengwei.note.entity.NotePage;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 页面 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-12-06
 */
public interface NotePageMapper extends BaseMapper<NotePage> {
    /**
     * 根据 pageId 将 deleted 字段设置为指定的值，实现逻辑删除或恢复
     * @param pageId 页面ID
     * @param status 1为删除，0为恢复
     * @return 更新的行数
     */
    @Update("UPDATE note_page SET deleted = #{status} WHERE page_id = #{pageId}")
    int updateDeletedByPageId(@Param("pageId") String pageId, @Param("status") int status);

    /**
     * 根据父页面ID查找所有子页面的ID
     * @param parentId 父页面ID
     * @return 子页面ID列表
     */
    @Select("SELECT page_id FROM note_page WHERE parent_id = #{parentId}")
    List<String> findChildPagesByParentId(@Param("parentId") String parentId);


    /**
     * 根据 pageId 彻底删除页面（物理删除）
     * @param pageId 页面ID
     * @return 删除的行数
     */
    @Delete("DELETE FROM note_page WHERE page_id = #{pageId}")
    int deletePageByPageId(@Param("pageId") String pageId);

}
