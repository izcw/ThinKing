package link.duoyu.note.controller;


import link.duoyu.core.web.ResponseResult;
import link.duoyu.note.entity.NoteSubscribe;
import link.duoyu.note.mapper.NoteSubscribeMapper;
import link.duoyu.note.service.INoteSubscribeService;
import link.duoyu.note.service.PasswordService;
import link.duoyu.system.entity.SysUser;
import link.duoyu.system.mapper.SysRoleMapper;
import link.duoyu.system.mapper.SysUserMapper;
import link.duoyu.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 订阅套餐 前端控制器
 * </p>
 *
 * @author izcw
 * @since 2024-11-19
 */
@RestController
@RequestMapping("/note/subscribe")
public class NoteSubscribeController {
    @Autowired
    private NoteSubscribeMapper noteSubscribeMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate; // Redis 操作
    @Autowired
    private INoteSubscribeService noteSubscribeService;


    /**
     * 获取套餐列表
     * @return 套餐列表
     */
    @GetMapping("/all")
    public ResponseResult<List<NoteSubscribe>> getAll() {
        List<NoteSubscribe> list = noteSubscribeMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }
}
