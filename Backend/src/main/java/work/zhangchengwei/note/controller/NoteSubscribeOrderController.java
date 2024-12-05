package work.zhangchengwei.note.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.note.entity.NoteSubscribe;
import work.zhangchengwei.note.entity.NoteSubscribeOrder;
import work.zhangchengwei.note.entity.NoteSubscribesListInfo;
import work.zhangchengwei.note.entity.NoteTemplate;
import work.zhangchengwei.note.mapper.NoteTemplateMapper;
import work.zhangchengwei.note.service.INoteSubscribeOrderService;
import work.zhangchengwei.note.service.INoteSubscribeService;
import work.zhangchengwei.note.service.INoteTemplateService;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 用户套餐订单 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-12-04
 */
@RestController
@RequestMapping("/note/subscribeorder")
public class NoteSubscribeOrderController {
    @Autowired
    private NoteTemplateMapper noteTemplateMapper;
    @Autowired
    private INoteSubscribeOrderService noteSubscribeOrderService;
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
    public ResponseResult<Page<NoteSubscribesListInfo>> page(@RequestParam("page") int page,
                                                             @RequestParam("limit") int limit,
                                                             @RequestParam(value = "sort", required = false) String sort,
                                                             @RequestParam(value = "order", required = false) String order,
                                                             @ModelAttribute NoteSubscribeOrder noteSubscribeOrder) {
        if (page <= 0 || limit <= 0) {
            return ResponseResult.error("分页参数错误：页码和每页条数必须大于0");
        }

        Page<NoteSubscribeOrder> noteSubscribeOrderPage = new Page<>(page, limit);
        QueryWrapper<NoteSubscribeOrder> queryWrapper = new QueryWrapper<>();

        // 动态条件构造
        queryWrapper.eq(noteSubscribeOrder.getSubscribeOrderId() != null, "subscribe_order_id", noteSubscribeOrder.getSubscribeOrderId())
                .eq(noteSubscribeOrder.getUserId() != null, "user_id", noteSubscribeOrder.getUserId())
                .eq(noteSubscribeOrder.getSubscribeId() != null, "subscribe_id", noteSubscribeOrder.getSubscribeId());

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

        try {
            // 分页查询 NoteSubscribeOrder 数据
            Page<NoteSubscribeOrder> pageResult = noteSubscribeOrderService.page(noteSubscribeOrderPage, queryWrapper);

            // 使用分页数据中的 subscribe_id 查询 note_subscribe 表信息
            List<NoteSubscribesListInfo> resultList = new ArrayList<>();
            for (NoteSubscribeOrder suborder : pageResult.getRecords()) {
                // 查询对应的 note_subscribe 信息
                NoteSubscribe noteSubscribe = noteSubscribeService.getById(suborder.getSubscribeId());

                // 封装到新的对象中
                NoteSubscribesListInfo orderWithDetails = new NoteSubscribesListInfo();
                orderWithDetails.setNoteSubscribeOrder(suborder);  // 保留原始的订单信息
                orderWithDetails.setNoteSubscribe(noteSubscribe);  // 添加对应的 note_subscribe 信息

                resultList.add(orderWithDetails);
            }

            // 返回封装后的分页结果
            Page<NoteSubscribesListInfo> resultPage = new Page<>();
            resultPage.setRecords(resultList);
            resultPage.setTotal(pageResult.getTotal());
            return ResponseResult.success("查询成功", resultPage);

        } catch (Exception e) {
            return ResponseResult.error("分页查询失败：" + e.getMessage());
        }
    }

}
