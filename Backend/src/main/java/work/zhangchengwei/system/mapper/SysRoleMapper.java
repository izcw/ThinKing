package work.zhangchengwei.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import work.zhangchengwei.system.entity.SysRole;

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
