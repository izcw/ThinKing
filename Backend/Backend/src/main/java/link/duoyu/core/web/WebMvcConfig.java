package link.duoyu.core.web;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 跨域配置
 *
 * @author Izcw
 * @Date 2024/11/7 下午5:43
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 允许跨域请求的路径
                .allowedOrigins("http://localhost:7436")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允许的方法
                .allowedHeaders("*") // 允许的头信息
                .allowCredentials(true) // 是否允许证书（cookies）
                .maxAge(3600); // 预检请求的缓存时间（秒）
    }
}