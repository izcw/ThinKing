package link.duoyu.system.mapper;

import link.duoyu.system.entity.SysMenu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 菜单 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-11-11
 */
public interface SysMenuMapper extends BaseMapper<SysMenu> {
    @Select("SELECT * FROM sys_menu WHERE deleted = 0 ORDER BY sort_number ASC")
    List<SysMenu> selectAllMenus();

    @Select("<script>" +
            "SELECT * FROM sys_menu WHERE menu_id IN " +
            "<foreach item='item' index='index' collection='menuIds' open='(' separator=',' close=')'>" +
            "#{item}" +
            "</foreach>" +
            " AND deleted = 0 " +
            "ORDER BY sort_number ASC" +
            "</script>")
    List<SysMenu> selectByMenuIds(@Param("menuIds") List<Integer> menuIds);
}
