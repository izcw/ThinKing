<template>
  <el-form ref="formRef" :model="form" :rules="rules" label-width="100px"
    style="max-width: 580px; padding: 34px 16px 12px 0; box-sizing: border-box">
    <el-form-item label="昵称" prop="nickname">
      <el-input clearable :maxlength="20" v-model="form.nickname" placeholder="请输入昵称" />
    </el-form-item>
    <el-form-item label="性别" prop="sex">
      <el-select clearable v-model="form.sex" placeholder="请选择性别" class="ele-fluid">
        <el-option value="1" label="男" />
        <el-option value="2" label="女" />
      </el-select>
    </el-form-item>
    <el-form-item label="邮箱" prop="email">
      <el-input clearable :maxlength="100" v-model="form.email" placeholder="请输入邮箱" />
    </el-form-item>
    <el-form-item label="个人简介">
      <el-input type="textarea" :rows="4" :maxlength="200" v-model="form.introduction" placeholder="请输入个人简介" />
    </el-form-item>
    <el-form-item label="联系电话:">
      <el-input clearable :maxlength="10" v-model="form.phone" placeholder="请输入联系电话" />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" :loading="loading" @click="save">
        {{ loading ? '保存中..' : '保存更改' }}
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script setup>
import { ref, reactive } from 'vue';
import { EleMessage } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { updateUserInfo } from '@/api/layout';

const props = defineProps({
  data: Object
});

const emit = defineEmits(['done']);

// 提交状态
const loading = ref(false);

// 表单实例
const formRef = ref(null);

// 表单数据
const { form, assignFields } = useFormData({
  nickname: '',
  sex: void 0,
  email: '',
  introduction: '',
  phone: ''
});

// 表单验证规则
const rules = reactive({
  nickname: [
    {
      required: true,
      message: '请输入昵称',
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
  email: [
    {
      required: true,
      message: '请输入邮箱',
      type: 'string',
      trigger: 'blur'
    }
  ]
});

/* 保存更改 */
const save = () => {
  formRef.value?.validate((valid) => {
    if (!valid) {
      return;
    }
    loading.value = true;
    updateUserInfo(form)
      .then((data) => {
        loading.value = false;
        EleMessage.success('保存成功');
        emit('done', data);
      })
      .catch((e) => {
        loading.value = false;
        EleMessage.error(e.message);
      });
  });
};

// 回显当前登录用户信息
assignFields({
  ...props.data,
  email: props.data.email || 'eleadmin@eclouds.com',
});
</script>

<style lang="scss" scoped>
.form-tell {
  display: flex;
  align-items: center;
  width: 100%;

  .form-tell-prefix {
    width: 65px;
  }

  .form-tell-body {
    flex: 1;
    padding-left: 12px;
    box-sizing: border-box;
  }
}
</style>
