package work.zhangchengwei.core.config;

import cn.dev33.satoken.stp.StpUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import work.zhangchengwei.core.web.ResponseResult;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 自定义SaToken拦截器，用于验证用户登录状态。
 *
 * @author Izcw
 * @Date 2024/11/9 下午9:17
 */
@Component
public class CustomSaTokenInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();

        // 检查用户是否登录
        if (!StpUtil.isLogin()) {
            response.setContentType("application/json; charset=utf-8");
            try (PrintWriter writer = response.getWriter()) {
                ResponseResult<?> result = ResponseResult.forbidden("用户未登录，请先登录");
                writer.write(new ObjectMapper().writeValueAsString(result)); // 使用 ObjectMapper 将对象转为 JSON
            } catch (IOException e) {
                e.printStackTrace();
            }
            return false;
        }
//        System.out.println("路径："+requestURI);
        // 只有当请求路径以 /system/ 开头时，才检查管理员权限
        if (requestURI.startsWith("/api/system/")) {
            // 检查用户是否具有管理员角色
            String role = StpUtil.getTokenSession().getString("role");
            System.out.println("用户："+StpUtil.getLoginIdAsString()+"，角色："+role);
            if (!RoleConstants.ADMIN_ROLE_ADMIN.equals(role) && !RoleConstants.ADMIN_ROLE_USER.equals(role) && !RoleConstants.ADMIN_ROLE_SENIOR.equals(role)) {
                response.setContentType("application/json; charset=utf-8");
                try (PrintWriter writer = response.getWriter()) {
                    ResponseResult<?> result = ResponseResult.unauthorized("您没有管理员权限，请联系管理员");
                    writer.write(new ObjectMapper().writeValueAsString(result));
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return false;
            }
        }

        return true;
    }
}
