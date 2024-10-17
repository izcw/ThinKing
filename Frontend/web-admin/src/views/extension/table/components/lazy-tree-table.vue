<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      row-key="menuId"
      :columns="columns"
      :datasource="datasource"
      :toolbar="{ title: '树形表格懒加载' }"
      :pagination="false"
      :lazy="true"
    />
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { listMenus } from '@/api/system/menu';

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
      prop: 'title',
      label: '菜单名称',
      slot: 'title',
      showOverflowTooltip: true
    },
    {
      prop: 'path',
      label: '路由地址',
      showOverflowTooltip: true
    },
    {
      prop: 'component',
      label: '组件路径',
      showOverflowTooltip: true
    },
    {
      prop: 'sortNumber',
      label: '排序',
      width: 90,
      align: 'center'
    },
    {
      prop: 'createTime',
      label: '创建时间',
      showOverflowTooltip: true
    }
  ]);

  // 表格数据源
  const datasource = ({ where, parent }) => {
    return listMenus({ ...where, parentId: parent?.menuId || 0 });
  };
</script>
