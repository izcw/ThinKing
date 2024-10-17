<!-- 详情弹窗 -->
<template>
  <ele-modal
    title="详情"
    :width="720"
    :model-value="modelValue"
    @update:modelValue="updateModelValue"
  >
    <el-descriptions
      :border="true"
      :column="mobile ? 1 : 2"
      class="detail-table"
    >
      <el-descriptions-item label="操作人">
        <div>{{ data.nickname }}({{ data.username }})</div>
      </el-descriptions-item>
      <el-descriptions-item label="IP地址">
        <div>{{ data.ip }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="操作模块">
        <div>{{ data.module }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="操作功能">
        <div>{{ data.description }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="操作时间">
        <div>{{ data.createTime }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="请求耗时">
        <div v-if="!isNaN(data.spendTime)">{{ data.spendTime / 1000 }}s</div>
      </el-descriptions-item>
      <el-descriptions-item label="请求方式">
        <div>{{ data.requestMethod }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="请求状态">
        <el-tag
          v-if="data.status === 0"
          size="small"
          type="success"
          :disable-transitions="true"
        >
          正常
        </el-tag>
        <el-tag
          v-else-if="data.status === 1"
          size="small"
          type="danger"
          :disable-transitions="true"
        >
          异常
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="请求地址" :span="2">
        <div>{{ data.url }}</div>
      </el-descriptions-item>
      <el-descriptions-item label="调用方法" :span="2">
        <ele-ellipsis :max-line="4">{{ data.method }}</ele-ellipsis>
      </el-descriptions-item>
      <el-descriptions-item label="请求参数" :span="2">
        <ele-ellipsis :max-line="4">{{ data.params }}</ele-ellipsis>
      </el-descriptions-item>
      <el-descriptions-item v-if="data.status === 0" label="返回结果" :span="2">
        <ele-ellipsis
          :max-line="4"
          :tooltip="{
            popperStyle: {
              width: '580px',
              maxWidth: '90%',
              wordBreak: 'break-all'
            },
            offset: 4,
            placement: 'top'
          }"
        >
          {{ data.result }}
        </ele-ellipsis>
      </el-descriptions-item>
      <el-descriptions-item v-else label="异常信息" :span="2">
        <ele-ellipsis
          :max-line="4"
          :tooltip="{
            popperStyle: {
              width: '580px',
              maxWidth: '90%',
              wordBreak: 'break-all'
            },
            offset: 4,
            placement: 'top'
          }"
        >
          {{ data.error }}
        </ele-ellipsis>
      </el-descriptions-item>
    </el-descriptions>
  </ele-modal>
</template>

<script setup>
  import { useMobile } from '@/utils/use-mobile';

  const emit = defineEmits(['update:modelValue']);

  defineProps({
    // 弹窗是否打开
    modelValue: Boolean,
    // 修改回显的数据
    data: Object
  });

  /* 更新modelValue */
  const updateModelValue = (value) => {
    emit('update:modelValue', value);
  };

  const { mobile } = useMobile();
</script>

<style lang="scss" scoped>
  .detail-table :deep(.el-descriptions__label) {
    width: 88px;
    text-align: right;
    font-weight: normal;
  }
</style>
