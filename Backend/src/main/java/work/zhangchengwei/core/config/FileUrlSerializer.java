package work.zhangchengwei.core.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import org.springframework.beans.factory.annotation.Value;

import java.io.IOException;

/**
 * @Author：izcw
 * @Date： 2024/11/20 下午1:52
 * @Description：文件序列化为 JSON 时进行 后端接口 协议+主机名+端口+api(http:127.0.0.1:8071/api) 的操作
 */
public class FileUrlSerializer extends JsonSerializer<String> {

//    在实体类中使用
//    @JsonSerialize(using = FileUrlSerializer.class) // 指定自定义序列化器
//    private String avatar;

    @Value("${host-address.api}")
    private String Host_Address_Api;

    @Override
    public void serialize(String value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (value != null) {
            gen.writeString(Host_Address_Api + value); // 在序列化时拼接字符串
        } else {
            gen.writeNull();
        }
    }
}