package work.zhangchengwei.note.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 页面
 * </p>
 *
 * @author izcw
 * @since 2024-12-06
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("note_page")
public class NotePage implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 空间id
     */
    @TableId(value = "page_id", type = IdType.ASSIGN_ID)
    private Long pageId;

    /**
     * 空间id
     */
    private Long spaceId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 上级id，0是顶级
     */
    private Long parentId;

    /**
     * 排序号
     */
    private String sortNumber;

    /**
     * 页面图标
     */
    private String icon;

    /**
     * 页面标题
     */
    private String title;

    /**
     * 页面封面
     */
    private String cover;

    /**
     * 笔记内容
     */
    private String content;

    /**
     * 收藏：0否，1收藏
     */
    private Integer collect;

    /**
     * 页面布局
     */
    private String layout;

    /**
     * 字体
     */
    private String font;

    /**
     * 字体大小
     */
    private String size;

    /**
     * 只读：0可以编辑，1只读
     */
    private String readonly;

    /**
     * 密码：NULL不加密
     */
    private String password;

    /**
     * 底部信息，0默认开启，1关闭
     */
    private Integer bottominfo;

    /**
     * 模板：0普通页面，1~n 模板
     */
    private Integer template;

    /**
     * 是否删除, 0否, 1回收站
     */
    private Integer deleted;

    /**
     * 添加时间
     */
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    private LocalDateTime updateTime;


}
