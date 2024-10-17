<template>
  <ele-card header="基础用法">
    <div style="max-width: 260px">
      <ele-table-select
        clearable
        placeholder="请选择"
        value-key="userId"
        label-key="nickname"
        v-model="selectedValue"
        :table-props="tableProps"
        :popper-width="580"
      >
        <!-- 角色列 -->
        <template #roles="{ row }">
          <el-tag
            v-for="item in row.roles"
            :key="item.roleId"
            size="small"
            :disable-transitions="true"
          >
            {{ item.roleName }}
          </el-tag>
        </template>
      </ele-table-select>
    </div>
    <div style="margin-top: 14px">
      <el-button type="primary" @click="setInitValue">回显数据</el-button>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { listUsers } from '@/api/system/user';

  // 表格下拉选中值
  const selectedValue = ref();

  // 表格配置
  const tableProps = reactive({
    datasource: [],
    columns: [
      {
        type: 'index',
        columnKey: 'index',
        width: 48,
        align: 'center',
        showOverflowTooltip: true,
        fixed: 'left'
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
        showOverflowTooltip: true,
        slot: 'nickname'
      },
      {
        prop: 'sexName',
        label: '性别',
        sortable: 'custom',
        showOverflowTooltip: true,
        width: 80
      },
      {
        columnKey: 'roles',
        label: '角色',
        showOverflowTooltip: true,
        slot: 'roles'
      }
    ],
    highlightCurrentRow: true,
    toolbar: false,
    pagination: {
      pageSize: 6,
      layout: 'total, prev, pager, next, jumper'
    },
    footerStyle: { padding: '0px' },
    rowStyle: { cursor: 'pointer' }
  });

  /* 查询表格数据 */
  listUsers().then((data) => {
    tableProps.datasource = data;
  });

  /* 回显数据 */
  const setInitValue = () => {
    selectedValue.value = 40;
  };
</script>
