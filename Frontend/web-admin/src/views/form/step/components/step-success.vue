<template>
  <el-result icon="success" title="操作成功">
    <template #sub-title>
      <ele-text type="placeholder">预计两小时内到账</ele-text>
    </template>
    <template #extra>
      <div style="margin-bottom: 24px">
        <el-space size="large">
          <el-button type="primary" @click="back">再转一笔</el-button>
          <el-button>查看账单</el-button>
        </el-space>
      </div>
      <el-descriptions
        :border="true"
        :column="1"
        size="large"
        class="detail-table"
        style="width: 680px; max-width: 100%"
      >
        <el-descriptions-item label="付款账户">
          <div>{{ data.account }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="收款账户">
          <div>{{ data.receiver }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="收款人姓名">
          <div>{{ data.name }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="转账金额">
          <div style="display: flex; align-items: flex-end">
            <ele-text size="xl" style="line-height: 1">
              {{ data.amount }}&nbsp;
            </ele-text>
            <div style="line-height: 1.15">&nbsp;元</div>
          </div>
        </el-descriptions-item>
      </el-descriptions>
    </template>
  </el-result>
</template>

<script setup>
  defineProps({
    data: Object
  });

  const emit = defineEmits(['back']);

  const back = () => {
    emit('back');
  };
</script>

<style lang="scss" scoped>
  .detail-table :deep(.el-descriptions__label) {
    width: 120px;
    text-align: right;
    font-weight: normal;
  }
</style>
