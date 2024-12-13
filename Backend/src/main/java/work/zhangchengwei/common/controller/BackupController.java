package work.zhangchengwei.common.controller;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import work.zhangchengwei.common.service.BackupService;
import work.zhangchengwei.common.service.RedisService;
import work.zhangchengwei.core.web.ResponseResult;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@RequestMapping("/backup")
public class BackupController {
    @Autowired
    private BackupService backupService;
    @Autowired
    private RedisService redisService;

    // 获取全量备份和增量备份文件列表和备份时间
    @GetMapping("/details")
    public ResponseResult<Map<String, List<Map<String, Object>>>> getBackupDetails() {
        try {
            Map<String, List<Map<String, Object>>> backupDetails = backupService.getBackupDetails();
            return ResponseResult.success("获取备份详情成功", backupDetails);
        } catch (Exception e) {
            return ResponseResult.error("获取备份详情失败: " + e.getMessage());
        }
    }

    // 获取备份记录
    @GetMapping("/operations")
    public ResponseResult<List<Object>> getBackupOperations() {
        return ResponseResult.success(redisService.getBackupOperations());
    }

    // 手动增量备份接口
    @PostMapping("/incremental")
    public ResponseResult<Map<String, List<String>>> manualIncrementalBackup() {
        try {
            backupService.incrementalBackup();
            Map<String, List<String>> backupFiles = backupService.getBackupFileList();
            return ResponseResult.success("增量备份成功", backupFiles);
        } catch (Exception e) {
            return ResponseResult.error("增量备份失败: " + e.getMessage());
        }
    }

    // 手动全量备份接口
    @PostMapping("/full")
    public ResponseResult<Map<String, List<String>>> manualFullBackup() {
        try {
            backupService.fullBackup();
            Map<String, List<String>> backupFiles = backupService.getBackupFileList();
            return ResponseResult.success("全量备份成功", backupFiles);
        } catch (Exception e) {
            return ResponseResult.error("全量备份失败: " + e.getMessage());
        }
    }

    // 手动数据导入接口
    @PostMapping("/import")
    public ResponseResult<Map<String, List<String>>> manualImportData(@RequestParam String filename) {
        try {
            backupService.importData(filename);
            Map<String, List<String>> backupFiles = backupService.getBackupFileList();
            return ResponseResult.success("数据导入成功", backupFiles);
        } catch (Exception e) {
            return ResponseResult.error("数据导入失败: " + e.getMessage());
        }
    }


    // 下载所有备份文件（包括增量和全量备份文件）
    @PostMapping("/downloadAll")
    public ResponseEntity<UrlResource> downloadAllBackups() {
        try {
            // 备份文件存放目录
            String backupDir = "/Users/izcw/MyFiles/Work/我的项目/note/ThinKing/sql/backups/";

            // 创建一个临时文件，用于保存压缩的备份文件
            Path zipFilePath = Paths.get(backupDir + "all_backups.zip");
            try (ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(zipFilePath.toFile()))) {
                // 获取所有备份文件（增量和全量备份）
                File[] files = new File(backupDir).listFiles((dir, name) -> name.endsWith(".sql"));
                if (files != null) {
                    for (File file : files) {
                        addToZipFile(file, zipOut);
                    }
                }
            }

            // 将生成的 ZIP 文件作为下载响应
            UrlResource resource = new UrlResource(zipFilePath.toUri());

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + zipFilePath.getFileName())
                    .body(resource);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);  // 返回 500 错误
        }
    }

    // 将单个文件添加到 ZIP 中
    private void addToZipFile(File file, ZipOutputStream zipOut) throws IOException {
        try (FileInputStream fis = new FileInputStream(file)) {
            ZipEntry zipEntry = new ZipEntry(file.getName());
            zipOut.putNextEntry(zipEntry);
            byte[] bytes = new byte[1024];
            int length;
            while ((length = fis.read(bytes)) >= 0) {
                zipOut.write(bytes, 0, length);
            }
            zipOut.closeEntry();
        }
    }
}