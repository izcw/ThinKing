<template>
  <ele-page plain hide-footer :multi-card="false">
    <ele-card style="border-radius: 0">
      <ele-text type="heading" size="lg">复杂表单</ele-text>
      <ele-text type="placeholder" style="margin-top: 6px">
        复杂表单常见于一次性输入和提交大批量数据的场景。
      </ele-text>
    </ele-card>
    <ele-page>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <ele-card header="仓库信息">
          <el-row :gutter="16">
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="仓库名" prop="name">
                <el-input
                  clearable
                  v-model="form.name"
                  placeholder="请输入仓库名"
                />
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="仓库域名" prop="url">
                <el-input clearable v-model="form.url" placeholder="请输入">
                  <template #prepend>https://</template>
                  <template #append>.com</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="仓库管理员" prop="administrator">
                <el-select
                  clearable
                  v-model="form.administrator"
                  placeholder="请选择仓库管理员"
                  class="ele-fluid"
                >
                  <el-option value="1" label="SunSmile" />
                  <el-option value="2" label="Jasmine" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="审批人" prop="approver">
                <el-select
                  clearable
                  v-model="form.approver"
                  placeholder="请选择审批人"
                  class="ele-fluid"
                >
                  <el-option value="1" label="SunSmile" />
                  <el-option value="2" label="Jasmine" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="生效日期" prop="datetime">
                <el-date-picker
                  unlink-panels
                  type="daterange"
                  v-model="form.datetime"
                  range-separator="-"
                  format="YYYY-MM-DD"
                  value-format="YYYY-MM-DD"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期"
                  class="ele-fluid"
                />
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="仓库类型" prop="type">
                <el-select
                  clearable
                  v-model="form.type"
                  placeholder="请选择仓库类型"
                  class="ele-fluid"
                >
                  <el-option value="private" label="私密" />
                  <el-option value="public" label="公开" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </ele-card>
        <ele-card header="任务信息">
          <el-row :gutter="16">
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="任务名" prop="task">
                <el-input
                  clearable
                  v-model="form.task"
                  placeholder="请输入任务名"
                />
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="任务表述" prop="description">
                <el-input
                  clearable
                  v-model="form.description"
                  placeholder="请输入任务表述"
                />
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="执行人" prop="executor">
                <el-select
                  clearable
                  v-model="form.executor"
                  placeholder="请选择执行人"
                  class="ele-fluid"
                >
                  <el-option value="1" label="SunSmile" />
                  <el-option value="2" label="Jasmine" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="责任人" prop="officer">
                <el-select
                  clearable
                  v-model="form.officer"
                  placeholder="请选择责任人"
                  class="ele-fluid"
                >
                  <el-option value="1" label="SunSmile" />
                  <el-option value="2" label="Jasmine" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="提醒时间" prop="reminder">
                <el-time-picker
                  v-model="form.reminder"
                  placeholder="请选择提醒时间"
                  value-format="HH:mm:ss"
                  class="ele-fluid"
                />
              </el-form-item>
            </el-col>
            <el-col :lg="8" :md="12" :sm="12" :xs="24">
              <el-form-item label="任务类型" prop="taskType">
                <el-select
                  clearable
                  v-model="form.taskType"
                  placeholder="请选择任务类型"
                  class="ele-fluid"
                >
                  <el-option value="1" label="私密" />
                  <el-option value="2" label="公开" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </ele-card>
        <ele-card header="选择成员">
          <ele-pro-table
            row-key="key"
            :columns="userColumns"
            :datasource="form.users"
            :pagination="false"
            :toolbar="false"
            cell-class-name="form-table-cell"
            class="form-table"
          >
            <template #name="{ row, $index }">
              <el-form-item
                v-if="$index != -1"
                label-width="auto"
                :prop="'users.' + $index + '.name'"
                :rules="{
                  required: true,
                  message: '请输入用户名',
                  type: 'string',
                  trigger: 'blur'
                }"
                class="form-error-popper"
                style="margin-bottom: 0"
              >
                <el-input
                  clearable
                  v-model="row.name"
                  placeholder="请输入用户名"
                />
              </el-form-item>
            </template>
            <template #number="{ row, $index }">
              <el-form-item
                v-if="$index != -1"
                label-width="auto"
                :prop="'users.' + $index + '.number'"
                :rules="{
                  required: true,
                  message: '请输入工号',
                  type: 'string',
                  trigger: 'blur'
                }"
                class="form-error-popper"
                style="margin-bottom: 0"
              >
                <el-input
                  clearable
                  v-model="row.number"
                  placeholder="请输入工号"
                />
              </el-form-item>
            </template>
            <template #department="{ row, $index }">
              <el-form-item
                v-if="$index != -1"
                label-width="auto"
                :prop="'users.' + $index + '.department'"
                :rules="{
                  required: true,
                  message: '请选择部门',
                  type: 'string',
                  trigger: 'blur'
                }"
                class="form-error-popper"
                style="margin-bottom: 0"
              >
                <el-select
                  clearable
                  v-model="row.department"
                  placeholder="请选择部门"
                  class="ele-fluid"
                >
                  <el-option value="研发部" label="研发部" />
                  <el-option value="测试部" label="测试部" />
                  <el-option value="产品部" label="产品部" />
                </el-select>
              </el-form-item>
            </template>
            <template #action="{ row, $index }">
              <ele-popconfirm
                :width="190"
                placement="top-end"
                title="确定要删除此用户吗？"
                :popper-options="{
                  modifiers: [
                    { name: 'arrow', options: { padding: 20 } },
                    { name: 'offset', options: { offset: [20, 6] } }
                  ]
                }"
                @confirm="removeUser(row, $index)"
              >
                <template #reference>
                  <el-link type="danger" :underline="false">删除</el-link>
                </template>
              </ele-popconfirm>
            </template>
          </ele-pro-table>
          <el-button
            :icon="Plus"
            style="margin-top: 16px; width: 100%"
            @click="addUser"
          >
            新增成员
          </el-button>
        </ele-card>
      </el-form>
    </ele-page>
    <!-- 底部工具栏 -->
    <ele-bottom-bar>
      <ele-text v-if="validMsg" type="danger" :icon="CircleClose">
        <span>{{ validMsg }}</span>
      </ele-text>
      <template #extra>
        <el-button type="primary" :loading="loading" @click="submit">
          提交
        </el-button>
      </template>
    </ele-bottom-bar>
  </ele-page>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { CircleClose, Plus } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { listAddedUsers } from '@/api/example';

  // 加载状态
  const loading = ref(false);

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, resetFields } = useFormData({
    name: '',
    url: '',
    administrator: void 0,
    approver: void 0,
    datetime: ['', ''],
    type: void 0,
    task: '',
    description: '',
    executor: void 0,
    officer: void 0,
    reminder: void 0,
    taskType: void 0,
    users: []
  });

  // 表单验证规则
  const rules = reactive({
    name: [
      {
        required: true,
        message: '请输入仓库名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    url: [
      {
        required: true,
        message: '请输入仓库域名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    administrator: [
      {
        required: true,
        message: '请选择仓库管理员',
        type: 'string',
        trigger: 'blur'
      }
    ],
    approver: [
      {
        required: true,
        message: '请选择审批人',
        type: 'string',
        trigger: 'blur'
      }
    ],
    datetime: [
      {
        required: true,
        message: '请选择生效日期',
        type: 'array',
        trigger: 'blur'
      }
    ],
    type: [
      {
        required: true,
        message: '请选择仓库类型',
        type: 'string',
        trigger: 'blur'
      }
    ],
    task: [
      {
        required: true,
        message: '请输入任务名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    description: [
      {
        required: true,
        message: '请输入任务表述',
        type: 'string',
        trigger: 'blur'
      }
    ],
    executor: [
      {
        required: true,
        message: '请选择执行人',
        type: 'string',
        trigger: 'blur'
      }
    ],
    officer: [
      {
        required: true,
        message: '请选择责任人',
        type: 'string',
        trigger: 'blur'
      }
    ],
    reminder: [
      {
        required: true,
        message: '请选择提醒时间',
        type: 'string',
        trigger: 'blur'
      }
    ],
    taskType: [
      {
        required: true,
        message: '请选择任务类型',
        type: 'string',
        trigger: 'blur'
      }
    ]
  });

  // 表单验证失败提示信息
  const validMsg = ref('');

  /* 表单提交 */
  const submit = () => {
    formRef.value?.validate((valid, obj) => {
      if (!valid) {
        const errors = obj ? Object.keys(obj).length : 0;
        validMsg.value = ` 共有 ${errors} 项校验不通过`;
        return;
      }
      validMsg.value = '';
      loading.value = true;
      setTimeout(() => {
        loading.value = false;
        EleMessage.success('提交成功');
        resetFields();
      }, 1000);
    });
  };

  // 表格列
  const userColumns = reactive([
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      columnKey: 'name',
      label: '用户名',
      slot: 'name'
    },
    {
      columnKey: 'number',
      label: '工号',
      slot: 'number'
    },
    {
      columnKey: 'department',
      label: '所属部门',
      slot: 'department'
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 100,
      align: 'center',
      resizable: false,
      slot: 'action'
    }
  ]);

  /* 添加 */
  const addUser = () => {
    form.users.push({
      key: new Date().getTime() + '-' + form.users.length,
      number: '',
      name: '',
      department: void 0
    });
  };

  /* 删除 */
  const removeUser = (_row, index) => {
    form.users.splice(index, 1);
  };

  /* 查询已添加 */
  listAddedUsers()
    .then((data) => {
      form.users = data;
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
</script>

<script>
  export default {
    name: 'FormAdvanced'
  };
</script>

<style lang="scss" scoped>
  .form-table :deep(.form-table-cell) {
    position: static;

    & > .cell {
      overflow: visible;
    }
  }

  /* 表单验证气泡形式 */
  .form-error-popper.el-form-item > :deep(.el-form-item__content) {
    & > .el-form-item__error {
      position: absolute;
      left: 0;
      top: calc(0px - 100% - 6px);
      width: max-content;
      color: #fff;
      font-size: 12px;
      background: var(--el-color-danger);
      transition: all 0.2s;
      padding: 10px;
      border-radius: 4px;
      z-index: 999;
      opacity: 0;
      visibility: hidden;
      pointer-events: none;

      &:after {
        content: '';
        border: 6px solid transparent;
        border-top-color: var(--el-color-danger);
        position: absolute;
        left: 12px;
        bottom: -11px;
      }
    }

    &:hover > .el-form-item__error {
      opacity: 1;
      visibility: visible;
      pointer-events: all;
    }
  }
</style>
