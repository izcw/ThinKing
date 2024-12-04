package work.zhangchengwei.core.config;

import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @Author：izcw
 * @Date： 2024/11/20 下午1:32
 * @Description：将 Long 类型序列化成 JSON 的时候自动转为 String 类型
 */
@Configuration
public class JacksonConfiguration {

    @Value("${spring.jackson.date-format:yyyy-MM-dd HH:mm:ss}")
    private String pattern;

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return builder -> {
            // Long 会自定转换成 String
            builder.serializerByType(Long.class, ToStringSerializer.instance);

            // LocalDateTime 格式化
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
            builder.serializerByType(LocalDateTime.class, new LocalDateTimeSerializer(formatter));
        };
    }
}