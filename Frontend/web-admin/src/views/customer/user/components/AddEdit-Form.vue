<!-- 用户编辑弹窗 -->
<template>
  <ele-modal form :width="640" :model-value="modelValue" :title="isUpdate ? '修改用户' : '新建用户'"
    @update:modelValue="updateModelValue">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
      <el-form-item label="头像" v-if="imagesShow">
        <el-upload class="avatar-uploader" ref="uploadRef" :auto-upload="false" :show-file-list="false"
          :before-upload="beforeAvatarUpload" :on-change="handleFileChange">
          <!-- 显示选择的图片 -->
          <el-avatar #trigger :size="80" :src="form.avatar ? form.avatar : defaultAvatar" v-if="selectedFile"
            class="upload-avatar" />
          <el-avatar #trigger :size="80" :src="form.avatar ? API_BASE_URL + form.avatar : defaultAvatar" v-else
            class="upload-avatar" />
        </el-upload>
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input clearable :maxlength="100" v-model="form.email" placeholder="请输入邮箱" />
      </el-form-item>
      <el-form-item v-if="!isUpdate" label="密码" prop="password">
        <el-input show-password type="password" :maxlength="20" v-model="form.password" placeholder="请输入登录密码" />
      </el-form-item>
      <el-form-item label="昵称" prop="nickname">
        <el-input clearable :maxlength="20" v-model="form.nickname" placeholder="请输入昵称" />
      </el-form-item>˝
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
import { AddUser, UpdateUser, UploadAvatar } from '@/api/note/user/index.js';
import { API_BASE_URL } from "@/config/setting"
import StatusSelect from "./status-select.vue"
const emit = defineEmits(['done', 'update:modelValue']);

const props = defineProps({
  // 弹窗是否打开
  modelValue: Boolean,
  // 修改回显的数据
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
  avatar: '',
  email: '',
  password: '',
  nickname: '',
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
      // 1.先上传头像
      await handleSubmitAvatar();
      // 2.再保存或更新用户信息
      const saveOrUpdate = isUpdate.value ? UpdateUser : AddUser;

      const msg = await saveOrUpdate(form);
      imagesShow.value = true
      EleMessage.success(msg);

      // 更新弹窗状态并通知完成
      updateModelValue(false);
      emit('done');
    } catch (e) {
      // 捕获错误
      EleMessage.error(e.message);
    } finally {
      // 确保结束加载状态
      loading.value = false;
    }
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
        assignFields({
          ...props.data,
          password: ""
        });
        selectedFile.value = '' // 点击弹出时清空选中上传的文件
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

const imagesShow = ref(true) // 上传成功后图片不可显示
const defaultAvatar = ref(API_BASE_URL + '/file_warehouse/images/avatar/default/avatar-default.png'); // 默认头像路径
const selectedFile = ref(null); // 当前选中的文件

// 验证头像文件
const beforeAvatarUpload = (rawFile) => {
  if (!['image/jpeg', 'image/png'].includes(rawFile.type)) {
    EleMessage.error('头像图片必须为 JPG 或 PNG 格式!');
    return false;
  }
  if (rawFile.size / 1024 / 1024 > 2) {
    EleMessage.error('头像图片大小不能超过 2MB!');
    return false;
  }
  return true;
};

// 文件选择后处理
const handleFileChange = (file) => {
  selectedFile.value = file.raw; // 保存选中的文件

  // 动态生成图片的临时 URL 并更新 form.avatar
  form.avatar = URL.createObjectURL(selectedFile.value);
};


// 上传头像
const handleSubmitAvatar = async () => {
  if (!selectedFile.value) {
    return Promise.resolve(); // 如果没有头像文件，直接返回成功
  }

  const formData = new FormData();
  formData.append('avatar', selectedFile.value);

  try {
    const res = await UploadAvatar(formData);
    imagesShow.value = false
    form.avatar = res.data; // 更新头像路径到表单
    return Promise.resolve(); // 成功返回
  } catch (error) {
    EleMessage.error(error.message);
    return Promise.reject(error); // 失败抛出异常
  }
};


</script>
