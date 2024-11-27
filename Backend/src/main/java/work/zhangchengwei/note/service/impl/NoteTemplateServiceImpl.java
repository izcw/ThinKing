package work.zhangchengwei.note.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import work.zhangchengwei.note.entity.NoteTemplate;
import work.zhangchengwei.note.mapper.NoteTemplateMapper;
import work.zhangchengwei.note.service.INoteTemplateService;

/**
 * <p>
 * 模板中心 服务实现类
 * </p>
 *
 * @author izcw
 * @since 2024-11-23
 */
@Service
public class NoteTemplateServiceImpl extends ServiceImpl<NoteTemplateMapper, NoteTemplate> implements INoteTemplateService {

}
