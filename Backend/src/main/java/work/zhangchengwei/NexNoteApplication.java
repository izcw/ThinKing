package work.zhangchengwei;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan({"work.zhangchengwei.system.mapper", "work.zhangchengwei.note.mapper"})
public class NexNoteApplication {

    public static void main(String[] args) {
        SpringApplication.run(NexNoteApplication.class, args);
    }

}
