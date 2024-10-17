<!-- 机构编辑弹窗 -->
<template>
  <ele-modal
    form
    :width="620"
    :model-value="modelValue"
    :title="isUpdate ? '修改机构' : '添加机构'"
    @update:modelValue="updateModelValue"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
      <el-row :gutter="16">
        <el-col :sm="12" :xs="24">
          <el-form-item label="上级机构" prop="parentId">
            <el-tree-select
              clearable
              check-strictly
              default-expand-all
              :data="organizations"
              node-key="organizationId"
              :props="{ label: 'organizationName' }"
              v-model="form.parentId"
              placeholder="请选择上级机构"
              class="ele-fluid"
            />
          </el-form-item>
          <el-form-item label="机构名称" prop="organizationName">
            <el-input
              clearable
              :maxlength="20"
              v-model="form.organizationName"
              placeholder="请输入机构名称"
            />
          </el-form-item>
          <el-form-item label="机构全称" prop="organizationFullName">
            <el-input
              clearable
              :maxlength="100"
              v-model="form.organizationFullName"
              placeholder="请输入机构全称"
            />
          </el-form-item>
          <el-form-item label="机构代码">
            <el-input
              clearable
              :maxlength="20"
              v-model="form.organizationCode"
              placeholder="请输入机构代码"
            />
          </el-form-item>
        </el-col>
        <el-col :sm="12" :xs="24">
          <el-form-item label="机构类型" prop="organizationType">
            <org-type-select v-model="form.organizationType" />
          </el-form-item>
          <el-form-item label="排序号" prop="sortNumber">
            <el-input-number
              :min="0"
              :max="99999"
              v-model="form.sortNumber"
              placeholder="请输入排序号"
              controls-position="right"
              class="ele-fluid"
            />
          </el-form-item>
          <el-form-item label="备注">
            <el-input
              :rows="3"
              type="textarea"
              :maxlength="200"
              v-model="form.comments"
              placeholder="请输入备注"
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
  import { EleMessage, toTree } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import OrgTypeSelect from './org-type-select.vue';
  import {
    addOrganization,
    updateOrganization,
    listOrganizations
  } from '@/api/system/organization';

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
    organizationId: void 0,
    parentId: void 0,
    organizationName: '',
    organizationFullName: '',
    organizationCode: '',
    organizationType: void 0,
    sortNumber: void 0,
    comments: ''
  });

  // 表单验证规则
  const rules = reactive({
    organizationName: [
      {
        required: true,
        message: '请输入机构名称',
        type: 'string',
        trigger: 'blur'
      }
    ],
    organizationFullName: [
      {
        required: true,
        message: '请输入机构全称',
        type: 'string',
        trigger: 'blur'
      }
    ],
    organizationType: [
      {
        required: true,
        message: '请选择机构类型',
        type: 'string',
        trigger: 'blur'
      }
    ],
    sortNumber: [
      {
        required: true,
        message: '请输入排序号',
        type: 'number',
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
      const saveOrUpdate = isUpdate.value
        ? updateOrganization
        : addOrganization;
      saveOrUpdate({
        ...form,
        parentId: form.parentId || 0
      })
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
            parentId: props.data.parentId === 0 ? void 0 : props.data.parentId
          });
          isUpdate.value = true;
        } else {
          form.parentId = props.organizationId;
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
