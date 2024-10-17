<template>
  <el-form label-width="60px" size="small" class="demo-search">
    <el-row>
      <el-col :lg="8" :md="8" :sm="24" :xs="24">
        <el-form-item label="用户账号">
          <el-input
            clearable
            v-model.trim="form.username"
            placeholder="请输入"
          />
        </el-form-item>
      </el-col>
      <el-col :lg="8" :md="8" :sm="24" :xs="24">
        <el-form-item label="用户名">
          <el-input
            clearable
            v-model.trim="form.nickname"
            placeholder="请输入"
          />
        </el-form-item>
      </el-col>
      <el-col :lg="8" :md="8" :sm="24" :xs="24">
        <el-form-item label-width="12px">
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
    sexName: ''
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

<style lang="scss" scoped>
  .demo-search :deep(.el-form-item) {
    margin-bottom: 8px;
  }
</style>
