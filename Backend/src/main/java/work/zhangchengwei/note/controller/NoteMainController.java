package work.zhangchengwei.note.controller;

import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import jakarta.servlet.http.HttpServletRequest;
import work.zhangchengwei.core.utils.EmailUtil;
import work.zhangchengwei.core.web.ResponseResult;
import work.zhangchengwei.note.entity.*;
import work.zhangchengwei.note.mapper.NoteSpaceMapper;
import work.zhangchengwei.note.mapper.NoteSubscribeMapper;
import work.zhangchengwei.note.mapper.NoteSubscribeOrderMapper;
import work.zhangchengwei.note.mapper.NoteUserMapper;
import work.zhangchengwei.system.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.note.service.INoteUserService;
import work.zhangchengwei.note.service.PasswordService;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 前台登录认证控制器
 *
 * @author Izcw
 * @Date 2024/11/18 下午9:26
 */

@RestController
@RequestMapping("/note")
public class NoteMainController {
    @Autowired
    private NoteUserMapper noteUserMapper;
    @Autowired
    private INoteUserService noteUserService; // 注入NoteUserService
    @Autowired
    private PasswordService passwordService; // 注入密码服务
    @Autowired
    private NoteSubscribeOrderMapper noteSubscribeOrderMapper;
    @Autowired
    private NoteSpaceMapper noteSpaceMapper;
    @Autowired
    private NoteSubscribeMapper noteSubscribeMapper;


    /**
     * 获取登录用户信息
     * @return 用户信息
     */
    @GetMapping("/auth/user")
    public ResponseResult<NoteUser> getUserById() {
        // 获取当前登录用户的 ID
        String userIdStr = StpUtil.getLoginIdAsString();
        System.out.println(userIdStr);

        // 将字符串转换为长整型
        Long userId = Long.parseLong(userIdStr);

        // 根据用户 ID 查找用户
        NoteUser noteUser = noteUserMapper.selectById(userId);
        System.out.println(noteUser);
        if (noteUser == null) {
            return ResponseResult.fail("用户未找到");
        }

//        // 根据用户 ID 查询套餐订单列表信息
//        List<NoteSubscribeOrder> noteSubscribeOrderList = noteSubscribeOrderMapper.selectListByUserId(userId);
//        noteUser.setNoteSubscribeOrders(noteSubscribeOrderList);

        // 根据用户 ID 查询套餐订单列表信息
//        List<NoteSubscribesListInfo> noteSubscribesListInfos = noteSubscribeOrderMapper.selectListByUserIdSubscribesListInfo(userId);
//        noteUser.setNoteSubscribesListInfos(noteSubscribesListInfos);

        // 查找当前套餐
        NoteSubscribeCurrentInfo noteCurrentSubscribesListInfo = noteSubscribeOrderMapper.selectListByUserIdCurrentSubscriptionListInfo(userId);
        // 如果没有找到当前套餐，则使用默认的套餐（id = '1'）
        NoteSubscribe noteSubscribe;
        if (noteCurrentSubscribesListInfo == null) {
            // 处理为空情况，选择默认套餐
            noteSubscribe = noteSubscribeMapper.selectById("1");
        } else {
            // 如果找到当前套餐，则根据 subscribeId 获取套餐信息
            noteSubscribe = noteSubscribeMapper.selectById(noteCurrentSubscribesListInfo.getSubscribeId());
        }
        noteUser.setCurrentSubscription(noteSubscribe);


        // 根据用户 ID 查询用户所有空间
        List<NoteSpace> noteSpaceList = noteSpaceMapper.selectListByUserId(userId);
        noteUser.setNoteSpaces(noteSpaceList);

        return ResponseResult.success(noteUser);
    }

    /**
     * 登录
     * @param noteUser 用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/login")
    public ResponseResult<SaTokenInfo> login(@RequestBody NoteUser noteUser) {
        // 检查用户是否已存在
        NoteUser existingUser = noteUserService.getOne(new QueryWrapper<NoteUser>().eq("email", noteUser.getEmail()));

        if (existingUser != null) {
            // 如果用户已存在，验证密码
            if (passwordService.verifyPassword(noteUser.getPassword(), existingUser.getPassword())) {
                // 第1步 设置登录账号id
                StpUtil.login(existingUser.getUserId());

                // 第2步，获取 Token  相关参数
                SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
                // 密码验证成功，返回用户信息
                return ResponseResult.success("登录成功", tokenInfo);
            } else {
                // 密码验证失败
                return ResponseResult.fail("密码错误");
            }
        } else {
            return ResponseResult.unauthorized("该用户未注册！");
        }
    }

    /**
     * 注册
     * @param noteUser 用户信息
     * @return 创建或登录结果
     */
    @PostMapping("/register")
    public ResponseResult<NoteUser> Register(@RequestBody NoteUser noteUser) {
        // 检查用户是否已存在
        NoteUser existingUser = noteUserService.getOne(new QueryWrapper<NoteUser>().eq("email", noteUser.getEmail()));
        if (existingUser != null) {
            return ResponseResult.created("该用户已注册，请登录", existingUser);
        } else {
            // 如果用户不存在，注册新用户
            noteUser.setPassword(passwordService.hashPassword(noteUser.getPassword())); // 散列密码
            boolean inserted = noteUserService.save(noteUser); // 保存新用户
            if (inserted) {
                return ResponseResult.success("注册成功",null);
            } else {
                return ResponseResult.fail("注册失败");
            }
        }
    }

    /**
     * 注销接口，使用 Sa-Token 实现用户注销
     * @param token  用户登录的token
     * @return 响应结果
     */
    @PostMapping("/logout")
    public ResponseResult<String> logout(@RequestHeader("Authorization") String token) {
        System.out.println(token);
        StpUtil.logoutByTokenValue(token);      // 强制指定 Token 注销下线
        return ResponseResult.success("注销成功", null);
    }

//    @PostMapping("/islogin")
//    public String islogin(@RequestBody NoteUser noteUser , HttpServletRequest request){
//        String token = request.getHeader("Authorization");
//        System.out.println(token);
//        return "当前会话是否登录：" + StpUtil.isLogin(noteUser.getEmail());
//    }



}
