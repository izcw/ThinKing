package work.zhangchengwei.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import work.zhangchengwei.system.entity.SysUser;
import work.zhangchengwei.system.mapper.SysUserMapper;
import work.zhangchengwei.system.service.ISysUserService;

/**
 * <p>
 * 管理员用户 服务实现类
 * </p>
 *
 * @author izcw
 * @since 2024-11-10
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {

}
