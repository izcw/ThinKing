package work.zhangchengwei.core.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;
import work.zhangchengwei.core.config.CustomSaTokenInterceptor;

/**
 * Web MVC 配置类，用于配置跨域请求和拦截器。
 *
 * @author Izcw
 * @Date 2024/11/7 下午5:43
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Value("${custom.warehouse.path}")
    private String File_Warehouse_Path;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://localhost:7435", "http://localhost:7436","https://www.note.zhangchengwei.work","https://note.zhangchengwei.work","https://www.sys.note.zhangchengwei.work","https://sys.note.zhangchengwei.work")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CustomSaTokenInterceptor())
                .addPathPatterns("/**") // 包含哪些路径
                .excludePathPatterns("/note/login", "/note/register","/system/login", "/file_warehouse/**","/verify/**","/email/sendEmailCode","/email/verifyEmailCode"); // 排除哪些路径
    }

    // 映射静态资源路径
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 映射静态资源路径
        registry.addResourceHandler("/file_warehouse/**")
                .addResourceLocations("file:" + File_Warehouse_Path)
                .setCachePeriod(0) // 禁用缓存
                .resourceChain(true)
                .addResolver(new PathResourceResolver());;
    }
}