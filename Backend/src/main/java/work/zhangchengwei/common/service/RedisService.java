package work.zhangchengwei.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @Author：izcw
 * @Date： 2024/12/13 上午5:12
 * @Description：
 */
@Service
public class RedisService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    // 保存操作记录
    public void saveBackupOperation(String operation, String backupFile) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日HH点mm分ss秒");
        String timestampformat = sdf.format(new Date());

        String record = timestampformat + "  操作:  " + operation + ",  备份文件:  " + backupFile;


        // 将记录存储在 Redis 中，使用 list 结构，保存操作记录
        redisTemplate.opsForList().leftPush("backup:operations", record);

        // 设置过期时间为7天
        redisTemplate.expire("backup:operations", 7, TimeUnit.DAYS);
    }

    // 获取备份记录
    public List<Object> getBackupOperations() {
        // 获取最新的20条记录
        return redisTemplate.opsForList().range("backup:operations", 0, 19);
    }
}