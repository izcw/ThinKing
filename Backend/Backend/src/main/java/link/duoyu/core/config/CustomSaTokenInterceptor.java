package link.duoyu.core.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import link.duoyu.core.web.ResponseResult;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import cn.dev33.satoken.util.SaResult;

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
                SaResult result = SaResult.error("用户未登录，请先登录");
                writer.write(result.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
            return false;
        }
        System.out.println(requestURI);
        // 只有当请求路径以 /system/ 开头时，才检查管理员权限
        if (requestURI.startsWith("/api/system/")) {
            // 检查用户是否具有管理员角色
            String role = StpUtil.getTokenSession().getString("role");
            System.out.println(role);
            if (!RoleConstants.ADMIN_ROLE_ADMIN.equals(role) && !RoleConstants.ADMIN_ROLE_USER.equals(role)) {
                response.setContentType("application/json; charset=utf-8");
                try (PrintWriter writer = response.getWriter()) {
                    SaResult result = SaResult.error("您没有管理员权限，请联系管理员");
                    writer.write(result.toString());
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return false;
            }
        }

        return true;
    }
}
