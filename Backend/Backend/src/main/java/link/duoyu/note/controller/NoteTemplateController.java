package link.duoyu.note.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.note.entity.NoteSubscribe;
import link.duoyu.note.entity.NoteTemplate;
import link.duoyu.note.mapper.NoteSubscribeMapper;
import link.duoyu.note.mapper.NoteTemplateMapper;
import link.duoyu.note.service.INoteSubscribeService;
import link.duoyu.note.service.INoteTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 模板中心 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-11-23
 */
@RestController
@RequestMapping("/note/template")
public class NoteTemplateController {
    @Autowired
    private NoteTemplateMapper noteTemplateMapper;
    @Autowired
    private INoteTemplateService noteTemplateService;

    /**
     * 获取分页查询
     * @param page 当前页码（从 1 开始）
     * @param limit 每页显示条数
     * @return 分页查询列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<NoteTemplate>> page(@RequestParam("page") int page,
                                                   @RequestParam("limit") int limit,
                                                   @ModelAttribute NoteTemplate noteTemplate) {
        System.out.println(page + "&&" + limit);
        System.out.println(noteTemplate);

        if (page < 1 || limit < 1) {
            return ResponseResult.error("分页参数错误：页码和每页条数必须大于0");
        }

        Page<NoteTemplate> notetemplatePage = new Page<>(page, limit);
        QueryWrapper<NoteTemplate> queryWrapper = new QueryWrapper<>();

        // 动态条件构造
        if (noteTemplate.getRole() != null && !noteTemplate.getRole().trim().isEmpty()) {
            queryWrapper.eq("role", noteTemplate.getRole()); // 使用精确匹配
        }
        if (noteTemplate.getTemplateName() != null && !noteTemplate.getTemplateName().trim().isEmpty()) {
            queryWrapper.like("template_name", noteTemplate.getTemplateName());
        }
        if (noteTemplate.getEmail() != null && !noteTemplate.getEmail().trim().isEmpty()) {
            queryWrapper.eq("email", noteTemplate.getEmail());
        }
        if (noteTemplate.getStatus() != null) {
            queryWrapper.eq("status", noteTemplate.getStatus());
        }

        // 默认过滤逻辑删除字段
        queryWrapper.eq("deleted", 0);

        // 打印 SQL 片段用于调试
        System.out.println(queryWrapper.getSqlSegment());

        Page<NoteTemplate> pageResult;
        try {
            pageResult = noteTemplateService.page(notetemplatePage, queryWrapper);
        } catch (Exception e) {
            return ResponseResult.error("分页查询失败：" + e.getMessage());
        }

        return ResponseResult.success("查询成功", pageResult);
    }


}
