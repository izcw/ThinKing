<template>
  <ele-modal form :width="640" :model-value="modelValue" :title="isUpdate ? '修改用户' : '新建用户'"
    @update:modelValue="updateModelValue">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
      <!-- 引入上传头像组件 -->
      <el-form-item label="头像" v-if="imagesShow">
        <UploadAvatabox :avatar-url="form.avatar ? FILE_PATH_API_URL + form.avatar : ''" :default-avatar="defaultAvatar"
          @avatarChange="handleAvatarChange" />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input clearable :maxlength="100" v-model="form.email" placeholder="请输入邮箱" />
      </el-form-item>
      <el-form-item v-if="!isUpdate" label="密码" prop="password">
        <el-input show-password type="password" :maxlength="20" v-model="form.password" placeholder="请输入登录密码" />
      </el-form-item>
      <el-form-item label="昵称" prop="nickname">
        <el-input clearable :maxlength="20" v-model="form.nickname" placeholder="请输入昵称" />
      </el-form-item>
      <el-form-item label="状态" prop="status" v-if="isUpdate">
        <StatusSelect v-model="form.status" />
      </el-form-item>
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
import { EleMessage, emailReg } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { AddUser, UpdateUser } from '@/api/note/user/index.js';
import { UploadAvatar } from '@/api/common/uploadFile.js';
import { FILE_PATH_API_URL } from "@/config/setting";
import StatusSelect from "./status-select.vue";
import UploadAvatabox from "./upload-avatar.vue"; // 引入组件

const emit = defineEmits(['done', 'update:modelValue']);
const props = defineProps({
  modelValue: Boolean,
  data: Object
});

// 是否是修改
const isUpdate = ref(false);

// 提交状态
const loading = ref(false);

// 表单实例
const formRef = ref(null);

// 表单数据
const { form, resetFields, assignFields } = useFormData({
  userId: '',
  avatar:null,
  email: '',
  password: '',
  nickname: null,
  status: 0
});

// 表单验证规则
const rules = reactive({
  nickname: [
    {
      message: '请输入用户名',
      type: 'string',
      trigger: 'blur'
    }
  ],
  email: [
    {
      required: true,
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
  ]
});

/* 保存编辑 */
const save = async () => {
  formRef.value?.validate(async (valid) => {
    if (!valid) {
      return;
    }
    loading.value = true;
    try {
      await handleSubmitAvatar();
      const saveOrUpdate = isUpdate.value ? UpdateUser : AddUser;

      const msg = await saveOrUpdate(form);
      imagesShow.value = true;
      EleMessage.success(msg);
      selectedFile.value=null
      updateModelValue(false);
      emit('done');
    } catch (e) {
      EleMessage.error(e.message);
    } finally {
      loading.value = false;
    }
  });
};

/* 更新头像回调 */
const handleAvatarChange = (file) => {
  selectedFile.value = file; // 保存文件
};

/* 提交头像 */
const handleSubmitAvatar = async () => {
  if (!selectedFile.value) return Promise.resolve();

  const formData = new FormData();
  formData.append('avatar', selectedFile.value);
  if(form.avatar){
    formData.append('avatar_oldPath', form.avatar);
  }

  try {
    const res = await UploadAvatar(formData);
    imagesShow.value = false;
    form.avatar = res.data;
    return Promise.resolve();
  } catch (error) {
    EleMessage.error(error.message);
    return Promise.reject(error);
  }
};

const updateModelValue = (value) => {
  emit('update:modelValue', value);
};

watch(
  () => props.modelValue,
  (modelValue) => {
    if (modelValue) {
      if (props.data) {
        assignFields({
          ...props.data,
          password: ''
        });
        selectedFile.value = '';
        isUpdate.value = true;
      } else {
        isUpdate.value = false;
      }
    } else {
      resetFields();
      formRef.value?.clearValidate();
    }
  }
);

const imagesShow = ref(true);
const defaultAvatar = ref(FILE_PATH_API_URL + 'SystemDefaultFiles/images/avatar/avatar-default.png');
const selectedFile = ref(null);
</script>
