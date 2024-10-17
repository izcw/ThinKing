<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      ref="tableRef"
      row-key="userId"
      :columns="columns"
      :datasource="datasource"
      :toolbar="{ title: '可控的排序和筛选' }"
    >
      <template #tools>
        <el-button type="primary" class="ele-btn-icon" @click="setSorter">
          设置用户名排序
        </el-button>
        <el-button type="primary" class="ele-btn-icon" @click="resetAll">
          重置排序和筛选
        </el-button>
      </template>
    </ele-pro-table>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { pageUsers } from '@/api/system/user';

  // 表格实例
  const tableRef = ref(null);

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
      ]
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

  /* 设置排序 */
  const setSorter = () => {
    tableRef.value?.sort('nickname', 'descending');
  };

  /* 重置排序和筛选 */
  const resetAll = () => {
    tableRef.value?.clearSort();
    tableRef.value?.clearFilter();
    tableRef.value?.reload({ sorter: {}, filter: {} });
  };
</script>
