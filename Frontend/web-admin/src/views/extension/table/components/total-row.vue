<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      row-key="piece_no"
      :columns="columns"
      :datasource="datasource"
      :show-summary="true"
      :summary-method="getSummaries"
      :height="fixedHeight ? 240 : 'auto'"
      :toolbar="{ title: '合计行' }"
      class="demo-table"
    >
      <template #toolkit>
        <span>&emsp;固定高度:&nbsp;</span>
        <el-switch v-model="fixedHeight" size="small" />
        <el-divider direction="vertical" />
      </template>
    </ele-pro-table>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { getPieceList } from '@/api/example';

  // 表格固定高度
  const fixedHeight = ref(false);

  // 表格列配置
  const columns = ref([
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      prop: 'piece_no',
      label: '案卷档号',
      width: 222,
      showOverflowTooltip: true
    },
    {
      prop: 'title',
      label: '案卷题名',
      showOverflowTooltip: true
    },
    {
      prop: 'year',
      label: '年度',
      showOverflowTooltip: true
    },
    {
      prop: 'retention',
      label: '保管期限',
      showOverflowTooltip: true
    },
    {
      prop: 'secret',
      label: '密级',
      showOverflowTooltip: true
    },
    {
      prop: 'amount',
      label: '件数',
      showOverflowTooltip: true
    }
  ]);

  // 表格数据源
  const datasource = ({ page, limit }) => {
    // return getPieceList({ page, limit });
  };

  /* 表格合计行 */
  const getSummaries = ({ columns, data }) => {
    const sums = [];
    columns.forEach((column, index) => {
      if (index === 1) {
        sums[index] = '合计';
      } else if (column.property === 'amount') {
        sums[index] = data
          .map((item) => Number(item[column.property]))
          .reduce((prev, curr) => {
            const value = Number(curr);
            if (!isNaN(value)) {
              return prev + curr;
            } else {
              return prev;
            }
          }, 0);
      }
    });
    return sums;
  };
</script>

<style scoped>
  .demo-table :deep(.el-table__footer-wrapper) {
    border-top: none;
  }
</style>
