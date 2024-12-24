package work.zhangchengwei.common.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BackupService {
    private static final Logger logger = LoggerFactory.getLogger(BackupService.class);

//    private static final String MYSQL_USER = "root";
//    private static final String MYSQL_PASSWORD = "12345678";
//    private static final String MYSQL_HOST = "localhost";
    private static final String MYSQL_PORT = "3306";
    private static final String DATABASE_NAME = "nexnote";
//    private static final String BACKUP_DIR = "/Users/izcw/MyFiles/Work/我的项目/note/ThinKing/sql/backups/"; // 备份存放的地址
    private static final Integer MAX_NUM = 3; // 最大备份数
    // 定义 cron 表达式为常量
//    private static final String CRON_INCREMENTAL_BACKUP = "0 * * * * ?"; // 每分钟执行一次
//    private static final String CRON_FULL_BACKUP = "0 0/2 * * * ?"; // 每两分钟执行一次

    private static final String CRON_INCREMENTAL_BACKUP = "0 0 * * * ?"; // 每小时执行一次
    private static final String CRON_FULL_BACKUP = "0 0 0 * * ?"; // 每天00点执行一次


    @Autowired
    private RedisService redisService;

    @Value("${spring.datasource.username}")
    private String MYSQL_USER; // 数据库账号

    @Value("${spring.datasource.password}")
    private String MYSQL_PASSWORD; // 数据库密码

    @Value("${custom.publicaddress}")
    private String MYSQL_HOST; // 地址

    @Value("${custom.backup-dir}")
    private String BACKUP_DIR; // 备份存放的地址


    // 增量备份
    @Scheduled(cron = CRON_INCREMENTAL_BACKUP)
    public void incrementalBackup() throws Exception {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        ZonedDateTime zdt = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
        String timestamp = formatter.format(zdt);
        System.out.println(timestamp);

        String backupFile = BACKUP_DIR + "incremental_backup_" + timestamp + ".sql";

        // 检查当前增量备份文件数量
        List<File> incrementalBackupFiles = getBackupFiles("incremental_backup");
        if (incrementalBackupFiles.size() >= MAX_NUM) {
            // 删除最旧的增量备份文件
            File oldestFile = incrementalBackupFiles.get(0);
            if (oldestFile.delete()) {
                logger.info("删除最旧的增量备份文件: " + oldestFile.getName());
            } else {
                logger.error("删除最旧的增量备份文件失败: " + oldestFile.getName());
            }
        }

        // 执行备份
        String[] incrementalBackupCommand = {
                "mysqldump", "-h", MYSQL_HOST, "-P", MYSQL_PORT, "-u", MYSQL_USER, "-p" + MYSQL_PASSWORD,
                "--databases", DATABASE_NAME, "--where=\"1 ORDER BY id DESC LIMIT 1\"",
                "--single-transaction", "--quick", "--skip-comments", "--no-tablespaces"
        };

        executeBackupCommand(incrementalBackupCommand, backupFile);

        // 保存操作记录到 Redis
        redisService.saveBackupOperation("增量备份incremental_backup", backupFile);
    }

    // 全量备份
    @Scheduled(cron = CRON_FULL_BACKUP)
    public void fullBackup() throws Exception {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        ZonedDateTime zdt = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
        String timestamp = formatter.format(zdt);
        System.out.println(timestamp);

        String backupFile = BACKUP_DIR + "full_backup_" + timestamp + ".sql";

        // 检查当前全量备份文件数量
        List<File> fullBackupFiles = getBackupFiles("full_backup");
        if (fullBackupFiles.size() >= MAX_NUM) {
            // 删除最旧的全量备份文件
            File oldestFile = fullBackupFiles.get(0);
            if (oldestFile.delete()) {
                logger.info("删除最旧的全量备份文件: " + oldestFile.getName());
            } else {
                logger.error("删除最旧的全量备份文件失败: " + oldestFile.getName());
            }
        }


        // 执行备份
        String[] fullBackupCommand = {
                "mysqldump", "-h", MYSQL_HOST, "-P", MYSQL_PORT, "-u", MYSQL_USER, "-p" + MYSQL_PASSWORD,
                "--databases", DATABASE_NAME,
                "--single-transaction", "--quick", "--skip-comments", "--no-tablespaces", "--add-drop-table"
        };

        executeBackupCommand(fullBackupCommand, backupFile);

        // 保存操作记录到 Redis
        redisService.saveBackupOperation("全量备份full_backup", backupFile);
    }

    // 获取备份文件列表
    private List<File> getBackupFiles(String prefix) {
        List<File> backupFiles = new ArrayList<>();
        File dir = new File(BACKUP_DIR);
        if (dir.exists() && dir.isDirectory()) {
            File[] files = dir.listFiles((d, name) -> name.startsWith(prefix) && name.endsWith(".sql"));
            if (files != null) {
                for (File file : files) {
                    backupFiles.add(file);
                }
            }
        }
        // 按文件修改时间正序排序
        backupFiles.sort((f1, f2) -> Long.compare(f1.lastModified(), f2.lastModified()));
        return backupFiles;
    }

    // 执行备份命令
    private void executeBackupCommand(String[] command, String backupFile) throws Exception {
        try {
            // 指定输出文件
            File file = new File(backupFile);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs(); // 创建目录
            }

            // 使用 ProcessBuilder 执行备份命令
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            processBuilder.redirectOutput(file);  // 将命令输出重定向到文件
            processBuilder.redirectErrorStream(true);  // 合并错误流

            // 设置环境变量
            Map<String, String> environment = processBuilder.environment();
            environment.putAll(System.getenv());

            Process process = processBuilder.start();
            int exitCode = process.waitFor();

            if (exitCode == 0) {
                logger.info("备份成功: " + backupFile);
            } else {
                logger.error("备份失败: " + backupFile);
                // 读取并打印错误信息
                try (var reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        logger.error(line);
                    }
                }
                throw new Exception("备份失败");
            }
        } catch (IOException | InterruptedException e) {
            logger.error("备份过程中发生异常: " + e.getMessage());
            throw e;
        }
    }

    // 导入数据
    public void importData(String filename) throws Exception {
        String command = "mysql -h " + MYSQL_HOST + " -P " + MYSQL_PORT + " -u " + MYSQL_USER + " -p" + MYSQL_PASSWORD + " " + DATABASE_NAME + " < " + filename;
        executeCommand(command);
    }

    // 执行导入命令
    private void executeCommand(String command) throws Exception {
        try {
            ProcessBuilder processBuilder = new ProcessBuilder("bash", "-c", command);
            processBuilder.redirectErrorStream(true);
            Map<String, String> environment = processBuilder.environment();
            environment.putAll(System.getenv());
            Process process = processBuilder.start();
            int exitCode = process.waitFor();

            if (exitCode == 0) {
                logger.info("数据导入成功: " + command);
            } else {
                logger.error("数据导入失败: " + command);
                try (var reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        logger.error(line);
                    }
                }
                throw new Exception("数据导入失败");
            }
        } catch (IOException | InterruptedException e) {
            logger.error("导入过程中发生异常: " + e.getMessage());
            throw e;
        }
    }

    // 获取备份文件数量和列表
    public Map<String, List<String>> getBackupFileList() {
        List<File> fullBackupFiles = getBackupFiles("full_backup");
        List<File> incrementalBackupFiles = getBackupFiles("incremental_backup");

        List<String> fullFileList = fullBackupFiles.stream().map(File::getName).collect(Collectors.toList());
        List<String> incrementalFileList = incrementalBackupFiles.stream().map(File::getName).collect(Collectors.toList());

        return Map.of("full", fullFileList, "incremental", incrementalFileList);
    }


    // 获取备份文件详细信息
    public Map<String, List<Map<String, Object>>> getBackupDetails() {
        List<File> fullBackupFiles = getBackupFiles("full_backup");
        List<File> incrementalBackupFiles = getBackupFiles("incremental_backup");

        // 按时间倒序排序：最新的文件在前
        fullBackupFiles.sort((f1, f2) -> Long.compare(f2.lastModified(), f1.lastModified()));
        incrementalBackupFiles.sort((f1, f2) -> Long.compare(f2.lastModified(), f1.lastModified()));

        List<Map<String, Object>> fullBackupDetails = fullBackupFiles.stream().map(file -> {
            Map<String, Object> fileDetails = Map.of(
                    "filename", file.getName(),
                    "backupTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(file.lastModified()))
            );
            return fileDetails;
        }).collect(Collectors.toList());

        List<Map<String, Object>> incrementalBackupDetails = incrementalBackupFiles.stream().map(file -> {
            Map<String, Object> fileDetails = Map.of(
                    "filename", file.getName(),
                    "backupTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(file.lastModified()))
            );
            return fileDetails;
        }).collect(Collectors.toList());

        return Map.of("full", fullBackupDetails, "incremental", incrementalBackupDetails);
    }


}