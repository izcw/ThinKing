package link.duoyu.system.mapper;

import link.duoyu.system.entity.SysRoleMenu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 角色权限 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-11-14
 */
public interface SysRoleMenuMapper extends BaseMapper<SysRoleMenu> {
    @Select("SELECT * FROM sys_role_menu WHERE role_id = #{roleId}")
    List<SysRoleMenu> selectByRoleId(Integer roleId);
}
