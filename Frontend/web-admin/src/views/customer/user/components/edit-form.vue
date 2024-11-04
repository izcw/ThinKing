<!-- 添加和修改的表单 -->
<template>
  <el-form
    ref="formRef"
    :model="form"
    :rules="rules"
    label-width="80px"
    style="max-width: 600px; margin: 10px auto"
  >
    <el-form-item label="客户账号" prop="username">
      <el-input
        clearable
        :maxlength="20"
        v-model="form.username"
        placeholder="请输入客户账号"
      />
    </el-form-item>
    <el-form-item label="客户名" prop="nickname">
      <el-input
        clearable
        :maxlength="20"
        v-model="form.nickname"
        placeholder="请输入客户名"
      />
    </el-form-item>
    <el-form-item label="性别" prop="sex">
      <sex-select v-model="form.sex" />
    </el-form-item>
    <el-form-item label="角色" prop="roles">
      <role-select v-model="form.roles" />
    </el-form-item>
    <el-form-item label="邮箱" prop="email">
      <el-input
        clearable
        :maxlength="100"
        v-model="form.email"
        placeholder="请输入邮箱"
      />
    </el-form-item>
    <el-form-item label="手机号" prop="phone">
      <el-input
        clearable
        :maxlength="11"
        v-model="form.phone"
        placeholder="请输入手机号"
      />
    </el-form-item>
    <el-form-item label="出生日期">
      <el-date-picker
        v-model="form.birthday"
        value-format="YYYY-MM-DD"
        placeholder="请选择出生日期"
        class="ele-fluid"
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
        :rows="4"
        v-model="form.introduction"
        :maxlength="200"
        placeholder="请输入个人简介"
      />
    </el-form-item>
    <el-form-item>
      <el-space size="large">
        <el-button @click="onClose">关闭</el-button>
        <el-button type="primary" :loading="loading" @click="save">
          保存
        </el-button>
      </el-space>
    </el-form-item>
  </el-form>
</template>

<script setup>
  import { ref, reactive, watch, unref } from 'vue';
  import { useRouter } from 'vue-router';
  import { EleMessage, emailReg, phoneReg } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { usePageTab } from '@/utils/use-page-tab';
  import RoleSelect from '@/views/system/user/components/role-select.vue';
  import SexSelect from '@/views/system/user/components/sex-select.vue';
  import { addUser, updateUser, checkExistence } from '@/api/system/user';

  const props = defineProps({
    // 修改回显的数据
    data: Object
  });

  const { currentRoute, push } = useRouter();
  const { removePageTab, reloadPageTab } = usePageTab();

  // 是否是修改
  const isUpdate = ref(false);

  // 提交状态
  const loading = ref(false);

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, resetFields, assignFields } = useFormData({
    userId: void 0,
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
            return callback(new Error('请输入客户账号'));
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
        message: '请输入客户名',
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
    roles: [
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
          onDone();
        })
        .catch((e) => {
          loading.value = false;
          EleMessage.error(e.message);
        });
    });
  };

  /* 关闭当前页面并跳转到列表页面 */
  const onClose = () => {
    removePageTab({ key: unref(currentRoute).path });
    push('/list/basic');
  };

  /* 关闭当前页面并刷新列表页面 */
  const onDone = () => {
    removePageTab({ key: unref(currentRoute).path });
    reloadPageTab({ fullPath: '/list/basic' });
  };

  watch(
    () => props.data,
    () => {
      if (props.data) {
        assignFields({
          ...props.data,
          password: ''
        });
        isUpdate.value = true;
      } else {
        isUpdate.value = false;
        resetFields();
        formRef.value?.clearValidate();
      }
    },
    { immediate: true }
  );
</script>
