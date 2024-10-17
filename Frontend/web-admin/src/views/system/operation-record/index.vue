<template>
  <ele-page>
    <!-- 搜索表单 -->
    <operation-record-search @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="id"
        :columns="columns"
        :datasource="datasource"
        cache-key="systemOperationRecordTable"
      >
        <template #toolbar>
          <el-space>
            <el-button
              type="primary"
              class="ele-btn-icon"
              :icon="Download"
              @click="exportData"
            >
              导出
            </el-button>
          </el-space>
        </template>
        <template #status="{ row }">
          <el-tag
            v-if="row.status === 0"
            size="small"
            type="success"
            :disable-transitions="true"
          >
            正常
          </el-tag>
          <el-tag
            v-else-if="row.status === 1"
            size="small"
            type="danger"
            :disable-transitions="true"
          >
            异常
          </el-tag>
        </template>
        <template #action="{ row }">
          <el-link type="primary" :underline="false" @click="openDetail(row)">
            详情
          </el-link>
        </template>
      </ele-pro-table>
    </ele-card>
    <!-- 详情弹窗 -->
    <operation-record-detail v-model="showInfo" :data="current" />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { Download } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { utils, writeFile } from 'xlsx';
  import OperationRecordSearch from './components/operation-record-search.vue';
  import OperationRecordDetail from './components/operation-record-detail.vue';
  import {
    pageOperationRecords,
    listOperationRecords
  } from '@/api/system/operation-record';

  // 表格实例
  const tableRef = ref(null);

  // 表格列配置
  const columns = ref([
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
      label: '账号',
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
      prop: 'module',
      label: '操作模块',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'description',
      label: '操作功能',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'url',
      label: '请求地址',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'requestMethod',
      label: '请求方式',
      sortable: 'custom',
      width: 120,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      columnKey: 'status',
      prop: 'status',
      label: '状态',
      sortable: 'custom',
      width: 100,
      align: 'center',
      slot: 'status',
      filters: [
        {
          text: '正常',
          value: '0'
        },
        {
          text: '异常',
          value: '1'
        }
      ],
      filterMultiple: false
    },
    {
      prop: 'spendTime',
      label: '耗时',
      sortable: 'custom',
      width: 100,
      formatter: (row) => `${row.spendTime / 1000}s`
    },
    {
      prop: 'createTime',
      label: '操作时间',
      sortable: 'custom',
      align: 'center',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 90,
      align: 'center',
      resizable: false,
      slot: 'action',
      fixed: 'right'
    }
  ]);

  // 当前选中数据
  const current = ref({
    module: '',
    description: '',
    url: '',
    requestMethod: '',
    method: '',
    params: '',
    result: '',
    error: '',
    spendTime: 0,
    os: '',
    device: '',
    browser: '',
    ip: '',
    status: 0,
    createTime: '',
    nickname: '',
    username: ''
  });

  // 是否显示查看弹窗
  const showInfo = ref(false);

  // 表格数据源
  const datasource = ({ page, limit, where, orders, filters }) => {
    return pageOperationRecords({
      ...where,
      ...orders,
      ...filters,
      page,
      limit
    });
  };

  /* 刷新表格 */
  const reload = (where) => {
    tableRef?.value?.reload({ page: 1, where });
  };

  /* 详情 */
  const openDetail = (row) => {
    current.value = row;
    showInfo.value = true;
  };

  /* 导出数据 */
  const exportData = () => {
    const array = [
      [
        '账号',
        '用户名',
        '操作模块',
        '操作功能',
        '请求地址',
        '请求方式',
        '状态',
        '耗时',
        '操作时间'
      ]
    ];
    // 请求查询全部(不分页)的接口
    const loading = EleMessage.loading('请求中..');
    tableRef.value?.fetch(({ where, orders, filters }) => {
      listOperationRecords({ ...where, ...orders, ...filters })
        .then((data) => {
          loading.close();
          data.forEach((d) => {
            array.push([
              d.username,
              d.nickname,
              d.module,
              d.description,
              d.url,
              d.requestMethod,
              ['正常', '异常'][d.status],
              d.spendTime / 1000 + 's',
              d.createTime
            ]);
          });
          writeFile(
            {
              SheetNames: ['Sheet1'],
              Sheets: {
                Sheet1: utils.aoa_to_sheet(array)
              }
            },
            '操作日志.xlsx'
          );
        })
        .catch((e) => {
          loading.close();
          EleMessage.error(e.message);
        });
    });
  };
</script>

<script>
  export default {
    name: 'SystemOperationRecord'
  };
</script>
