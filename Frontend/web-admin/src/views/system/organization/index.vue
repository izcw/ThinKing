<template>
  <ele-page flex-table :multi-card="false" style="min-height: 420px">
    <ele-card
      flex-table
      :body-style="{ padding: '0 0 0 16px', overflow: 'hidden' }"
    >
      <ele-split-panel
        flex-table
        size="266px"
        allow-collapse
        :custom-style="{ borderWidth: '0 1px 0 0', padding: '16px 0' }"
        :body-style="{ padding: '16px 16px 16px 0', overflow: 'hidden' }"
        :style="{ height: '100%', overflow: 'visible' }"
      >
        <el-space style="display: flex; margin-bottom: 12px">
          <el-button
            type="primary"
            class="ele-btn-icon"
            :icon="Plus"
            @click="openEdit()"
          >
            新建
          </el-button>
          <el-button
            type="warning"
            :disabled="!current"
            class="ele-btn-icon"
            :icon="EditPen"
            @click="openEdit(current)"
          >
            修改
          </el-button>
          <el-button
            type="danger"
            :disabled="!current"
            class="ele-btn-icon"
            :icon="Delete"
            @click="remove"
          >
            删除
          </el-button>
        </el-space>
        <div class="org-tree">
          <el-tree
            ref="treeRef"
            :data="data"
            highlight-current
            node-key="organizationId"
            :props="{ label: 'organizationName' }"
            :expand-on-click-node="false"
            :default-expand-all="true"
            @node-click="onNodeClick"
          />
        </div>
        <template #body>
          <org-users v-if="current" :organization-id="current.organizationId" />
        </template>
      </ele-split-panel>
    </ele-card>
    <!-- 编辑弹窗 -->
    <org-edit
      v-model="showEdit"
      :data="editData"
      :organization-id="current?.organizationId"
      @done="query"
    />
  </ele-page>
</template>

<script setup>
  import { ref, nextTick } from 'vue';
  import { Plus, Delete, EditPen } from '@element-plus/icons-vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage, toTree } from 'ele-admin-plus/es';
  import OrgUsers from './components/org-users.vue';
  import OrgEdit from './components/org-edit.vue';
  import {
    listOrganizations,
    removeOrganization
  } from '@/api/system/organization';

  // 树组件
  const treeRef = ref(null);

  // 加载状态
  const loading = ref(true);

  // 树形数据
  const data = ref([]);

  // 选中数据
  const current = ref(null);

  // 是否显示表单弹窗
  const showEdit = ref(false);

  // 编辑回显数据
  const editData = ref(null);

  /* 查询 */
  const query = () => {
    loading.value = true;
    listOrganizations()
      .then((list) => {
        loading.value = false;
        data.value = toTree({
          data: list,
          idField: 'organizationId',
          parentIdField: 'parentId'
        });
        nextTick(() => {
          onNodeClick(data.value[0]);
        });
      })
      .catch((e) => {
        loading.value = false;
        EleMessage.error(e.message);
      });
  };

  /* 选择数据 */
  const onNodeClick = (row) => {
    if (row && row.organizationId) {
      current.value = row;
      treeRef.value?.setCurrentKey(row.organizationId);
    } else {
      current.value = null;
    }
  };

  /* 打开编辑弹窗 */
  const openEdit = (item) => {
    editData.value = item ?? null;
    showEdit.value = true;
  };

  /* 删除 */
  const remove = () => {
    ElMessageBox.confirm('确定要删除选中的机构吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeOrganization(current.value?.organizationId)
          .then((msg) => {
            loading.close();
            EleMessage.success(msg);
            query();
          })
          .catch((e) => {
            loading.close();
            EleMessage.error(e.message);
          });
      })
      .catch(() => {});
  };

  query();
</script>

<script>
  export default {
    name: 'SystemOrganization'
  };
</script>

<style lang="scss" scoped>
  .org-tree {
    flex: 1;
    padding-right: 16px;
    overflow: auto;

    :deep(.el-tree-node__content) {
      height: 36px;
      border-radius: var(--el-border-radius-base);

      & > .el-tree-node__expand-icon {
        padding: 12px;
      }
    }
  }
</style>
