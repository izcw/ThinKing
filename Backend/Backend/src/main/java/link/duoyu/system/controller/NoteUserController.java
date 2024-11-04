package link.duoyu.system.controller;

import link.duoyu.core.web.ResponseResult;
import link.duoyu.system.entity.NoteUser;
import link.duoyu.system.mapper.NoteUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 客户 前端控制器
 * </p>
 * @Author：izcw
 * @Date：2024/11/04
 * @Description：处理用户相关请求，包括增删改查。
 */
@RestController
@RequestMapping("/note/user")
public class NoteUserController {
    @Autowired
    private NoteUserMapper noteUserMapper;

    /**
     * 获取用户列表
     * @return 用户列表
     */
    @GetMapping("/all")
    public ResponseResult<List<NoteUser>> getAllUsers() {
        List<NoteUser> list = noteUserMapper.selectList(null);
        return ResponseResult.success("查询成功",list);
    }

    /**
     * 根据ID获取用户信息
     * @param id 用户ID
     * @return 用户信息
     */
    @GetMapping("/{id}")
    public ResponseResult<NoteUser> getUserById(@PathVariable Integer id) { // 改为 Integer
        NoteUser user = noteUserMapper.selectById(id);
        if (user == null) {
            return ResponseResult.fail("用户未找到");
        }
        return ResponseResult.success(user);
    }

    /**
     * 创建新用户
     * @param noteUser 用户信息
     * @return 创建结果
     */
    @PostMapping("/create")
    public ResponseResult<NoteUser> createUser(@RequestBody NoteUser noteUser) {
        noteUserMapper.insert(noteUser);
        return ResponseResult.success(noteUser); // 返回创建的用户信息
    }

    /**
     * 更新用户信息
     * @param id 用户ID
     * @param noteUser 更新后的用户信息
     * @return 更新结果
     */
    @PutMapping("/update/{id}")
    public ResponseResult<NoteUser> updateUser(@PathVariable Integer id, @RequestBody NoteUser noteUser) { // 改为 Integer
        noteUser.setId(id); // 确保ID正确
        noteUserMapper.updateById(noteUser);
        return ResponseResult.success(noteUser); // 返回更新后的用户信息
    }

    /**
     * 删除用户
     * @param id 用户ID
     * @return 响应结果
     */
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteUser(@PathVariable Integer id) { // 改为 Integer
        noteUserMapper.deleteById(id);
        return ResponseResult.success(); // 返回成功状态
    }
}
