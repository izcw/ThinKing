<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      row-key="userId"
      :columns="columns"
      :datasource="datasource"
      :toolbar="{ title: '可展开行' }"
    >
      <template #expand="{ row }">
        <div style="padding: 12px 26px">
          <div>
            <span>手机号码：</span>
            <span>{{ row.phone }}</span>
          </div>
          <div style="margin-top: 12px">
            <span>所属机构：</span>
            <span>{{ row.organizationName }}</span>
          </div>
          <div style="margin-top: 12px">
            <span>角&emsp;&emsp;色：</span>
            <span>
              <el-tag
                v-for="item in row.roles"
                :key="item.roleId"
                size="small"
                :disable-transitions="true"
              >
                {{ item.roleName }}
              </el-tag>
            </span>
          </div>
          <div style="margin-top: 12px">
            <span>状&emsp;&emsp;态：</span>
            <span>
              <ele-dot v-if="row.status === 0" text="正常" size="8px" />
              <ele-dot
                v-else-if="row.status === 1"
                text="冻结"
                type="danger"
                :ripple="false"
                size="8px"
              />
            </span>
          </div>
        </div>
      </template>
    </ele-pro-table>
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
      type: 'expand',
      columnKey: 'expand',
      width: 48,
      align: 'center',
      slot: 'expand'
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
      align: 'center'
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
