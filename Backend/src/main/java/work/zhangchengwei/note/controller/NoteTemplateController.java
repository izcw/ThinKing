package work.zhangchengwei.note.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import work.zhangchengwei.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.note.entity.NotePage;
import work.zhangchengwei.note.entity.NoteTemplate;
import work.zhangchengwei.note.mapper.NoteTemplateMapper;
import work.zhangchengwei.note.service.INotePageService;
import work.zhangchengwei.note.service.INoteTemplateService;

import java.util.List;

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
    @Autowired
    private INotePageService notePageService;

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

    /**
     * 获取全部模版
     * @return 所有模版的列表
     */
    @GetMapping("/all")
    public ResponseResult<List<NoteTemplate>> getAll() {
        try {
            // 查询所有的 NoteSubscribeOrder 数据
            List<NoteTemplate> allOrders = noteTemplateService.list();
            // 返回订单列表
            return ResponseResult.success("获取所有模版成功", allOrders);
        } catch (Exception e) {
            return ResponseResult.error("获取所有模版失败：" + e.getMessage());
        }
    }

    /**
     * 添加模版
     * @return
     */
    @PostMapping("/add")
    public ResponseResult<String> add(@RequestBody NoteTemplate noteTemplate) {
        // 获取传入的 pageId 字段
        String pageIdStr = noteTemplate.getPageId().toString(); // 转换为字符串，避免 null 引发空指针异常

        Long pageId;

        // 验证 pageId 是否为合法的数字
        if (!isValidLong(pageIdStr)) {
            return ResponseResult.fail("传入的 pageId 格式不正确，必须为合法的数字");
        }

        try {
            pageId = Long.valueOf(pageIdStr);  // 将 pageId 转换为 Long
        } catch (NumberFormatException e) {
            return ResponseResult.fail("传入的 pageId 无法转换为 Long 类型");
        }

        // 查询 NotePage 是否存在
        QueryWrapper<NotePage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("page_id", pageId);

        // 执行查询
        NotePage notePage = notePageService.getOne(queryWrapper);

        // 判断 NotePage 是否存在
        if (notePage == null) {
            return ResponseResult.fail("没有找到对应的页面ID: " + pageId);
        }

        boolean inserted = noteTemplateService.save(noteTemplate); // 保存
        if (inserted) {
            return ResponseResult.success("添加成功",null);
        } else {
            return ResponseResult.fail("添加失败");
        }
    }


    /**
     * 更新信息
     * @return 更新结果
     */
    /**
     * 更新信息
     * @return 更新结果
     */
    @PutMapping("/update")
    public ResponseResult<NoteTemplate> update(@RequestBody NoteTemplate noteTemplate) {
        // 获取传入的 pageId 字段
        String pageIdStr = noteTemplate.getPageId().toString(); // 转换为字符串，避免 null 引发空指针异常

        Long pageId;

        // 验证 pageId 是否为合法的数字
        if (!isValidLong(pageIdStr)) {
            return ResponseResult.fail("传入的 pageId 格式不正确，必须为合法的数字");
        }

        try {
            pageId = Long.valueOf(pageIdStr);  // 将 pageId 转换为 Long
        } catch (NumberFormatException e) {
            return ResponseResult.fail("传入的 pageId 无法转换为 Long 类型");
        }

        // 查询 NotePage 是否存在
        QueryWrapper<NotePage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("page_id", pageId);

        // 执行查询
        NotePage notePage = notePageService.getOne(queryWrapper);

        // 判断 NotePage 是否存在
        if (notePage == null) {
            return ResponseResult.fail("没有找到对应的 NotePage，pageId: " + pageId);
        }

        // 执行更新操作，传入实体对象和更新条件
        boolean updated = noteTemplateMapper.updateById(noteTemplate) > 0;

        // 返回更新结果
        if (updated) {
            return ResponseResult.success("修改成功", noteTemplate);  // 使用已更新的 noteTemplate 返回
        } else {
            return ResponseResult.fail("修改失败");
        }
    }

    /**
     * 判断字符串是否为合法的数字
     * @param str 输入字符串
     * @return 是否是合法的 Long 类型数字
     */
    private boolean isValidLong(String str) {
        if (str == null || str.isEmpty()) {
            return false;
        }
        // 验证字符串是否只包含数字
        return str.matches("^\\d+$");
    }


    /**
     * 单个删除接口
     * @param templateId 要删除的订阅ID
     * @return 删除结果
     */
    @DeleteMapping("/delete/{templateId}")
    public ResponseResult<String> deleteById(@PathVariable String templateId) {
        System.out.println(templateId);
        boolean deleted = noteTemplateMapper.deleteById(templateId) > 0;
        if (deleted) {
            return ResponseResult.success("删除成功",null);
        } else {
            return ResponseResult.error("删除失败，未找到对应记录");
        }
    }


}
