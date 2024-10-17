<!-- 搜索表单 -->
<template>
  <ele-card :body-style="{ paddingBottom: '2px' }">
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
          <el-form-item label="操作模块">
            <el-input
              clearable
              v-model.trim="form.module"
              placeholder="请输入"
            />
          </el-form-item>
        </el-col>
        <el-col :lg="6" :md="12" :sm="12" :xs="24">
          <el-form-item label="操作时间">
            <el-date-picker
              unlink-panels
              type="datetimerange"
              v-model="dateRange"
              range-separator="-"
              value-format="YYYY-MM-DD HH:mm:ss"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
              class="ele-fluid"
            />
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
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { useFormData } from '@/utils/use-form-data';

  const emit = defineEmits(['search']);

  // 表单数据
  const { form, resetFields } = useFormData({
    username: '',
    module: ''
  });

  // 日期范围
  const dateRange = ref(['', '']);

  /* 搜索 */
  const search = () => {
    const [createTimeStart, createTimeEnd] = dateRange.value;
    emit('search', { ...form, createTimeStart, createTimeEnd });
  };

  /*  重置 */
  const reset = () => {
    resetFields();
    dateRange.value = ['', ''];
    search();
  };
</script>
