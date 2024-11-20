package link.duoyu.common.service;

import link.duoyu.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author：izcw
 * @Date： 2024/11/20 下午9:30
 * @Description：文件的处理操作
 */
@Service
public class FileService {

    @Value("${custom.warehouse.path}") // 从配置文件获取文件仓库路径
    private String File_Warehouse_Path;

    /**
     * 删除单个或多个文件
     * @param filePaths 文件路径列表
     * @return 删除操作结果
     */
    public ResponseResult<List<String>> deleteFiles(List<String> filePaths) {
        // 检查文件路径列表是否为空
        if (filePaths == null || filePaths.isEmpty()) {
            return ResponseResult.error("删除失败，文件路径列表不能为空");
        }

        List<String> successPaths = new ArrayList<>();
        List<String> failedPaths = new ArrayList<>();

        // 要排除的目录列表
        List<String> excludedDirectories = List.of("SystemDefaultFiles", "RootFile");

        for (String filePath : filePaths) {
            try {
                // 拼接完整路径
                String fullPath = File_Warehouse_Path + filePath;
                Path path = Paths.get(fullPath);

                // 检查文件路径是否位于受限目录下
                boolean isExcluded = excludedDirectories.stream()
                        .anyMatch(dir -> path.toString().contains(File.separator + dir + File.separator));

                if (isExcluded) {
                    failedPaths.add(filePath + " (文件位于受限目录下，无法删除)");
                    continue; // 跳过删除该文件
                }

                // 检查文件是否存在并删除
                File file = path.toFile();
                if (file.exists() && file.isFile()) {
                    boolean deleted = file.delete();
                    if (deleted) {
                        successPaths.add(filePath);
                    } else {
                        failedPaths.add(filePath);
                    }
                } else {
                    failedPaths.add(filePath + " (文件不存在)");
                }
            } catch (Exception e) {
                failedPaths.add(filePath + " (错误: " + e.getMessage() + ")");
            }
        }

        if (failedPaths.isEmpty()) {
            return ResponseResult.success("所有文件删除成功", successPaths);
        } else {
            String message = "部分文件删除失败: " + failedPaths.size() + " 项失败";
            System.out.println("部分删除失败：" + failedPaths);
            return ResponseResult.error(message);
        }
    }




}