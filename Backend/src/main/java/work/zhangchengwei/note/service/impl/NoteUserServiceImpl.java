package work.zhangchengwei.note.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import work.zhangchengwei.note.entity.NoteUser;
import work.zhangchengwei.note.mapper.NoteUserMapper;
import work.zhangchengwei.note.service.INoteUserService;

/**
 * <p>
 * 客户 服务实现类
 * </p>
 *
 * @author izcw
 * @since 2024-11-04
 */
@Service
public class NoteUserServiceImpl extends ServiceImpl<NoteUserMapper, NoteUser> implements INoteUserService {

}
