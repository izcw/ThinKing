package work.zhangchengwei.system.controller;


import work.zhangchengwei.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import work.zhangchengwei.system.entity.SysMenu;
import work.zhangchengwei.system.mapper.SysMenuMapper;
import work.zhangchengwei.system.service.ISysMenuService;

import java.util.List;

/**
 * <p>
 * 菜单 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-11-11
 */
@RestController
@RequestMapping("/system/menu")
public class SysMenuController {
    @Autowired
    private SysMenuMapper sysMenuMapper;

    /**
     * 获取菜单列表
     * @return 菜单列表
     */
    @GetMapping
    public ResponseResult<List<SysMenu>> getAllUsers() {
        List<SysMenu> list = sysMenuMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }
}
