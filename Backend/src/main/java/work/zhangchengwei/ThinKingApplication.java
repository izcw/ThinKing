package work.zhangchengwei;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling // 启用定时任务
@SpringBootApplication
@MapperScan({"work.zhangchengwei.system.mapper", "work.zhangchengwei.note.mapper"})
public class ThinKingApplication {
    public static void main(String[] args) {
        SpringApplication.run(ThinKingApplication.class, args);
    }
}
