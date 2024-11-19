<!-- 用户编辑弹窗 -->
<template>
  <ele-modal form :width="640" :model-value="modelValue" :title="isUpdate ? '修改用户' : '新建用户'"
    @update:modelValue="updateModelValue">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
      <el-form-item v-if="isUpdate" label="头像">
        <el-upload class="avatar-uploader" :http-request="avatarSubmit" :show-file-list="false"
          :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
          <el-avatar :size="80" :src="API_BASE_URL+form.avatar" class="upload-avatar" />
        </el-upload>
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input clearable :maxlength="100" v-model="form.email" placeholder="请输入邮箱" />
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input show-password type="password" :maxlength="20" v-model="form.password" placeholder="请输入登录密码" />
      </el-form-item>
      <el-form-item label="昵称" prop="nickname">
        <el-input clearable :maxlength="20" v-model="form.nickname" placeholder="请输入昵称" />
      </el-form-item>
      <el-row :gutter="20"  v-if="isUpdate">
        <el-col :span="10">
          <el-form-item label="套餐" prop="subscribe">
            <SubscribeSelect v-model="form.subscribe" />
          </el-form-item>
        </el-col>
        <el-col :span="14">
          <el-form-item label="到期时间">
            <el-date-picker v-model="form.becomeTime" value-format="YYYY-MM-DD" placeholder="请选择套餐到期时间"
              class="ele-fluid" />
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
import { EleMessage, emailReg } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { AddUser, UpdateUser, UploadAvatar } from '@/api/note/user/index.js';
import { API_BASE_URL } from "@/config/setting"
import SubscribeSelect from "./subscribe-select.vue"
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
  email: '',
  password: '',
  nickname: '',
  avatar: '',
  subscribe: void 0,
  becomeTime: ''
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
const save = () => {
  formRef.value?.validate((valid) => {
    if (!valid) {
      return;
    }
    loading.value = true;
    const saveOrUpdate = isUpdate.value ? UpdateUser : AddUser;
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

        assignFields({
          ...props.data,
          password: ""
        });
        console.log("哈哈哈");

        console.log(form);

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


// 处理头像上传成功的回调
const handleAvatarSuccess = (response, uploadFile) => {
  // console.log("处理头像上传成功的回调");
};

// 在上传头像前进行验证
const beforeAvatarUpload = (rawFile) => {
  if (rawFile.type !== 'image/jpeg' && rawFile.type !== 'image/png') {
    EleMessage.error('头像图片必须为 JPG或PNG 格式!');
    return false;
  } else if (rawFile.size / 1024 / 1024 > 2) {
    EleMessage.error('头像图片大小不能超过 2MB!');
    return false;
  }
  return true;
};

// 上传头像
let avatarSubmit = async ({ file }) => {
  const formData = new FormData();
  formData.append('avatar', file);

  UploadAvatar(formData)
    .then((res) => {
      EleMessage.success(res.message);
      form.avatar = res.data
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
}
</script>
