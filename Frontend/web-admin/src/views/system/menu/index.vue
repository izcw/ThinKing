<template>
  <ele-page>
    <!-- 搜索表单 -->
    <menu-search @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        sticky
        ref="tableRef"
        row-key="menuId"
        :columns="columns"
        :datasource="datasource"
        :default-expand-all="false"
        :pagination="false"
        cache-key="systemMenuTable"
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
              class="ele-btn-icon"
              :icon="ColumnHeightOutlined"
              @click="expandAll"
            >
              展开全部
            </el-button>
            <el-button
              class="ele-btn-icon"
              :icon="VerticalAlignMiddleOutlined"
              @click="foldAll"
            >
              折叠全部
            </el-button>
          </el-space>
        </template>
        <template #title="{ row }">
          <el-icon
            v-if="row.icon"
            :size="16"
            style="margin-right: 8px; vertical-align: -2px"
          >
            <component :is="row.icon" />
          </el-icon>
          <span>{{ row.title }}</span>
        </template>
        <template #menuType="{ row }">
          <el-tag
            v-if="isExternalLink(row.path)"
            size="small"
            type="danger"
            :disable-transitions="true"
          >
            外链
          </el-tag>
          <el-tag
            v-else-if="isExternalLink(row.component)"
            size="small"
            type="warning"
            :disable-transitions="true"
          >
            内链
          </el-tag>
          <el-tag
            v-else-if="isDirectory(row)"
            size="small"
            :disable-transitions="true"
          >
            目录
          </el-tag>
          <el-tag
            v-else-if="row.menuType === 0"
            size="small"
            type="success"
            :disable-transitions="true"
          >
            菜单
          </el-tag>
          <el-tag
            v-else-if="row.menuType === 1"
            size="small"
            type="info"
            :disable-transitions="true"
          >
            按钮
          </el-tag>
        </template>
        <template #action="{ row }">
          <el-space>
            <el-link
              type="primary"
              :underline="false"
              @click="openEdit(null, row.menuId)"
            >
              添加
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <el-link type="primary" :underline="false" @click="openEdit(row)">
              修改
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-popconfirm
              :width="190"
              placement="top-end"
              title="确定要删除此菜单吗？"
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
    <menu-edit
      v-model="showEdit"
      :data="current"
      :parent-id="parentId"
      @done="reload"
    />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { Plus } from '@element-plus/icons-vue';
  import { EleMessage, isExternalLink, toTree } from 'ele-admin-plus/es';
  import {
    ColumnHeightOutlined,
    VerticalAlignMiddleOutlined
  } from '@/components/icons';
  import MenuSearch from './components/menu-search.vue';
  import MenuEdit from './components/menu-edit.vue';
  import { listMenus, removeMenu } from '@/api/system/menu';

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
      prop: 'title',
      label: '菜单名称',
      slot: 'title',
      showOverflowTooltip: true,
      minWidth: 160
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
      prop: 'authority',
      label: '权限标识',
      showOverflowTooltip: true
    },
    {
      prop: 'sortNumber',
      label: '排序',
      width: 90
    },
    {
      prop: 'hide',
      label: '可见',
      width: 90,
      formatter: (row) => ['是', '否'][row.hide]
    },
    {
      prop: 'menuType',
      label: '类型',
      slot: 'menuType',
      width: 90
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 180,
      align: 'center',
      resizable: false,
      slot: 'action'
    }
  ]);

  // 当前编辑数据
  const current = ref(null);

  // 是否显示编辑弹窗
  const showEdit = ref(false);

  // 上级菜单id
  const parentId = ref();

  // 表格数据源
  const datasource = async ({ where }) => {
    const data = await listMenus({ ...where });
    return toTree({
      data,
      idField: 'menuId',
      parentIdField: 'parentId'
    });
  };

  /* 刷新表格 */
  const reload = (where) => {
    tableRef?.value?.reload({ where });
  };

  /* 打开编辑弹窗 */
  const openEdit = (row, id) => {
    current.value = row ?? null;
    parentId.value = id;
    showEdit.value = true;
  };

  /* 删除单个 */
  const remove = (row) => {
    if (row.children?.length) {
      EleMessage.error('请先删除子节点');
      return;
    }
    const loading = EleMessage.loading('请求中..');
    removeMenu(row.menuId)
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

  /* 展开全部 */
  const expandAll = () => {
    tableRef.value?.toggleRowExpansionAll(true);
  };

  /* 折叠全部 */
  const foldAll = () => {
    tableRef.value?.toggleRowExpansionAll(false);
  };

  /* 判断是否是目录 */
  const isDirectory = (d) => {
    return !!d.children?.length && !d.component;
  };
</script>

<script>
  import * as MenuIcons from '@/layout/menu-icons';

  export default {
    name: 'SystemMenu',
    components: MenuIcons
  };
</script>
