<template>
  <!-- 表格 -->
  <ele-pro-table
    ref="tableRef"
    row-key="dictDataId"
    :columns="columns"
    :datasource="datasource"
    :pagination="false"
    v-model:selections="selections"
    cache-key="systemDictDataTable"
    class="dict-data-table"
  >
    <template #toolbar>
      <dict-data-search
        @search="reload"
        @add="openEdit()"
        @remove="removeBatch"
      />
    </template>
    <template #action="{ row }">
      <el-space>
        <el-link type="primary" :underline="false" @click="openEdit(row)">
          修改
        </el-link>
        <el-divider direction="vertical" style="margin: 0" />
        <ele-popconfirm
          :width="208"
          placement="top-end"
          title="确定要删除此字典项吗？"
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
  <!-- 编辑弹窗 -->
  <dict-data-edit
    v-model="showEdit"
    :data="current"
    :dict-id="dictId"
    @done="reload"
  />
</template>

<script setup>
  import { ref, watch } from 'vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';
  import DictDataSearch from './dict-data-search.vue';
  import DictDataEdit from './dict-data-edit.vue';
  import {
    listDictionaryData,
    removeDictionaryData,
    removeDictionaryDataBatch
  } from '@/api/system/dictionary-data';

  const props = defineProps({
    // 字典id
    dictId: Number
  });

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
      prop: 'dictDataName',
      label: '字典项名称',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'dictDataCode',
      label: '字典项值',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'sortNumber',
      label: '排序号',
      sortable: 'custom',
      width: 120,
      align: 'center'
    },
    {
      prop: 'createTime',
      label: '创建时间',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      columnKey: 'action',
      label: '操作',
      width: 130,
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

  // 表格数据源
  const datasource = ({ where, orders }) => {
    return listDictionaryData({
      ...where,
      ...orders,
      dictId: props.dictId
    });
  };

  /* 刷新表格 */
  const reload = (where) => {
    tableRef?.value?.reload({ page: 1, where });
  };

  /* 打开编辑弹窗 */
  const openEdit = (row) => {
    current.value = row ?? null;
    showEdit.value = true;
  };

  /* 删除单个 */
  const remove = (row) => {
    const loading = EleMessage.loading('请求中..');
    removeDictionaryData(row.dictDataId)
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
    ElMessageBox.confirm('确定要删除选中的字典项吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeDictionaryDataBatch(selections.value.map((d) => d.dictDataId))
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

  // 监听字典id变化
  watch(
    () => props.dictId,
    () => {
      reload();
    }
  );
</script>

<style lang="scss" scoped>
  .dict-data-table :deep(.el-table__inner-wrapper::before) {
    display: none;
  }
</style>
