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
            <el-radio-button label="user">用户上传模板</el-radio-button>
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
      <!-- 数据列表 -->
      <ele-loading :loading="loading" style="min-height: 100px" v-if="data.length > 0">
        <div v-for="item in data" :key="item.id">
          <div class="list-item">
            <div class="list-item-avatar">
              <el-image style="width: 120px; height: 70px" :src="FILE_PATH_API_URL + item.preview" :zoom-rate="1.2"
                :max-scale="7" :min-scale="0.2" :preview-src-list="[FILE_PATH_API_URL + item.preview]" fit="cover" />
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
            <div class="list-item-time">
              <div class="list-item-title">发布时间</div>
              <ele-text size="sm" type="placeholder">{{ item.update_time }}</ele-text>
            </div>
            <div class="list-item-status" style="display: block">
              <el-switch v-model="item.recommend" :inactive-value="0" :active-value="1" inline-prompt active-text="推荐"
                inactive-text="No" disabled />
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
      <div style="margin-top: 8px">
        <el-button :icon="Plus" class="ele-fluid" @click="openEdit()">
          添加
        </el-button>
      </div>
      <ele-pagination :total="count" v-model:page-size="limit" v-model:current-page="page"
        layout="prev, pager, next, jumper" style="margin-top: 18px; justify-content: center" />
    </ele-card>
    <!-- 编辑弹窗 -->
    <ele-modal form :width="460" v-model="visible" :title="form.id ? '编辑' : '添加'">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="88px">
        <el-form-item label="模板名称" prop="title">
          <el-input clearable :maxlength="20" v-model="form.title" placeholder="请输入任务名称" />
        </el-form-item>
        <el-form-item label="发布时间" prop="time">
          <el-date-picker type="datetime" v-model="form.time" format="YYYY-MM-DD HH:mm:ss"
            value-format="YYYY-MM-DD HH:mm:ss" placeholder="请选择发布时间" class="ele-fluid" />
        </el-form-item>
        <el-form-item label="发布人" prop="user">
          <el-select clearable v-model="form.user" placeholder="请选择发布人" class="ele-fluid">
            <el-option value="SunSmile" label="SunSmile" />
            <el-option value="Pojin" label="Pojin" />
            <el-option value="SuperWill" label="SuperWill" />
            <el-option value="Jasmine" label="Jasmine" />
            <el-option value="Vast" label="Vast" />
          </el-select>
        </el-form-item>
        <el-form-item label="模板描述">
          <el-input :rows="4" type="textarea" v-model="form.describe" placeholder="请输入模板描述" />
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
import { ref, reactive, watch } from 'vue';
import { Search, Plus, ArrowDown } from '@element-plus/icons-vue';
import { ElMessageBox } from 'element-plus';
import { EleMessage } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { FILE_PATH_API_URL } from "@/config/setting"
import { SubscribeListStatus } from '@/api/common/index.js';
import Advanced from "./components/advanced.vue";
import StatusSelect from "@/views/subscribe/membership/components/status-select.vue";
import { PageTemplate } from '@/api/note/templateplugin/template/index';

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
  id: void 0,
  title: '',
  time: void 0,
  user: '',
  describe: ''
});

// 编辑弹窗表单验证规则
const rules = reactive({
  title: [
    {
      required: true,
      message: '请输入模板名称',
      type: 'string',
      trigger: 'blur'
    }
  ],
  time: [
    {
      required: true,
      message: '请选择创建时间',
      type: 'string',
      trigger: 'blur'
    }
  ],
  user: [
    {
      required: true,
      message: '请选择发布人',
      type: 'string',
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
const onSubmit = () => {
  formRef.value?.validate((valid) => {
    if (!valid) {
      return;
    }
    submitLoading.value = true;
    setTimeout(() => {
      closeEdit();
      submitLoading.value = false;
      EleMessage.success('保存成功');
      if (form.id) {
        // 保存修改
        const index = data.value.findIndex((d) => d.id === form.id);
        if (index !== -1) {
          Object.assign(data.value[index], form);
        }
      } else {
        // 保存添加
        data.value.push({
          ...form,
          id: new Date().getTime(),
          cover:
            'https://cdn.eleadmin.com/20200610/RZ8FQmZfHkcffMlTBCJllBFjEhEsObVo.jpg'
        });
      }
    }, 300);
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
        EleMessage.success('点击了删除');
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
