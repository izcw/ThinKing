package link.duoyu.system.controller;


import cn.dev33.satoken.annotation.SaCheckRole;
import link.duoyu.core.web.ResponseResult;
import link.duoyu.system.entity.NoteUser;
import link.duoyu.system.entity.SysRole;
import link.duoyu.system.mapper.NoteUserMapper;
import link.duoyu.system.mapper.SysRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
    private SysRoleMapper sysRoleMapper;

    @GetMapping("/all")
    public ResponseResult<List<SysRole>> getAllRole() {
        List<SysRole> list = sysRoleMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }

    // @SaCheckRole("admin")
    @GetMapping("/admin")
    public ResponseResult<List<SysRole>> getAllRoleAmin() {
        List<SysRole> list = sysRoleMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }

    // @SaCheckRole("user")
    @GetMapping("/user")
    public ResponseResult<List<SysRole>> getAllRoleUser() {
        List<SysRole> list = sysRoleMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }
}
