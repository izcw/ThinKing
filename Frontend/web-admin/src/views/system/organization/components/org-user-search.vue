<!-- 搜索表单 -->
<template>
  <el-form label-width="72px">
    <el-row :gutter="8">
      <el-col :lg="6" :md="12" :sm="12" :xs="24">
        <el-form-item label="用户账号">
          <el-input
            clearable
            v-model.trim="form.username"
            placeholder="请输入"
          />
        </el-form-item>
      </el-col>
      <el-col :lg="6" :md="12" :sm="12" :xs="24">
        <el-form-item label="用户名">
          <el-input
            clearable
            v-model.trim="form.nickname"
            placeholder="请输入"
          />
        </el-form-item>
      </el-col>
      <el-col :lg="6" :md="12" :sm="12" :xs="24">
        <el-form-item label="性别">
          <el-select
            clearable
            v-model="form.sex"
            placeholder="请选择"
            class="ele-fluid"
          >
            <el-option value="1" label="男" />
            <el-option value="2" label="女" />
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :lg="6" :md="12" :sm="12" :xs="24">
        <el-form-item label-width="16px">
          <el-space>
            <el-button type="primary" @click="search">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-space>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>

<script setup>
  import { useFormData } from '@/utils/use-form-data';

  const emit = defineEmits(['search']);

  // 表单数据
  const { form, resetFields } = useFormData({
    username: '',
    nickname: '',
    sex: void 0
  });

  /* 搜索 */
  const search = () => {
    emit('search', form);
  };

  /*  重置 */
  const reset = () => {
    resetFields();
    search();
  };
</script>
