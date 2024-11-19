<template>
  <ele-page hide-footer :flex-table="fixedHeight" style="min-height: 600px">
    <!-- 搜索表单 -->
    <search-form @search="onSearch" />
    <ele-card :flex-table="fixedHeight">
      <!-- 提示信息 -->
      <ele-alert show-icon :closable="false" :style="{ marginBottom: toolDefault ? '12px' : '4px' }">
        <template #title>
          <span>已选择&nbsp;</span>
          <ele-text strong type="primary" tag="span">
            {{ selections.length }}
          </ele-text>
          <span>&nbsp;项数据&emsp;</span>
          <span>其中冻结状态的客户有 </span>
          <b>{{ selections.filter((d) => d.status === 1).length }} 个 &emsp;</b>
          <el-link type="primary" :underline="false" style="vertical-align: 0px" @click="clearChoose">
            清空
          </el-link>
        </template>
      </ele-alert>
      <!-- 表格 -->
      <ele-pro-table ref="tableRef" row-key="userId" :border="bordered" :stripe="striped" row-click-checked
        highlight-current-row :toolbar="{ theme: toolDefault ? 'default' : 'plain' }" :columns="columns"
        :datasource="datasource" v-model:current="current" v-model:selections="selections"
        :default-sort="{ prop: 'create_time', order: 'descending' }" @done="onDone">
        <template #toolbar>
          <el-space>
            <el-button type="primary" :icon="Plus" class="ele-btn-icon" @click="openEdit()">
              新建
            </el-button>
            <ele-dropdown :disabled="!selections.length" :items="[
              { title: '批量删除', command: 'del' },
              { title: '批量修改', command: 'edit' }
            ]" @command="onDropClick">
              <el-button :disabled="!selections.length" class="ele-btn-icon">
                <span>批量操作</span>
                <el-icon :size="12" style="margin: 0 -4px 0 4px">
                  <arrow-down />
                </el-icon>
              </el-button>
            </ele-dropdown>
          </el-space>
        </template>
        <!-- 头像列 -->
        <template #avatar="{ row }">
          <el-avatar v-if="row.avatar" :src="API_BASE_URL + row.avatar" :size="32" @click.stop=""
            style="vertical-align: -8px" />
          <el-avatar v-else :size="32" style="background: #1677ff; vertical-align: -8px" @click.stop="">
            {{
              row.nickname && row.nickname.length > 2
                ? row.nickname.substring(row.nickname.length - 2)
                : row.nickname
            }}
          </el-avatar>
        </template>
        <!-- 客户名列 -->
        <template #nickname="{ row }">
          <router-link :to="'/list/basic/details/' + row.userId" style="text-decoration: none" @click.stop="">
            <el-link type="primary" :underline="false">
              {{ row.nickname }}
            </el-link>
          </router-link>
        </template>
        <!-- 状态列 -->
        <template #status="{ row }">
          <ele-dot v-if="row.status === 0" text="正常" size="8px" />
          <ele-dot v-else-if="row.status === 1" text="冻结" type="danger" :ripple="false" size="8px" />
        </template>
        <!-- 操作列 -->
        <template #action="{ row }">
          <el-space>
            <el-link type="primary" :underline="false" @click.stop="openEdit(row)">
              修改
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <div @click.stop="">
              <ele-popconfirm :width="248" placement="top-end" title="删除此客户" content="删除后不可恢复, 确定要删除吗?" :popperOptions="{
                modifiers: [
                  { name: 'arrow', options: { padding: 32 } },
                  { name: 'offset', options: { offset: [32, 6] } }
                ]
              }" @confirm="remove(row)">
                <template #reference>
                  <el-link type="danger" :underline="false">删除</el-link>
                </template>
              </ele-popconfirm>
            </div>
          </el-space>
        </template>
        <!-- 客户名表头 -->
      </ele-pro-table>
    </ele-card>

    <!-- 编辑弹窗 -->
    <AddEditForm v-model="showEdit" :data="current" @done="reload" />
  </ele-page>
</template>

<script setup>
import { ref, reactive, computed } from 'vue';
import { Plus, ArrowDown } from '@element-plus/icons-vue';
import { EleMessage } from 'ele-admin-plus';
import SearchForm from './components/Search-Form.vue';
import AddEditForm from './components/AddEdit-Form.vue';
import { PageUsers } from '@/api/note/user';
import { API_BASE_URL } from "@/config/setting"
import { useI18n } from 'vue-i18n';
const { t } = useI18n();

// 表格实例
const tableRef = ref(null);

// 表格列配置
const columns = computed(() => {
  return [
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
      columnKey: 'avatar',
      prop: 'avatar',
      label: t('list.customer.table.avatar'),
      width: 80,
      align: 'center',
      slot: 'avatar',
      showOverflowTooltip: true
    },
    {
      prop: 'nickname',
      label: t('list.customer.table.nickname'),
      minWidth: 50,
      sortable: 'custom',
      slot: 'nickname',
      headerSlot: 'nicknameHeader',
      showOverflowTooltip: true
    },
    {
      prop: 'email',
      label: t('list.customer.table.email'),
      minWidth: 100,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'subscribe',
      label: t('list.customer.table.subscribe'),
      minWidth: 100,
      slot: 'roles',
      showOverflowTooltip: true
      // hideInTable: true // 隐藏不显示
    },
    {
      prop: 'create_time',
      label: t('list.customer.table.createTime'),
      minWidth: 60,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'status',
      label: t('list.customer.table.status'),
      width: 90,
      sortable: 'custom',
      align: 'center',
      slot: 'status',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: t('list.customer.table.action'),
      width: 110,
      align: 'center',
      resizable: false,
      slot: 'action',
      fixed: 'right'
    }
  ];
});

// 表格选中数据
const selections = ref([]);

// 是否显示编辑弹窗
const showEdit = ref(false);

// 表格单选选中数据
const current = ref(null);

// 表格是否显示边框
const bordered = ref(false);

// 表格是否斑马纹
const striped = ref(false);

// 表头工具栏风格
const toolDefault = ref(false);

// 表格固定高度
const fixedHeight = ref(true);

// 表格数据源
const datasource = async ({ page, limit, where, orders, filters }) => {
  return await PageUsers({
    ...where,
    ...orders,
    ...filters,
    page,
    limit
  })
};


/* 表格数据请求完成事件 */
const onDone = (result, parent) => {
  // const { data, page, total, response } = result;
  // data 是当前页数据, page 是当前页码, total 是总数量
  // response 是数据源原始返回的数据(如果有 parseData 是处理后的)
  // console.log("data 是当前页数据, page 是当前页码, total 是总数量");
  // console.log({ data, page, total, response });

  // 回显 id 为 45、47、48 的数据的复选框
  // nextTick(() => {
  //   const ids = [12, 14];
  //   tableRef.value?.setSelectedRowKeys(ids);
  // });
};

/* 搜索事件 */
const onSearch = (where) => {
  reload(where)
};

/* 刷新表格 */
const reload = (where) => {
  tableRef.value?.reload({ page: 1, where });
};

/* 清空选择 */
const clearChoose = () => {
  tableRef.value?.clearSelection();
};

/* 编辑 */
const openEdit = (row) => {
  showEdit.value = true;
  current.value = row ?? null;
};

/* 删除 */
const remove = (row) => {
  console.log(row);
  EleMessage.info('点击了删除');
};

/* 下拉按钮点击 */
const onDropClick = (command) => {
  if (command === 'del') {
    EleMessage.info('点击了批量删除');
  } else if (command === 'edit') {
    EleMessage.info('点击了批量修改');
  }
};

</script>
