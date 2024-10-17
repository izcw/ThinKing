<template>
  <ele-card>
    <ele-pro-table
      :border="true"
      row-key="userId"
      :columns="columns"
      :datasource="datasource"
      :span-method="spanMethod"
      :toolbar="{ title: '合并单元格' }"
    />
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { pageUserScores } from '@/api/example';

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
      columnKey: 'userName',
      prop: 'userName',
      label: '姓名',
      showOverflowTooltip: true
    },
    {
      prop: 'courseName',
      label: '课程',
      showOverflowTooltip: true
    },
    {
      prop: 'score',
      label: '得分',
      showOverflowTooltip: true
    }
  ]);

  // 表格数据源
  const datasource = () => {
    return pageUserScores();
  };

  /* 合并表格单元格 */
  const spanMethod = ({ row, column }) => {
    if (column.columnKey === 'userName') {
      return [row.userNameRowSpan, 1];
    }
    return [1, 1];
  };
</script>
