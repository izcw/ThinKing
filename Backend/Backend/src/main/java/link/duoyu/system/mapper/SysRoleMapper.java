package link.duoyu.system.mapper;

import link.duoyu.system.entity.SysRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import link.duoyu.system.entity.SysRoleMenu;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 角色 Mapper 接口
 * </p>
 *
 * @author izcw
 * @since 2024-11-10
 */
public interface SysRoleMapper extends BaseMapper<SysRole> {
    // 根据角色ID查询角色信息
    @Select("SELECT * FROM sys_role WHERE role_id = #{roleId}")
    SysRole selectByRoleId(@Param("roleId") Integer roleId);
}
