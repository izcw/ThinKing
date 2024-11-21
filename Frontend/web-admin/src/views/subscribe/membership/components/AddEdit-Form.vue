<template>
  <ele-modal form :width="640" :model-value="modelValue" :title="isUpdate ? '修改' : '新建'"
    @update:modelValue="updateModelValue">
    <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="套餐名称" prop="subscribeName">
        <el-input clearable v-model="form.subscribeName" placeholder="请输入" />
      </el-form-item>
      <el-form-item label="套餐标识" prop="subscribeCode">
        <el-input clearable v-model="form.subscribeCode" placeholder="请输入" />
      </el-form-item>
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="价格" prop="price">
            <el-input-number :precision="2" clearable v-model="form.price" style="width: 100%;" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="单位" prop="unit">
            <UnitSelect v-model="form.unit" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="空间(个)" prop="space">
            <el-input clearable v-model="form.space" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="回收站(天)" prop="recycle">
            <el-input clearable v-model="form.recycle" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="页面历史(天)" prop="pageHistory">
            <el-input clearable v-model="form.pageHistory" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="字数(单页)" prop="pageWordage">
            <el-input clearable v-model="form.pageWordage" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="AI(天/次)" prop="ai">
            <el-input clearable v-model="form.ai" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="推荐" prop="recommend">
            <el-switch v-model="form.recommend" :inactive-value="0" :active-value="1" />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status" v-if="isUpdate">
            <StatusSelect v-model="form.status" />
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="描述" prop="comments">
        <el-input v-model="form.comments" maxlength="50" :rows="4" resize="none" style="width: 100%;" placeholder="请输入"
          show-word-limit type="textarea" />
      </el-form-item>
      <el-alert title="提示" type="warning" description="字数 和 AI 输入 0 等于不限" show-icon />
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
import { EleMessage } from 'ele-admin-plus/es';
import { useFormData } from '@/utils/use-form-data';
import { AddSubscribe, UpdateSubscribe } from '@/api/note/subscribe/index';
import StatusSelect from "./status-select.vue";
import UnitSelect from "./unit-select.vue";

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
  subscribeId: '',
  subscribeName: '',
  subscribeCode: '',
  price: 0.00,
  unit: '30',
  space: '',
  recycle: '',
  pageHistory: '',
  pageWordage: '',
  ai: '',
  recommend: 0,
  comments: '',
  status: 0
});

// 表单验证规则
const rules = reactive({
  subscribeName: [
    {
      required: true,
      message: '请输入套餐名称',
      type: 'string',
      trigger: 'blur'
    }
  ],
  subscribeCode: [
    {
      required: true,
      message: '请输入套餐标识',
      type: 'string',
      trigger: 'blur'
    }
  ],
  space: [
    {
      pattern: /^\d+(\.\d+)?$/,
      message: '只能输入数字',
      trigger: 'blur'
    }
  ],
  recycle: [
    {
      pattern: /^\d+(\.\d+)?$/,
      message: '只能输入数字',
      trigger: 'blur'
    }
  ],
  pageHistory: [
    {
      pattern: /^\d+(\.\d+)?$/,
      message: '只能输入数字',
      trigger: 'blur'
    }
  ],
  pageWordage: [
    {
      pattern: /^\d+(\.\d+)?$/,
      message: '只能输入数字',
      trigger: 'blur'
    }
  ],
  ai: [
    {
      pattern: /^\d+(\.\d+)?$/,
      message: '只能输入数字',
      trigger: 'blur'
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
      const saveOrUpdate = isUpdate.value ? UpdateSubscribe : AddSubscribe;
      const msg = await saveOrUpdate(form);
      EleMessage.success(msg);
      updateModelValue(false);
      emit('done');
    } catch (e) {
      EleMessage.error(e.message);
    } finally {
      loading.value = false;
    }
  });
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
          ...props.data
        });
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
</script>
