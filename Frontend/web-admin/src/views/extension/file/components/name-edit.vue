<template>
  <ele-modal
    form
    :width="460"
    title="重命名"
    :model-value="modelValue"
    @update:modelValue="updateModelValue"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="文件/夹名称" prop="name">
        <el-input
          clearable
          :maxlength="20"
          v-model="form.name"
          placeholder="请输入文件/夹名称"
        />
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
  import { EleMessage } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { updateUserFile } from '@/api/system/user-file';

  const emit = defineEmits(['done', 'update:modelValue']);

  const props = defineProps({
    // 弹窗是否打开
    modelValue: Boolean,
    // 文件数据
    data: Object
  });

  //
  const formRef = ref(null);

  // 提交状态
  const loading = ref(false);

  // 表单数据
  const { form, resetFields } = useFormData({ name: '' });

  // 表单验证规则
  const rules = reactive({
    name: [
      {
        required: true,
        message: '请输入文件/夹名称',
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
      updateUserFile({ ...form, id: props.data?.id })
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
      if (!modelValue) {
        resetFields();
        formRef.value?.clearValidate();
      } else if (props.data) {
        form.name = props.data.name;
      }
    }
  );
</script>
