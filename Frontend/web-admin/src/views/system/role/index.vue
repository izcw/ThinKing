<template>
  <ele-page>
    <!-- 搜索表单 -->
    <role-search @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="roleId"
        :columns="columns"
        :datasource="datasource"
        v-model:selections="selections"
        cache-key="systemRoleTable"
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
        <template #action="{ row }">
          <el-space>
            <el-link type="primary" :underline="false" @click="openEdit(row)">
              修改
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <el-link type="primary" :underline="false" @click="openAuth(row)">
              分配权限
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-popconfirm
              :width="190"
              placement="top-end"
              title="确定要删除此角色吗？"
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
    </ele-card>
    <!-- 编辑弹窗 -->
    <role-edit v-model="showEdit" :data="current" @done="reload" />
    <!-- 权限分配弹窗 -->
    <role-auth v-model="showAuth" :data="current" />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { Plus, Delete } from '@element-plus/icons-vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';
  import RoleSearch from './components/role-search.vue';
  import RoleEdit from './components/role-edit.vue';
  import RoleAuth from './components/role-auth.vue';
  import { pageRoles, removeRole, removeRoles } from '@/api/system/role';

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
      prop: 'roleName',
      label: '角色名称',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'roleCode',
      label: '角色标识',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'comments',
      label: '备注',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'createTime',
      label: '创建时间',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 200,
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

  // 是否显示权限分配弹窗
  const showAuth = ref(false);

  // 表格数据源
  const datasource = ({ page, limit, where, orders }) => {
    return pageRoles({ ...where, ...orders, page, limit });
  };

  /* 搜索 */
  const reload = (where) => {
    selections.value = [];
    tableRef?.value?.reload({ page: 1, where });
  };

  /* 打开编辑弹窗 */
  const openEdit = (row) => {
    current.value = row ?? null;
    showEdit.value = true;
  };

  /* 打开权限分配弹窗 */
  const openAuth = (row) => {
    current.value = row ?? null;
    showAuth.value = true;
  };

  /* 删除单个 */
  const remove = (row) => {
    const loading = EleMessage.loading('请求中..');
    removeRole(row.roleId)
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
    ElMessageBox.confirm('确定要删除选中的角色吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeRoles(selections.value.map((d) => d.roleId))
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
</script>

<script>
  export default {
    name: 'SystemRole'
  };
</script>
