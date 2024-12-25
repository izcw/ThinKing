<template>
  <ele-page>
    <!-- 统计 -->
    <!-- <ele-card>
      <el-row :gutter="8">
        <el-col :sm="12" :xs="8">
          <div style="text-align: center">
            <ele-text type="placeholder">官方模板</ele-text>
            <ele-text size="xl" style="margin-top: 6px">10 个</ele-text>
          </div>
        </el-col>
        <el-col :sm="12" :xs="8">
          <div style="text-align: center">
            <ele-text type="placeholder">用户模板</ele-text>
            <ele-text size="xl" style="margin-top: 6px">3 个</ele-text>
          </div>
        </el-col>
      </el-row>
    </ele-card> -->

    <!-- 头部工具栏 -->
    <ele-card>
      <el-row :gutter="8" justify="end">
        <el-col :lg="8" :md="12" :sm="12" :xs="24">
          <el-radio-group v-model="where.role" @change="query">
            <el-radio-button label="admin">官方模板</el-radio-button>
            <!-- <el-radio-button label="user">用户上传模板</el-radio-button> -->
          </el-radio-group>
        </el-col>
        <el-col :lg="4" :md="12" :sm="12" :xs="24">
          <Advanced @selectuser="OnSelectuser" :switchRole="where.role" />
        </el-col>
        <el-col :lg="4" :md="12" :sm="12" :xs="24">
          <StatusSelect v-model="where.status" />
        </el-col>
        <el-col :lg="4" :md="12" :sm="12" :xs="24">
          <el-input v-model="where.templateName" clearable placeholder="请输入模板名称" />
        </el-col>
        <el-col :lg="4" :md="12" :sm="12" :xs="24">
          <el-button type="primary" @click="query">查询</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-col>
      </el-row>
    </ele-card>
    <ele-card>
      <div style="margin-bottom: 8px">
        <el-button :icon="Plus" class="ele-fluid" @click="openEdit()">
          添加
        </el-button>
      </div>
      <!-- 数据列表 -->
      <ele-loading :loading="loading" style="min-height: 100px" v-if="data.length > 0">
        <div v-for="item in data" :key="item.id">
          <div class="list-item">
            <div class="list-item-avatar">
              <el-image style="width: 120px; height: 70px;border: 1px solid #eee;"
                :src="FILE_PATH_API_URL + item.preview" :zoom-rate="1.2" :max-scale="7" :min-scale="0.2"
                :preview-src-list="[FILE_PATH_API_URL + item.preview]" fit="cover" />
              <div class="list-item-avatar-extra">
                <div style="margin-bottom: 2px">{{ item.templateName }}</div>
                <ele-text size="sm" type="placeholder">
                  {{ item.comments }}
                </ele-text>
              </div>
            </div>
            <div class="list-item-owner">
              <div class="list-item-title">发布人</div>
              <ele-text size="sm" type="placeholder">{{ item.email }}</ele-text>
            </div>
            <!-- <div class="list-item-status" style="display: block">
              <el-switch v-model="item.recommend" :inactive-value="0" :active-value="1" inline-prompt active-text="推荐"
                inactive-text="No" disabled />
            </div> -->
            <div class="list-item-time">
              <div class="list-item-title">发布时间</div>
              <ele-text size="sm" type="placeholder">{{ item.create_time }}</ele-text>
            </div>
            <div class="list-item-time">
              <div class="list-item-title">修改时间</div>
              <ele-text size="sm" type="placeholder">{{ item.update_time }}</ele-text>
            </div>
            <div class="list-item-status" style="display: block">
              <ele-dot v-for="(itemStatus, index) in statusListData" :key="index"
                v-show="item.status == itemStatus.code" :text="itemStatus.describe" :type="itemStatus.type"
                :ripple="itemStatus.ripple" size="8px" />
            </div>
            <div class="list-item-tools">
              <el-space>
                <el-link type="primary" :underline="false" @click="openEdit(item)">
                  编辑
                </el-link>
                <el-divider direction="vertical" style="margin: 0" />
                <ele-dropdown :items="[
                  { title: '删除', command: 'remove' }
                ]" @command="(key) => dropClick(key, item)">
                  <el-link type="primary" :underline="false">
                    <span>更多&nbsp;</span>
                    <el-icon :size="12">
                      <arrow-down />
                    </el-icon>
                  </el-link>
                </ele-dropdown>
              </el-space>
            </div>
          </div>
          <el-divider style="margin: 0; opacity: 0.6" />
        </div>
      </ele-loading>
      <el-empty v-else description="暂无数据" :image-size="70" />
      <ele-pagination :total="count" v-model:page-size="limit" v-model:current-page="page"
        layout="prev, pager, next, jumper" style="margin-top: 18px; justify-content: center" />
    </ele-card>

    <!-- 编辑弹窗 -->
    <ele-modal form :width="460" v-model="visible" :title="form.templateId ? '编辑' : '添加'">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="88px">
        <el-form-item label="页面id" prop="pageId">
          <el-input clearable :maxlength="20" v-model="form.pageId" placeholder="请输入页面id（必须是页面id，否则不成功）" />
        </el-form-item>
        <el-form-item label="模板名称" prop="templateName">
          <el-input clearable :maxlength="20" v-model="form.templateName" placeholder="请输入模版名称" />
        </el-form-item>
        <el-form-item label="模板描述" prop="comments">
          <el-input :rows="4" type="textarea" v-model="form.comments" placeholder="请输入模板描述" maxlength="200"
            show-word-limit />
        </el-form-item>
        <el-form-item label="预览图">
          <UploadImgbox :avatar-url="form.preview ? FILE_PATH_API_URL + form.preview : ''"
            :default-avatar="defaultAvatar" @avatarChange="handleAvatarChange" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="closeEdit">取消</el-button>
        <el-button type="primary" :loading="submitLoading" @click="onSubmit">
          保存
        </el-button>
      </template>
    </ele-modal>
  </ele-page>
