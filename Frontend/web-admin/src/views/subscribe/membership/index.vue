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
          <span>其中下架状态的有 </span>
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
        :default-sort="{ prop: 'create_time', order: 'descending' }">
        <template #toolbar>
          <el-space>
            <el-button type="primary" :icon="Plus" class="ele-btn-icon" @click="openEdit()">
              新建
            </el-button>
            <ele-dropdown :disabled="!selections.length" :items="[
              { title: '批量删除', command: 'del' }
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
        <!-- 客户名列 -->
        <template #nickname="{ row }">
          <router-link :to="'/list/basic/details/' + row.userId" style="text-decoration: none" @click.stop="">
            <el-link type="primary" :underline="false">
              {{ row.nickname }}
            </el-link>
          </router-link>
        </template>
        <!-- 价格 -->
        <template #price="{ row }">
          <el-tag type="success">{{ row.price.toFixed(2) }}￥</el-tag>
        </template>
        <!-- 单位 -->
        <template #unit="{ row }">
          <el-text v-for="(itemUnit, index) in unitListData" :key="index" v-show="row.unit == itemUnit.unit">{{
            itemUnit.describe }}</el-text>
        </template>
        <!-- 推荐 -->
        <template #recommend="{ row }">
          <el-switch v-model="row.recommend" :inactive-value="0" :active-value="1" inline-prompt active-text="推荐"
            inactive-text="No" disabled />
        </template>
        <!-- 状态列 -->
        <template #status="{ row }">
          <ele-dot v-for="(itemStatus, index) in statusListData" :key="index" v-show="row.status == itemStatus.code"
            :text="itemStatus.describe" :type="itemStatus.type" :ripple="itemStatus.ripple" size="8px" />
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
import { ref, computed } from 'vue';
import { Plus, ArrowDown } from '@element-plus/icons-vue';
import { EleMessage } from 'ele-admin-plus';
import SearchForm from './components/search-form.vue';
import AddEditForm from './components/AddEdit-Form.vue';
import { PageSubscribe, removeSubscribe, BatchremoveUsers } from '@/api/note/subscribe/index';
import { SubscribeListStatus } from '@/api/common/index.js';
import { SnitListStatus } from '@/api/common/index.js';
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
      prop: 'subscribeId',
      label: 'id',
      minWidth: 30,
      showOverflowTooltip: true,
      hideInTable: true // 隐藏不显示
    },
    {
      prop: 'subscribeName',
      label: t('list.subscribe.table.name'),
      minWidth: 50,
      showOverflowTooltip: true
    },
    {
      prop: 'subscribeCode',
      label: t('list.subscribe.table.code'),
      minWidth: 50,
      showOverflowTooltip: true
    },
    {
      prop: 'price',
      label: t('list.subscribe.table.price'),
      minWidth: 40,
      sortable: 'custom',
      slot: 'price',
      showOverflowTooltip: true
    },
    {
      prop: 'unit',
      label: t('list.subscribe.table.unit'),
      minWidth: 60,
      slot: 'unit',
      showOverflowTooltip: true
    },
    {
      prop: 'space',
      label: t('list.subscribe.table.space'),
      minWidth: 20,
      showOverflowTooltip: true
    },
    {
      prop: 'recycle',
      label: t('list.subscribe.table.recycle'),
      minWidth: 40,
      showOverflowTooltip: true
    },
    {
      prop: 'pageHistory',
      label: t('list.subscribe.table.pagehistory'),
      minWidth: 60,
      showOverflowTooltip: true
    },
    {
      prop: 'pageWordage',
      label: t('list.subscribe.table.pagewordage'),
      minWidth: 60,
      showOverflowTooltip: true
    },
    {
      prop: 'ai',
      label: t('list.subscribe.table.ai'),
      minWidth: 40,
      showOverflowTooltip: true
    },
    {
      prop: 'recommend',
      label: t('list.subscribe.table.recommend'),
      minWidth: 40,
      slot: 'recommend',
      showOverflowTooltip: true
    },
    {
      prop: 'comments',
      label: t('list.subscribe.table.comments'),
      minWidth: 60,
      showOverflowTooltip: true
    },
    {
      prop: 'create_time',
      label: t('list.subscribe.table.createTime'),
      minWidth: 60,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'update_time',
      label: t('list.subscribe.table.updateTime'),
      minWidth: 60,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'status',
      label: t('list.subscribe.table.status'),
      width: 90,
      sortable: 'custom',
      align: 'center',
      slot: 'status',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: t('list.subscribe.table.action'),
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
const datasource = async ({ page, limit, where, orders, filters }) => {
  return await PageSubscribe({
    ...where,
    ...orders,
    ...filters,
    page,
    limit
  })
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
SubscribeListStatus()
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
