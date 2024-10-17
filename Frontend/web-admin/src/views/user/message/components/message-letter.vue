<template>
  <div>
    <ele-pro-table
      ref="tableRef"
      row-key="id"
      :columns="columns"
      :datasource="datasource"
      v-model:selections="selections"
    >
      <template #toolbar>
        <el-space>
          <el-button type="primary" class="ele-btn-icon" @click="readBatch">
            标记已读
          </el-button>
          <el-button type="danger" class="ele-btn-icon" @click="removeBatch">
            删除消息
          </el-button>
        </el-space>
      </template>
      <template #status="{ row }">
        <ele-text v-if="row.status === 0" type="warning">未读</ele-text>
        <ele-text v-else-if="row.status === 1" type="info">已读</ele-text>
      </template>
      <template #action="{ row }">
        <el-space>
          <el-link type="primary" :underline="false" @click="reply(row)">
            回复
          </el-link>
          <el-divider direction="vertical" style="margin: 0" />
          <ele-popconfirm
            :width="190"
            placement="top-end"
            title="确定要删除此消息吗？"
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
  </div>
</template>

<script setup>
  import { ref } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { pageLetters } from '@/api/example';

  const emit = defineEmits(['reload']);

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
      prop: 'title',
      label: '私信内容',
      showOverflowTooltip: true
    },
    {
      prop: 'time',
      label: '发送时间',
      width: 140,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      prop: 'status',
      label: '状态',
      width: 90,
      align: 'center',
      slot: 'status'
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 120,
      align: 'center',
      resizable: false,
      slot: 'action'
    }
  ]);

  // 列表选中数据
  const selections = ref([]);

  // 表格数据源
  const datasource = ({ page, limit, where, orders }) => {
    return pageLetters({ ...where, ...orders, page, limit });
  };

  /* 回复 */
  const reply = (row) => {
    console.log(row);
    EleMessage.info('点击了回复');
  };

  /* 删除单个 */
  const remove = (row) => {
    console.log(row);
    EleMessage.info('点击了删除');
    updateUnReadNum();
  };

  /* 批量删除 */
  const removeBatch = () => {
    if (!selections.value.length) {
      EleMessage.error('请至少选择一条数据');
      return;
    }
    EleMessage.info('点击了删除');
    updateUnReadNum();
  };

  /* 标记已读 */
  const readBatch = () => {
    if (!selections.value.length) {
      EleMessage.error('请至少选择一条数据');
      return;
    }
    selections.value.forEach((d) => {
      d.status = 1;
    });
    updateUnReadNum();
    clearChoose();
    EleMessage.success('操作成功');
  };

  /* 触发更新未读数量事件 */
  const updateUnReadNum = () => {
    emit('reload');
  };

  /* 清空选择 */
  const clearChoose = () => {
    tableRef.value?.clearSelection();
  };
</script>
