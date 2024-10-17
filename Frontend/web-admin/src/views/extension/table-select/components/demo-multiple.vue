<template>
  <ele-card header="多选">
    <div style="max-width: 260px">
      <ele-table-select
        multiple
        clearable
        placeholder="请选择"
        value-key="userId"
        label-key="nickname"
        v-model="selectedValue"
        :table-props="tableProps"
        :popper-width="580"
        :disabled="disabled"
        :max-tag-text-length="3"
        :max-tag-count="5"
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
    <div style="margin-top: 12px; display: flex; align-items: center">
      <div style="padding-right: 12px">禁用:</div>
      <el-radio-group v-model="disabled">
        <el-radio :label="false">否</el-radio>
        <el-radio :label="true">是</el-radio>
      </el-radio-group>
    </div>
    <div style="margin-top: 8px">
      <el-button type="primary" @click="setInitValue">回显数据</el-button>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { listUsers } from '@/api/system/user';

  // 表格下拉选中值
  const selectedValue = ref([]);

  // 表格配置
  const tableProps = reactive({
    datasource: [],
    columns: [
      {
        type: 'selection',
        columnKey: 'selection',
        width: 48,
        align: 'center',
        fixed: 'left',
        reserveSelection: true
      },
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
    toolbar: false,
    pagination: {
      pageSize: 6,
      layout: 'total, prev, pager, next, jumper'
    },
    footerStyle: { padding: '0px' },
    rowClickChecked: true
  });

  // 禁用
  const disabled = ref(false);

  /* 查询表格数据 */
  listUsers().then((data) => {
    tableProps.datasource = data;
  });

  /* 回显数据 */
  const setInitValue = () => {
    selectedValue.value = [40, 44, 45];
  };
</script>
