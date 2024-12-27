<template>
  <ele-page hide-footer :flex-table="fixedHeight" style="min-height: 600px">
    <!-- 搜索表单 -->
    <search-form @search="onSearch" />
    <ele-card :flex-table="fixedHeight">
      <!-- 提示信息 -->
      <ele-alert type="warning" show-icon :closable="false" :style="{ marginBottom: toolDefault ? '12px' : '4px' }" v-if="dataArraySource">
        <template #title>
          <span>当前页订单异常状态的有 </span>
          <b>{{ dataArraySource.filter((d) => d.noteSubscribeOrder.status === 1).length }} 个 &emsp;</b>
        </template>
      </ele-alert>
      <!-- 表格 -->
      <ele-pro-table ref="tableRef" row-key="userId" :border="bordered" :stripe="striped" row-click-checked
        highlight-current-row :toolbar="{ theme: toolDefault ? 'default' : 'plain' }" :columns="columns"
        :datasource="datasource" v-model:current="current" v-model:selections="selections"
        :default-sort="{ prop: 'create_time', order: 'descending' }">
        <!-- 实付金额 -->
        <template #price="{ row }">
          <el-tag type="warning">{{ row.noteSubscribe.price.toFixed(2) }}￥</el-tag>
        </template>
        <!-- 状态列 -->
        <template #status="{ row }">
          <ele-dot v-for="(itemStatus, index) in statusListData" :key="index"
            v-show="row.noteSubscribeOrder.status == itemStatus.code" :text="itemStatus.describe"
            :type="itemStatus.type" :ripple="itemStatus.ripple" size="8px" />
        </template>
        <!-- 操作列 -->
        <template #action="{ row }">
          <el-space>
            <el-link type="primary" :underline="false">
              审核
            </el-link>
            <el-link type="danger" :underline="false">
              退款
            </el-link>
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
import { ref, computed } from 'vue';
import { Plus, ArrowDown } from '@element-plus/icons-vue';
import { EleMessage } from 'ele-admin-plus';
import SearchForm from './components/search-form.vue';
import AddEditForm from './components/AddEdit-Form.vue';
import { PageSubscribeOrder, removeSubscribe, BatchremoveUsers } from '@/api/note/order/index';
import { SubscribeOrderListStatus } from '@/api/common/index.js';
import { SnitListStatus } from '@/api/common/index.js';
import { useI18n } from 'vue-i18n';
const { t } = useI18n();

// 表格实例
const tableRef = ref(null);

// 表格列配置
const columns = computed(() => {
  return [
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true,
      fixed: 'left'
    },
    {
      prop: 'noteSubscribeOrder.subscribeOrderId',
      label: t('list.subscribeorder.table.id'),
      minWidth: 30,
      showOverflowTooltip: true,
    },
    {
      prop: 'noteSubscribe.subscribeName',
      label: t('list.subscribeorder.table.name'),
      minWidth: 80,
      showOverflowTooltip: true
    },
    {
      prop: 'noteSubscribeOrder.userId',
      label: t('list.subscribeorder.table.user'),
      minWidth: 80,
      showOverflowTooltip: true
    },
    {
      prop: 'noteSubscribe.price',
      label: t('list.subscribeorder.table.price'),
      minWidth: 100,
      sortable: 'custom',
      slot: 'price',
      showOverflowTooltip: true
    },

    {
      prop: 'noteSubscribeOrder.create_time',
      label: t('list.subscribeorder.table.createTime'),
      minWidth: 60,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'noteSubscribeOrder.status',
      label: t('list.subscribeorder.table.status'),
      minWidth: 60,
      sortable: 'custom',
      align: 'center',
      slot: 'status',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: t('list.subscribeorder.table.action'),
      width: 120,
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
let dataArraySource = ref()
const datasource = async ({ page, limit, where, orders, filters }) => {
  let dataArray = await PageSubscribeOrder({
    ...where,
    ...orders,
    ...filters,
    page,
    limit
  })
  dataArraySource.value = dataArray.list
  return dataArray
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
  removeSubscribe(row.subscribeId)
    .then((msg) => {
      EleMessage.success(msg);
      reload()
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
};

/* 下拉按钮点击 */
const onDropClick = (command) => {
  if (command === 'del') {
    BatchremoveUsers(selections.value.map((d) => d.subscribeId))
      .then((msg) => {
        EleMessage.success(msg);
        reload()
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  } else if (command === 'edit') {
    EleMessage.info('点击了批量修改');
  }
};

// 调用获取状态数据
let statusListData = ref()
SubscribeOrderListStatus()
  .then((response) => {
    statusListData.value = response;
  })
  .catch((e) => {
    EleMessage.error(e.message);
  });

// 获取单位数据
const unitListData = ref([]);
SnitListStatus()
  .then((response) => {
    unitListData.value = response;
  })
  .catch((e) => {
    EleMessage.error(e.message);
  });
</script>
