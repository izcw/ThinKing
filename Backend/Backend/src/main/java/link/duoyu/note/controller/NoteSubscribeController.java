package link.duoyu.note.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.note.entity.NoteSubscribe;
import link.duoyu.note.entity.NoteUser;
import link.duoyu.note.mapper.NoteSubscribeMapper;
import link.duoyu.note.service.INoteSubscribeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

/**
 * <p>
 *  套餐
 * </p>
 *
 * @author izcw
 * @since 2024-11-21
 */

@RestController
@RequestMapping("/note/subscribe")
public class NoteSubscribeController {
    @Autowired
    private NoteSubscribeMapper noteSubscribeMapper;
    @Autowired
    private INoteSubscribeService noteSubscribeService;

    /**
     * 获取分页查询
     * @param page 当前页码（从 1 开始）
     * @param limit 每页显示条数
     * @param sort 排序字段（可选）
     * @param order 排序顺序（可选）
     * @return 分页查询列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<NoteSubscribe>> page(@RequestParam("page") int page,
                                                    @RequestParam("limit") int limit,
                                                    @RequestParam(value = "sort", required = false) String sort,
                                                    @RequestParam(value = "order", required = false) String order,
                                                    @ModelAttribute NoteSubscribe noteSubscribe) {
        // 检查页码和每页条数的合法性
        if (page < 1 || limit < 1) {
            return ResponseResult.error("分页参数错误：页码和每页条数必须大于0");
        }

        // 创建分页对象，页码从1开始
        Page<NoteSubscribe> noteSubscribePage = new Page<>(page, limit);

        // 创建查询条件构造器
        QueryWrapper<NoteSubscribe> queryWrapper = new QueryWrapper<>();

        // 动态添加查询条件
        if (noteSubscribe.getSubscribeName() != null  && !noteSubscribe.getSubscribeName().isEmpty()) {
            queryWrapper.like("subscribe_name", noteSubscribe.getSubscribeName());
        }
        if (noteSubscribe.getSubscribeCode() != null && !noteSubscribe.getSubscribeCode().isEmpty()) {
            queryWrapper.like("subscribe_code", noteSubscribe.getSubscribeCode());
        }
        if (noteSubscribe.getStatus() != null) {
            queryWrapper.eq("status", noteSubscribe.getStatus());
        }

        // 动态添加排序条件
        if (sort != null && !sort.isEmpty()) {
            if ("asc".equalsIgnoreCase(order)) {
                queryWrapper.orderByAsc(sort); // 升序
            } else if ("desc".equalsIgnoreCase(order)) {
                queryWrapper.orderByDesc(sort); // 降序
            } else {
                return ResponseResult.error("排序顺序参数错误：只允许 asc 或 desc");
            }
        } else {
            // 如果没有传递 sort 和 order，使用默认排序
            queryWrapper.orderByAsc("create_time"); // 默认为按创建时间升序排序
        }

        // 执行分页查询
        Page<NoteSubscribe> pageResult;
        try {
            pageResult = noteSubscribeService.page(noteSubscribePage, queryWrapper);
        } catch (Exception e) {
            return ResponseResult.error("分页查询失败：" + e.getMessage());
        }

        // 返回分页结果
        return ResponseResult.success("查询成功", pageResult);
    }


    /**
     * 添加套餐
     * @return
     */
    @PostMapping("/add")
    public ResponseResult<String> add(@RequestBody NoteSubscribe noteSubscribe) {
        boolean inserted = noteSubscribeService.save(noteSubscribe); // 保存新用户
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
    @PutMapping("/update")
    public ResponseResult<NoteSubscribe> update(@RequestBody NoteSubscribe noteSubscribe) {
        // 执行更新操作，传入实体对象和更新条件
        boolean updated = noteSubscribeMapper.updateById(noteSubscribe) > 0;

        if (updated) {
            // 更新成功，直接返回传入的实体对象即可，因为 updateById 已更新
            return ResponseResult.success("修改成功", noteSubscribe);
        } else {
            // 更新失败，返回失败消息
            return ResponseResult.error("修改失败");
        }
    }


    /**
     * 单个删除接口
     * @param subscribeId 要删除的订阅ID
     * @return 删除结果
     */
    @DeleteMapping("/delete/{subscribeId}")
    public ResponseResult<String> deleteById(@PathVariable String subscribeId) {
        System.out.println(subscribeId);
        boolean deleted = noteSubscribeMapper.deleteById(subscribeId) > 0;
        if (deleted) {
            return ResponseResult.success("删除成功",null);
        } else {
            return ResponseResult.error("删除失败，未找到对应记录");
        }
    }

    /**
     * 多选删除接口
     * @param subscribeIds 要删除的订阅ID列表
     * @return 删除结果
     */
    @DeleteMapping("/deleteBatch")
    public ResponseResult<String> deleteBatch(@RequestBody List<String> subscribeIds) {
        // 使用 LambdaQueryWrapper 构建批量删除条件
        LambdaQueryWrapper<NoteSubscribe> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(NoteSubscribe::getSubscribeId, subscribeIds);

        // 执行批量删除操作
        int deletedCount = noteSubscribeMapper.delete(queryWrapper);

        if (deletedCount > 0) {
            return ResponseResult.success("批量删除成功，删除条数：" + deletedCount,null);
        } else {
            return ResponseResult.error("批量删除失败，未找到对应记录");
        }
    }

}
