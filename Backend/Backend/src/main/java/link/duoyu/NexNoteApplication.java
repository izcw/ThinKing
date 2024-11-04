package link.duoyu;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("link.duoyu.system.mapper")
public class NexNoteApplication {

    public static void main(String[] args) {
        SpringApplication.run(NexNoteApplication.class, args);
    }

}
