<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      row-key="userId"
      :columns="columns"
      :datasource="datasource"
      :default-sort="{ prop: 'username', order: 'ascending' }"
      :toolbar="{ title: '设置默认排序和筛选' }"
    />
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { pageUsers } from '@/api/system/user';

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
      prop: 'username',
      label: '用户账号',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'nickname',
      label: '用户名',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      columnKey: 'sexName',
      prop: 'sexName',
      label: '性别',
      sortable: 'custom',
      showOverflowTooltip: true,
      width: 90,
      align: 'center',
      filterMultiple: false,
      filters: [
        {
          text: '男',
          value: '男'
        },
        {
          text: '女',
          value: '女'
        }
      ],
      filteredValue: ['男']
    },
    {
      prop: 'phone',
      label: '手机号',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'createTime',
      label: '创建时间',
      sortable: 'custom',
      showOverflowTooltip: true
    }
  ]);

  // 表格数据源
  const datasource = ({ page, limit, orders, filters }) => {
    return pageUsers({ ...orders, ...filters, page, limit });
  };
</script>
