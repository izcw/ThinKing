<template>
  <ele-page>
    <!-- 搜索表单 -->
    <user-search @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="userId"
        :columns="columns"
        :datasource="datasource"
        v-model:selections="selections"
        cache-key="systemUserTable"
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
            <el-button class="ele-btn-icon" :icon="Upload" @click="openImport">
              导入
            </el-button>
          </el-space>
        </template>
        <template #nickname="{ row }">
          <router-link
            :to="'/system/user/details?id=' + row.userId"
            style="text-decoration: none"
          >
            <el-link type="primary" :underline="false">
              {{ row.nickname }}
            </el-link>
          </router-link>
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
            <el-link type="primary" :underline="false" @click="resetPsw(row)">
              重置密码
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
    </ele-card>
    <!-- 编辑弹窗 -->
    <user-edit v-model="showEdit" :data="current" @done="reload" />
    <!-- 导入弹窗 -->
    <user-import v-model="showImport" @done="reload" />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { Plus, Delete, Upload } from '@element-plus/icons-vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';
  import UserSearch from './components/user-search.vue';
  import UserEdit from './components/user-edit.vue';
  import UserImport from './components/user-import.vue';
  import {
    pageUsers,
    removeUser,
    removeUsers,
    updateUserStatus,
    updateUserPassword
  } from '@/api/system/user';

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
      showOverflowTooltip: true,
      slot: 'nickname'
    },
    {
      prop: 'sex',
      label: '性别',
      sortable: 'custom',
      showOverflowTooltip: true,
      width: 90,
      align: 'center'
    },
    {
      prop: 'phone',
      label: '手机号',
      sortable: 'custom',
      showOverflowTooltip: true
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

  // 是否显示用户导入弹窗
  const showImport = ref(false);

  // 表格数据源
  const datasource = ({ page, limit, where, orders }) => {
    return pageUsers({ ...where, ...orders, page, limit });
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

  /* 打开编辑弹窗 */
  const openImport = () => {
    showImport.value = true;
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

  /* 重置用户密码 */
  const resetPsw = (row) => {
    ElMessageBox.confirm('确定要重置此用户的密码为"123456"吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        updateUserPassword(row.userId)
          .then((msg) => {
            loading.close();
            EleMessage.success(msg);
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
</script>

<script>
  export default {
    name: 'SystemUser'
  };
</script>
