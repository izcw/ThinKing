<!-- 搜索表单 -->
<template>
  <ele-card :body-style="{ paddingBottom: '2px' }">
    <el-form label-width="72px">
      <el-row :gutter="8">
        <el-col :lg="6" :md="12" :sm="12" :xs="24">
          <el-form-item label="套餐名称">
            <el-input clearable v-model.trim="form.subscribeName" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :lg="6" :md="12" :sm="12" :xs="24">
          <el-form-item label="套餐标识">
            <el-input clearable v-model.trim="form.subscribeCode" placeholder="请输入" />
          </el-form-item>
        </el-col>
        <el-col :lg="6" :md="12" :sm="12" :xs="24">
          <el-form-item label="状态">
            <el-select clearable v-model="form.status" placeholder="请选择" class="ele-fluid">
              <el-option v-for="(item, index) in statusListData" :key="index" :value="item.code"
                :label="item.describe" />
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
  </ele-card>
</template>

<script setup>
import { ref } from 'vue';
import { ArrowDown, ArrowUp } from '@element-plus/icons-vue';
import { useFormData } from '@/utils/use-form-data';
import { SubscribeListStatus } from '@/api/common/index.js';
const emit = defineEmits(['search']);


// 表单数据
const { form, resetFields } = useFormData({
  subscribeName: '',
  subscribeCode: '',
  status: void 0
});

// 搜索表单是否展开
const searchExpand = ref(false);

/* 搜索 */
const search = () => {
  emit('search', form)
};

/*  重置 */
const reset = () => {
  resetFields();
  search();
};

// 获取状态数据
let statusListData = ref()
SubscribeListStatus()
  .then((response) => {
    statusListData.value = response;
  })
  .catch((e) => {
    EleMessage.error(e.message);
  });
</script>
