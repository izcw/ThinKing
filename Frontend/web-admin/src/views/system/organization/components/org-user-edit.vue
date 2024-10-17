<!-- 用户编辑弹窗 -->
<template>
  <ele-modal
    form
    :width="640"
    :model-value="modelValue"
    :title="isUpdate ? '修改用户' : '新建用户'"
    @update:modelValue="updateModelValue"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
      <el-row :gutter="16">
        <el-col :sm="12" :xs="24">
          <el-form-item label="所属机构">
            <el-tree-select
              clearable
              check-strictly
              default-expand-all
              :data="organizations"
              node-key="organizationId"
              :props="{ label: 'organizationName' }"
              v-model="form.organizationId"
              placeholder="请选择所属机构"
              class="ele-fluid"
            />
          </el-form-item>
          <el-form-item label="用户账号" prop="username">
            <el-input
              clearable
              :maxlength="20"
              v-model="form.username"
              placeholder="请输入用户账号"
            />
          </el-form-item>
          <el-form-item label="用户名" prop="nickname">
            <el-input
              clearable
              :maxlength="20"
              v-model="form.nickname"
              placeholder="请输入用户名"
            />
          </el-form-item>
          <el-form-item label="性别" prop="sex">
            <sex-select v-model="form.sex" />
          </el-form-item>
          <el-form-item label="角色" prop="roles">
            <role-select v-model="form.roles" />
          </el-form-item>
        </el-col>
        <el-col :sm="12" :xs="24">
          <el-form-item label="手机号" prop="phone">
            <el-input
              clearable
              :maxlength="11"
              v-model="form.phone"
              placeholder="请输入手机号"
            />
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input
              clearable
              :maxlength="100"
              v-model="form.email"
              placeholder="请输入邮箱"
            />
          </el-form-item>
          <el-form-item v-if="!isUpdate" label="登录密码" prop="password">
            <el-input
              show-password
              type="password"
              :maxlength="20"
              v-model="form.password"
              placeholder="请输入登录密码"
            />
          </el-form-item>
          <el-form-item label="个人简介">
            <el-input
              type="textarea"
              :rows="3"
              :maxlength="200"
              v-model="form.introduction"
              placeholder="请输入个人简介"
            />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <el-button @click="updateModelValue(false)">取消</el-button>
      <el-button type="primary" :loading="loading" @click="save">
        保存
      </el-button>
    </template>
  </ele-modal>
</template>

<script setup>
  import { ref, reactive, watch } from 'vue';
  import { EleMessage, emailReg, phoneReg, toTree } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import RoleSelect from '../../user/components/role-select.vue';
  import SexSelect from '../../user/components/sex-select.vue';
  import { listOrganizations } from '@/api/system/organization';
  import { addUser, updateUser, checkExistence } from '@/api/system/user';

  const emit = defineEmits(['done', 'update:modelValue']);

  const props = defineProps({
    // 弹窗是否打开
    modelValue: Boolean,
    // 修改回显的数据
    data: Object,
    // 机构id
    organizationId: Number
  });

  // 机构树选择数据
  const organizations = ref([]);

  // 是否是修改
  const isUpdate = ref(false);

  // 提交状态
  const loading = ref(false);

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, resetFields, assignFields } = useFormData({
    userId: void 0,
    organizationId: void 0,
    username: '',
    nickname: '',
    sex: void 0,
    roles: [],
    email: '',
    phone: '',
    password: '',
    introduction: ''
  });

  // 表单验证规则
  const rules = reactive({
    username: [
      {
        required: true,
        type: 'string',
        trigger: 'blur',
        validator: (_rule, value, callback) => {
          if (!value) {
            return callback(new Error('请输入用户账号'));
          }
          checkExistence('username', value, props.data?.userId)
            .then(() => {
              callback(new Error('账号已经存在'));
            })
            .catch(() => {
              callback();
            });
        }
      }
    ],
    nickname: [
      {
        required: true,
        message: '请输入用户名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    sex: [
      {
        required: true,
        message: '请选择性别',
        type: 'string',
        trigger: 'blur'
      }
    ],
    roleIds: [
      {
        required: true,
        message: '请选择角色',
        type: 'array',
        trigger: 'blur'
      }
    ],
    email: [
      {
        pattern: emailReg,
        message: '邮箱格式不正确',
        type: 'string',
        trigger: 'blur'
      }
    ],
    password: [
      {
        required: true,
        type: 'string',
        trigger: 'blur',
        validator: (_rule, value, callback) => {
          if (isUpdate.value || /^[\S]{5,18}$/.test(value)) {
            return callback();
          }
          callback(new Error('密码必须为5-18位非空白字符'));
        }
      }
    ],
    phone: [
      {
        pattern: phoneReg,
        message: '手机号格式不正确',
        type: 'string',
        trigger: 'blur'
      }
    ]
  });

  /* 保存编辑 */
  const save = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      loading.value = true;
      const saveOrUpdate = isUpdate.value ? updateUser : addUser;
      saveOrUpdate(form)
        .then((msg) => {
          loading.value = false;
          EleMessage.success(msg);
          updateModelValue(false);
          emit('done');
        })
        .catch((e) => {
          loading.value = false;
          EleMessage.error(e.message);
        });
    });
  };

  /* 更新modelValue */
  const updateModelValue = (value) => {
    emit('update:modelValue', value);
  };

  watch(
    () => props.modelValue,
    (modelValue) => {
      if (modelValue) {
        if (props.data) {
          assignFields({ ...props.data, password: '' });
          isUpdate.value = true;
        } else {
          form.organizationId = props.organizationId;
          isUpdate.value = false;
        }
        // 查询机构树选择数据
        listOrganizations()
          .then((data) => {
            organizations.value = toTree({
              data,
              idField: 'organizationId',
              parentIdField: 'parentId'
            });
          })
          .catch((e) => {
            EleMessage.error(e.message);
          });
      } else {
        resetFields();
        formRef.value?.clearValidate();
      }
    }
  );
</script>
