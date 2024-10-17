<template>
  <org-user-search @search="reload" @add="openEdit()" />
  <!-- 表格 -->
  <ele-pro-table
    ref="tableRef"
    row-key="userId"
    :columns="columns"
    :datasource="datasource"
    v-model:selections="selections"
    cache-key="systemOrgUserTable"
    :toolbar="{ bodyStyle: { marginTop: 0 } }"
  >
    <template #toolbar>
      <el-space>
        <el-button
          type="primary"
          class="ele-btn-icon"
          :icon="Plus"
          @click="openEdit()"
        >
          新建
        </el-button>
        <el-button
          type="danger"
          class="ele-btn-icon"
          :icon="Delete"
          @click="removeBatch"
        >
          删除
        </el-button>
      </el-space>
    </template>
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
    <template #status="{ row }">
      <el-switch
        :model-value="row.status === 0"
        @change="(checked) => editStatus(checked, row)"
      />
    </template>
    <template #action="{ row }">
      <el-space>
        <el-link type="primary" :underline="false" @click="openEdit(row)">
          修改
        </el-link>
        <el-divider direction="vertical" style="margin: 0" />
        <ele-popconfirm
          :width="190"
          placement="top-end"
          title="确定要删除此用户吗？"
          :popper-options="{
            modifiers: [
              { name: 'arrow', options: { padding: 20 } },
              { name: 'offset', options: { offset: [20, 6] } }
            ]
          }"
          @confirm="remove(row)"
        >
          <template #reference>
            <el-link type="danger" :underline="false">删除</el-link>
          </template>
        </ele-popconfirm>
      </el-space>
    </template>
  </ele-pro-table>
  <!-- 编辑弹窗 -->
  <org-user-edit
    :data="current"
    v-model="showEdit"
    :organization-id="organizationId"
    @done="reload"
  />
</template>

<script setup>
  import { ref, watch } from 'vue';
  import { Plus, Delete } from '@element-plus/icons-vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';
  import OrgUserSearch from './org-user-search.vue';
  import OrgUserEdit from './org-user-edit.vue';
  import {
    pageUsers,
    removeUser,
    removeUsers,
    updateUserStatus
  } from '@/api/system/user';

  const props = defineProps({
    // 机构 id
    organizationId: Number
  });

  // 表格实例
  const tableRef = ref(null);

  // 表格列配置
  const columns = ref([
    {
      type: 'selection',
      columnKey: 'selection',
      width: 48,
      align: 'center',
      fixed: 'left'
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
      showOverflowTooltip: true
    },
    {
      prop: 'sexName',
      label: '性别',
      sortable: 'custom',
      showOverflowTooltip: true,
      width: 90
    },
    {
      columnKey: 'roles',
      label: '角色',
      showOverflowTooltip: true,
      slot: 'roles'
    },
    {
      prop: 'createTime',
      label: '创建时间',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'status',
      label: '状态',
      width: 90,
      align: 'center',
      sortable: 'custom',
      showOverflowTooltip: true,
      slot: 'status'
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 100,
      align: 'center',
      resizable: false,
      slot: 'action'
    }
  ]);

  // 表格选中数据
  const selections = ref([]);

  // 当前编辑数据
  const current = ref(null);

  // 是否显示编辑弹窗
  const showEdit = ref(false);

  // 表格数据源
  const datasource = ({ page, limit, where, orders }) => {
    return pageUsers({
      ...where,
      ...orders,
      page,
      limit,
      organizationId: props.organizationId
    });
  };

  /* 搜索 */
  const reload = (where) => {
    tableRef?.value?.reload({ page: 1, where });
  };

  /* 打开编辑弹窗 */
  const openEdit = (row) => {
    current.value = row ?? null;
    showEdit.value = true;
  };

  /* 删除单个 */
  const remove = (row) => {
    const loading = EleMessage.loading('请求中..');
    removeUser(row.userId)
      .then((msg) => {
        loading.close();
        EleMessage.success(msg);
        reload();
      })
      .catch((e) => {
        loading.close();
        EleMessage.error(e.message);
      });
  };

  /* 批量删除 */
  const removeBatch = () => {
    if (!selections.value.length) {
      EleMessage.error('请至少选择一条数据');
      return;
    }
    ElMessageBox.confirm('确定要删除选中的用户吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeUsers(selections.value.map((d) => d.userId))
          .then((msg) => {
            loading.close();
            EleMessage.success(msg);
            reload();
          })
          .catch((e) => {
            loading.close();
            EleMessage.error(e.message);
          });
      })
      .catch(() => {});
  };

  /* 修改用户状态 */
  const editStatus = (checked, row) => {
    const status = checked ? 0 : 1;
    updateUserStatus(row.userId, status)
      .then((msg) => {
        row.status = status;
        EleMessage.success(msg);
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  // 监听机构 id 变化
  watch(
    () => props.organizationId,
    () => {
      reload();
    }
  );
</script>
