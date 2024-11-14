package link.duoyu.core.web;

import link.duoyu.core.config.CustomSaTokenInterceptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web MVC 配置类，用于配置跨域请求和拦截器。
 *
 * @author Izcw
 * @Date 2024/11/7 下午5:43
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${cors.allowed.origins}")
    private String allowedOrigins;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:7435", "http://localhost:7436")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CustomSaTokenInterceptor())
                .addPathPatterns("/**") // 包含哪些路径
                .excludePathPatterns("/images/**","/note/user/login", "/note/user/register","/verify/**", "/system/login"); // 排除哪些路径
    }
}