package link.duoyu.system.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.system.entity.SysRole;
import link.duoyu.system.service.ISysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-11-04
 */
@RestController
@RequestMapping("/system/role")
public class SysRoleController {
    @Autowired
    private ISysRoleService sysRoleService;

    /**
     * 获取分页查询角色列表
     * @param page 当前页码
     * @param limit 每页显示条数
     * @return 分页查询的角色列表
     */
    @GetMapping("/page")
    public ResponseResult<Page<SysRole>> page(@RequestParam("page") int page, @RequestParam("limit") int limit) {
        // 创建Page对象，设置当前页和每页显示条数
        Page<SysRole> sysRolePage = new Page<>(page, limit);

        // 执行分页查询
        Page<SysRole> pageResult = sysRoleService.page(sysRolePage);

        // 返回分页结果
        return ResponseResult.success("查询成功", pageResult);
    }

}
