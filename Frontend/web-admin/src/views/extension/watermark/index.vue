<template>
  <ele-page>
    <ele-card header="基本用法" style="z-index: 1; position: relative">
      <ele-watermark content="Ele Admin Plus" :gap="[60, 40]">
        <div style="height: 200px"></div>
      </ele-watermark>
    </ele-card>
    <ele-card header="多行水印" style="z-index: 1; position: relative">
      <ele-watermark
        :content="['Ele Admin Plus', 'Happy Working']"
        :gap="[60, 40]"
      >
        <div style="height: 200px"></div>
      </ele-watermark>
    </ele-card>
    <ele-card header="图片水印" style="z-index: 1; position: relative">
      <ele-watermark
        :height="30"
        :width="130"
        image="https://mdn.alipayobjects.com/huamei_7uahnr/afts/img/A*lkAoRbywo0oAAAAAAAAAAAAADrJ8AQ/original"
        :gap="[60, 40]"
      >
        <div style="height: 200px"></div>
      </ele-watermark>
    </ele-card>
    <ele-card header="结合其它组件" style="z-index: 1; position: relative">
      <ele-alert
        show-icon
        :closable="false"
        title="水印组件还实现了防止删除和篡改样式的功能, 当检测到节点被删除或默认的样式被修改都会再重新生成水印"
        style="margin-bottom: 12px"
      />
      <ele-watermark content="Ele Admin Plus" :gap="[60, 40]">
        <ele-pro-table
          row-key="id"
          :columns="columns"
          :datasource="datasource"
          :pagination="false"
          :toolbar="false"
        >
          <template #money="{ row }">
            <el-input v-model="row.money" />
          </template>
          <template #status="{ row }">
            <ele-text v-if="row.status === 0" type="success">进行中</ele-text>
            <ele-text v-else-if="row.status === 1" type="danger">
              已延期
            </ele-text>
            <ele-text v-else-if="row.status === 2" type="warning">
              未开始
            </ele-text>
            <ele-text v-else-if="row.status === 3" type="info">
              已结束
            </ele-text>
          </template>
          <template #progress="{ row }">
            <el-progress :percentage="row.progress" />
          </template>
        </ele-pro-table>
      </ele-watermark>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { getProjectList } from '@/api/example';

  // 表格列配置
  const columns = ref([
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center'
    },
    {
      label: '项目名称',
      prop: 'projectName'
    },
    {
      label: '金额(万元)',
      prop: 'money',
      slot: 'money'
    },
    {
      label: '开始时间',
      prop: 'startDate'
    },
    {
      label: '结束时间',
      prop: 'endDate'
    },
    {
      label: '状态',
      prop: 'status',
      slot: 'status'
    },
    {
      label: '进度',
      prop: 'progress',
      slot: 'progress',
      minWidth: 120
    }
  ]);

  /* 表格数据源 */
  const datasource = () => {
    return getProjectList();
  };
</script>

<script>
  export default {
    name: 'ExtensionWatermark'
  };
</script>
