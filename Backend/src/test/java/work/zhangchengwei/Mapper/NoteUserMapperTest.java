package work.zhangchengwei.Mapper;

import work.zhangchengwei.note.entity.NoteUser;
import work.zhangchengwei.note.mapper.NoteUserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * @Author：izcw
 * @Date： 2024/11/4 下午3:54
 * @Description：
 */

@SpringBootTest
public class NoteUserMapperTest {
    @Autowired
    private NoteUserMapper noteUserMapper;

    private void InfoUser(){
        List<NoteUser> list = noteUserMapper.selectList(null);
        for(NoteUser noteUser:list){
            System.out.println(noteUser);
        }
    }

    @Test
    public void insert(){

        InfoUser();
    }
}
