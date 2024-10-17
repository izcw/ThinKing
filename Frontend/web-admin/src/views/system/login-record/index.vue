<template>
  <ele-page>
    <!-- 搜索表单 -->
    <login-record-search :where="defaultWhere" @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="id"
        :columns="columns"
        :datasource="datasource"
        :where="defaultWhere"
        cache-key="systemLoginRecordTable"
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
        <template #loginType="{ row }">
          <el-tag
            v-if="row.loginType === 0"
            size="small"
            type="success"
            :disable-transitions="true"
          >
            登录成功
          </el-tag>
          <el-tag
            v-else-if="row.loginType === 1"
            size="small"
            type="danger"
            :disable-transitions="true"
          >
            登录失败
          </el-tag>
          <el-tag
            v-else-if="row.loginType === 2"
            size="small"
            type="info"
            :disable-transitions="true"
          >
            退出登录
          </el-tag>
          <el-tag
            v-else-if="row.loginType === 3"
            size="small"
            type="warning"
            :disable-transitions="true"
          >
            刷新TOKEN
          </el-tag>
        </template>
      </ele-pro-table>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { Download } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { utils, writeFile } from 'xlsx';
  import LoginRecordSearch from './components/login-record-search.vue';
  import {
    pageLoginRecords,
    listLoginRecords
  } from '@/api/system/login-record';

  // 默认搜索条件
  const defaultWhere = reactive({
    username: '',
    nickname: ''
  });

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
      prop: 'ip',
      label: 'IP地址',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'device',
      label: '设备型号',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'os',
      label: '操作系统',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'browser',
      label: '浏览器',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      columnKey: 'loginType',
      prop: 'loginType',
      label: '操作类型',
      sortable: 'custom',
      width: 130,
      slot: 'loginType',
      filters: [
        {
          text: '登录成功',
          value: '0'
        },
        {
          text: '登录失败',
          value: '1'
        },
        {
          text: '退出登录',
          value: '2'
        },
        {
          text: '刷新TOKEN',
          value: '3'
        }
      ],
      filterMultiple: false
    },
    {
      prop: 'comments',
      label: '备注',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'createTime',
      label: '登录时间',
      sortable: 'custom',
      showOverflowTooltip: true
    }
  ]);

  // 表格数据源
  const datasource = ({ page, limit, where, orders, filters }) => {
    return pageLoginRecords({
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

  /* 导出数据 */
  const exportData = () => {
    const array = [
      [
        '账号',
        '用户名',
        'IP地址',
        '设备型号',
        '操作系统',
        '浏览器',
        '操作类型',
        '备注',
        '登录时间'
      ]
    ];
    // 请求查询全部接口
    const loading = EleMessage.loading('请求中..');
    tableRef.value?.fetch(({ where, orders, filters }) => {
      listLoginRecords({ ...where, ...orders, ...filters })
        .then((data) => {
          loading.close();
          data.forEach((d) => {
            array.push([
              d.username,
              d.nickname,
              d.ip,
              d.device,
              d.os,
              d.browser,
              ['登录成功', '登录失败', '退出登录', '刷新TOKEN'][d.loginType],
              d.comments,
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
            '登录日志.xlsx'
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
    name: 'SystemLoginRecord'
  };
</script>
