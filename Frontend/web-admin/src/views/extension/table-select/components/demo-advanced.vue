<template>
  <ele-card header="可搜索">
    <div style="max-width: 260px">
      <ele-table-select
        ref="selectRef"
        multiple
        clearable
        placeholder="请选择"
        value-key="userId"
        label-key="nickname"
        v-model="selectedValue"
        :table-props="tableProps"
        :popper-width="580"
        :init-value="initValue"
      >
        <demo-advanced-search @search="onSearch" />
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
  import DemoAdvancedSearch from './demo-advanced-search.vue';
  import { pageUsers } from '@/api/system/user';

  // 表格下拉选中值
  const selectedValue = ref([]);

  // 选择框实例
  const selectRef = ref(null);

  // 表格配置
  const tableProps = reactive({
    datasource: ({ page, limit, where, orders }) => {
      return pageUsers({ ...where, ...orders, page, limit });
    },
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

  // 回显值
  const initValue = ref();

  /* 回显数据 */
  const setInitValue = () => {
    //selectedValue.value = [40, 44, 45];
    initValue.value = [
      {
        userId: 40,
        nickname: '管理员'
      },
      {
        userId: 44,
        nickname: '用户四'
      },
      {
        userId: 45,
        nickname: '用户五'
      }
    ];
  };

  /* 搜索 */
  const onSearch = (where) => {
    selectRef.value?.tableRef?.reload({ where, page: 1 });
  };
</script>