</template>

<script setup>
import { ref, reactive, watch, computed } from 'vue';
import { Search, Plus, ArrowDown } from '@element-plus/icons-vue';
import { ElMessageBox } from 'element-plus';
import { EleMessage } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { FILE_PATH_API_URL } from "@/config/setting"
import { SubscribeListStatus } from '@/api/common/index.js';
import Advanced from "./components/advanced.vue";
import StatusSelect from "@/views/subscribe/membership/components/status-select.vue";
import { PageTemplate, AddTemplate, updateTemplate, removeTemplate } from '@/api/note/templateplugin/template/index';
import UploadImgbox from "./components/upload-img.vue"; // 引入组件
import { UpdateUser } from '@/api/note/user/index.js';
import { UploadAvatar } from '@/api/common/uploadFile.js';
import { useUserStore } from '@/store/modules/user';
const userStore = useUserStore();

// 列表加载状态
const loading = ref(false);

// 列表数据
const data = ref([]);

// 搜索表单
const where = reactive({
  role: "admin",
  email: '',
  templateName: '',
  status: void 0,
});

// 重置表单
const resetForm = (event) => {
  event.preventDefault(); // 防止表单提交
  where.role = 'admin';
  where.email = '';
  where.templateName = '';
  where.status = void 0;
  query()
};

// 选择的用户id
let OnSelectuser = (val) => {
  where.email = val
}

// 第几页
const page = ref(1);

// 每页多少条
const limit = ref(5);

// 总数量
const count = ref(0);

// 编辑弹窗是否显示
const visible = ref(false);

// 表单实例
const formRef = ref(null);

// 编辑弹窗表单数据
const { form, resetFields, assignFields } = useFormData({
  templateId: void 0,
  pageId: '',
  email: userStore.info.email,
  templateName: '',
  preview: null,
  comments: '',
});

// 编辑弹窗表单验证规则
const rules = reactive({
  pageId: [
    {
      required: true,
      message: '页面ID不能为空',
      type: 'string',
      trigger: 'blur'
    }
  ],
  templateName: [
    {
      required: true,
      message: '请输入模板名称',
      type: 'string',
      trigger: 'blur'
    }
  ],
  comments: [
    {
      required: true,
      message: '描述不能为空',
      trigger: 'blur'
    },
    {
      min: 1,
      message: '描述长度不能少于1字',
      trigger: 'blur'
    },
    {
      max: 200,
      message: '描述长度不能超过200字',
      trigger: 'blur'
    }
  ]
});

// 编辑表单提交状态
const submitLoading = ref(false);

