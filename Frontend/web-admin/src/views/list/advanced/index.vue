<template>
  <ele-page>
    <ele-card>
      <el-row>
        <el-col :sm="8" :xs="24">
          <div style="text-align: center">
            <ele-text type="placeholder">进行中的任务</ele-text>
            <ele-text size="xl" style="margin-top: 6px">10 个任务</ele-text>
          </div>
        </el-col>
        <el-col :sm="8" :xs="24">
          <div style="text-align: center">
            <ele-text type="placeholder">剩余任务</ele-text>
            <ele-text size="xl" style="margin-top: 6px">3 个任务</ele-text>
          </div>
        </el-col>
        <el-col :sm="8" :xs="24">
          <div style="text-align: center">
            <ele-text type="placeholder">任务总耗时</ele-text>
            <ele-text size="xl" style="margin-top: 6px">120 个小时</ele-text>
          </div>
        </el-col>
      </el-row>
    </ele-card>
    <ele-card>
      <!-- 头部工具栏 -->
      <ele-toolbar title="复杂列表">
        <template #tools>
          <div style="display: flex; align-items: center">
            <el-radio-group v-model="where.status" @change="query">
              <el-radio-button label="0">全部</el-radio-button>
              <el-radio-button label="1">进行中</el-radio-button>
              <el-radio-button label="2">已完成</el-radio-button>
            </el-radio-group>
            <div style="width: 200px; margin-left: 12px" class="hidden-xs-only">
              <el-input v-model="where.keyword" placeholder="请输入">
                <template #append>
                  <el-button
                    :icon="Search"
                    class="ele-btn-icon"
                    @click="query"
                  />
                </template>
              </el-input>
            </div>
          </div>
        </template>
      </ele-toolbar>
      <div style="margin-top: 8px">
        <el-button :icon="Plus" class="ele-fluid" @click="openEdit()">
          添加
        </el-button>
      </div>
      <!-- 数据列表 -->
      <ele-loading :loading="loading" style="min-height: 100px">
        <div v-for="item in data" :key="item.id">
          <div class="list-item">
            <div class="list-item-avatar">
              <el-avatar :size="60" shape="square" :src="item.cover" />
              <div class="list-item-avatar-extra">
                <div style="margin-bottom: 2px">{{ item.title }}</div>
                <ele-text size="sm" type="placeholder">
                  {{ item.content }}
                </ele-text>
              </div>
            </div>
            <div class="list-item-owner">
              <div class="list-item-title">发布人</div>
              <ele-text size="sm" type="placeholder">{{ item.user }}</ele-text>
            </div>
            <div class="list-item-time">
              <div class="list-item-title">开始时间</div>
              <ele-text size="sm" type="placeholder">{{ item.time }}</ele-text>
            </div>
            <div class="list-item-progress" style="display: block">
              <el-progress :status="item.status" :percentage="item.progress" />
            </div>
            <div class="list-item-tools">
              <el-space>
                <el-link
                  type="primary"
                  :underline="false"
                  @click="openEdit(item)"
                >
                  编辑
                </el-link>
                <el-divider direction="vertical" style="margin: 0" />
                <ele-dropdown
                  :items="[
                    { title: '分享', command: 'share' },
                    { title: '删除', command: 'remove' }
                  ]"
                  @command="(key) => dropClick(key, item)"
                >
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
      <ele-pagination
        :total="count"
        v-model:page-size="limit"
        v-model:current-page="page"
        layout="prev, pager, next, jumper"
        style="margin-top: 18px; justify-content: center"
      />
    </ele-card>
    <!-- 编辑弹窗 -->
    <ele-modal
      form
      :width="460"
      v-model="visible"
      :title="form.id ? '任务编辑' : '任务添加'"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="88px">
        <el-form-item label="任务名称" prop="title">
          <el-input
            clearable
            :maxlength="20"
            v-model="form.title"
            placeholder="请输入任务名称"
          />
        </el-form-item>
        <el-form-item label="开始时间" prop="time">
          <el-date-picker
            type="datetime"
            v-model="form.time"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择开始时间"
            class="ele-fluid"
          />
        </el-form-item>
        <el-form-item label="负责人" prop="user">
          <el-select
            clearable
            v-model="form.user"
            placeholder="请选择负责人"
            class="ele-fluid"
          >
            <el-option value="SunSmile" label="SunSmile" />
            <el-option value="Pojin" label="Pojin" />
            <el-option value="SuperWill" label="SuperWill" />
            <el-option value="Jasmine" label="Jasmine" />
            <el-option value="Vast" label="Vast" />
          </el-select>
        </el-form-item>
        <el-form-item label="任务描述">
          <el-input
            :rows="4"
            type="textarea"
            v-model="form.content"
            placeholder="请输入任务描述"
          />
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

  // 列表加载状态
  const loading = ref(false);

  // 列表数据
  const data = ref([]);

  // 搜索表单
  const where = reactive({
    status: '0',
    keyword: ''
  });

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
    content: ''
  });

  // 编辑弹窗表单验证规则
  const rules = reactive({
    title: [
      {
        required: true,
        message: '请输入任务名称',
        type: 'string',
        trigger: 'blur'
      }
    ],
    time: [
      {
        required: true,
        message: '请选择开始时间',
        type: 'string',
        trigger: 'blur'
      }
    ],
    user: [
      {
        required: true,
        message: '请选择负责人',
        type: 'string',
        trigger: 'blur'
      }
    ]
  });

  // 编辑表单提交状态
  const submitLoading = ref(false);

  /* 查询数据 */
  const query = () => {
    loading.value = true;
    setTimeout(() => {
      loading.value = false;
      count.value = 25;
      data.value = [
        {
          id: 1,
          title: 'ElementUI',
          time: '2020-06-13 08:33:12',
          user: 'SunSmile',
          progress: 87,
          content:
            'Element, 一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的组件库, 提供了配套设计资源, 帮助你的网站快速成型。',
          cover:
            'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
        },
        {
          id: 2,
          title: 'Vue.js',
          time: '2020-06-13 06:40:13',
          user: 'Pojin',
          progress: 100,
          status: 'success',
          content:
            'Vue 是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是, Vue 被设计为可以自底向上逐层应用。',
          cover:
            'https://cdn.eleadmin.com/20200609/b6a811873e704db49db994053a5019b2.jpg'
        },
        {
          id: 3,
          title: 'Vuex',
          time: '2020-06-13 04:40:20',
          user: 'SuperWill',
          progress: 75,
          content:
            'Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态, 并以相应的规则保证状态以一种可预测的方式发生变化。',
          cover:
            'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
        },
        {
          id: 4,
          title: 'Vue Router',
          time: '2020-06-13 02:40:05',
          user: 'Jasmine',
          progress: 65,
          content:
            'Vue Router 是 Vue.js 官方的路由管理器。它和 Vue.js 的核心深度集成, 让构建单页面应用变得易如反掌。',
          cover:
            'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg'
        },
        {
          id: 5,
          title: 'Sass',
          time: '2020-06-13 00:40:58',
          user: 'Vast',
          progress: 45,
          status: 'exception',
          content: 'Sass 是世界上最成熟、稳定、强大的专业级 CSS 扩展语言。',
          cover:
            'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
        }
      ];
    }, 300);
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
        .catch(() => {});
    } else if (key === 'share') {
      EleMessage.success('点击了分享');
    }
  };

  query();

  watch([page, limit], () => {
    query();
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

    & > div + div {
      margin-left: 20px;
      flex-shrink: 0;
    }

    .list-item-owner {
      width: 80px;
    }

    .list-item-time {
      width: 160px;
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
      & > div + div {
        margin-left: 10px;
      }

      .list-item-owner {
        width: 70px;
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
