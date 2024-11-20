package link.duoyu.common.controller;

import link.duoyu.common.service.FileService;
import link.duoyu.core.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

/**
 * @Author：izcw
 * @Date： 2024/11/20 下午8:27
 * @Description：上传文件
 */

@RestController
@RequestMapping("/upload")
public class uploadFile {

    @Autowired
    private FileService fileService; // 注入 FileService


    /**
     * 上传用户头像
     * @return
     */
    @Value("${custom.warehouse.path}") // 从配置文件获取上传路径
    private String File_Warehouse_Path;

    @Value("${custom.agreement-host}") // 协议+主机
    private String agreementHost;

    @Value("${server.port}") // 从配置文件获取服务端口
    private int serverPort;



    @PostMapping("/avatar")
    public ResponseResult<String> uploadAvatar(
            @RequestParam("avatar") MultipartFile file,
            @RequestParam(value = "avatar_oldPath", required = false) String avatar_oldPath) {
        String uploadTo_Path = "UserFiles/images/avatar/"; // 上传目标目录

        if (file.isEmpty()) {
            return ResponseResult.error("上传失败，文件为空");
        }

        try {
            // 如果提供了旧的图片路径，则删除旧的图片
            if (avatar_oldPath != null && !avatar_oldPath.isEmpty()) {
                ResponseResult<List<String>> deleteResult = fileService.deleteFiles(Collections.singletonList(avatar_oldPath));
                if (deleteResult.getCode() != 200) {
                    System.out.println("头像删除失败: " + deleteResult.getMessage());
                } else {
                    System.out.println("头像删除成功，路径: " + avatar_oldPath);
                }
            }

            // 确保目标上传目录存在
            File uploadDir = new File(File_Warehouse_Path + uploadTo_Path);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename != null
                    ? originalFilename.substring(originalFilename.lastIndexOf("."))
                    : "";
            String fileName = UUID.randomUUID() + extension;
            File dest = new File(uploadDir, fileName);

            // 保存新文件到目标路径
            file.transferTo(dest);

            // 构造文件访问的 URL
            String imageUrl = uploadTo_Path + fileName;
            return ResponseResult.success("上传成功", imageUrl);
        } catch (IOException e) {
            return ResponseResult.error("上传失败: " + e.getMessage());
        }
    }

}