/* 查询数据 */
const query = async () => {
  loading.value = true;
  try {
    // 加载数据并解构赋值
    ({ list: data.value, count: count.value } = await PageTemplate({
      ...where,
      // ...orders,
      // ...filters,
      page: page.value,
      limit: limit.value
    }));
  } catch (error) {
    console.error("数据加载失败：", error);
  } finally {
    // 确保无论成功还是失败，最终都将 loading 设置为 false
    loading.value = false;
  }
};

/* 显示编辑弹窗 */
const openEdit = (row) => {
  resetFields();
  formRef.value?.clearValidate();
  visible.value = true;
  if (row) {
    assignFields(row);
  }
};

/* 关闭编辑弹窗 */
const closeEdit = () => {
  visible.value = false;
};

/* 保存编辑 */
const onSubmit = async () => {
  formRef.value?.validate(async (valid) => {
    if (!valid) {
      return;
    }
    submitLoading.value = true;
    try {
      await handleSubmitAvatar();
      const saveOrUpdate = form.templateId ? updateTemplate : AddTemplate;
      const res = await saveOrUpdate(form);
      if (res.code === 200) {
        EleMessage.success(res.message);
        query()
        closeEdit();
      } else {
        EleMessage.warning(res.message);
      }
      selectedFile.value = null
    } catch (e) {
      EleMessage.error(e.message);
    } finally {
      submitLoading.value = false;
      loading.value = false;
    }
  });
};

/* 下拉菜单点击事件 */
const dropClick = (key, item) => {
  console.log(item);
  if (key === 'remove') {
    // 删除
    ElMessageBox.confirm('确定删除该任务吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        removeTemplate(item.templateId)
          .then((msg) => {
            query();
          })
          .catch((e) => {
            EleMessage.error(e.message);
          });
      })
      .catch(() => { });
  } else if (key === 'share') {
    EleMessage.success('点击了分享');
  }
};

query();

watch([page, limit], () => {
  query();
});

// 调用获取状态数据
let statusListData = ref()
SubscribeListStatus()
  .then((response) => {
    statusListData.value = response;
  })
  .catch((e) => {
    EleMessage.error(e.message);
  });




// 上传
const defaultAvatar = ref(FILE_PATH_API_URL + 'SystemDefaultFiles/images/avatar/avatar-default.png');
const selectedFile = ref(null);

/* 更新图片回调 */
const handleAvatarChange = (file) => {
  selectedFile.value = file; // 保存文件
};

/* 提交图片 */
const handleSubmitAvatar = async () => {
  if (!selectedFile.value) return Promise.resolve();

  const formData = new FormData();
  formData.append('avatar', selectedFile.value);
  if (form.preview) {
    formData.append('avatar_oldPath', form.preview);
  }

  try {
    const res = await UploadAvatar(formData);
    // imagesShow.value = false;
    form.preview = res.data;
    return Promise.resolve();
  } catch (error) {
    EleMessage.error(error.message);
    return Promise.reject(error);
  }
};
</script>

<script>
export default {
  name: 'ListAdvanced'
};
</script>

<style lang="scss" scoped>
/* 列表样式 */
.list-item {
  display: flex;
  align-items: center;
  padding: 16px 8px;

  .list-item-avatar {
    flex: 1;
    display: flex;
    align-items: center;

    :deep(.el-avatar) {
      flex-shrink: 0;
    }

    .list-item-avatar-extra {
      flex: 1;
      padding-left: 12px;
      box-sizing: border-box;
    }
  }

  &>div+div {
    margin-left: 20px;
    flex-shrink: 0;
  }

  .list-item-owner {
    width: 150px;
  }

  .list-item-time {
    width: 160px;
  }

  .list-item-status {
    width: 100px;
  }

  .list-item-progress {
    width: 180px;
  }

  .list-item-title {
    margin-bottom: 4px;
  }
}

/* 响应式 */
@media screen and (max-width: 1340px) {
  .list-item {
    &>div+div {
      margin-left: 10px;
    }

    .list-item-owner {
      width: 150px;
    }

    .list-item-time {
      width: 140px;
    }

    .list-item-progress {
      width: 100px;
    }
  }
}

@media screen and (max-width: 1100px) {
  .list-item {
    display: block;

    .list-item-owner,
    .list-item-time,
    .list-item-progress {
      width: 100%;
      margin: 8px 0 0 0;
      display: flex;
      align-items: center;
    }

    .list-item-title {
      margin: 0;
      width: 80px;
    }

    .list-item-tools {
      margin-top: 8px;
      text-align: right;
    }
  }
}
</style>
