<template>
  <ele-card :body-style="{ paddingTop: '8px' }">
    <ele-pro-table
      row-key="dictId"
      :columns="columns"
      :datasource="datasource"
      :toolbar="{ title: '嵌套表格' }"
      :pagination="false"
    >
      <template #expand="{ row }">
        <ele-pro-table
          row-key="dictDataId"
          :where="{ dictId: row.dictId }"
          :columns="dictDataColumns"
          :datasource="dictDataDatasource"
          :toolbar="false"
          :pagination="false"
        >
          <template #action="{ row: d }">
            <el-space>
              <el-link type="primary" :underline="false">修改</el-link>
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
                @confirm="removeDictData(d)"
              >
                <template #reference>
                  <el-link type="danger" :underline="false">删除</el-link>
                </template>
              </ele-popconfirm>
            </el-space>
          </template>
        </ele-pro-table>
      </template>
    </ele-pro-table>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  // import { listDictionaries } from '@/api/system/dictionary';
  import { listDictionaryData } from '@/api/system/dictionary-data';

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
      type: 'expand',
      columnKey: 'expand',
      width: 48,
      align: 'center',
      slot: 'expand'
    },
    {
      prop: 'dictName',
      label: '字典名称',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'dictCode',
      label: '字典代码',
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
    }
  ]);

  // 表格数据源
  const datasource = ({ orders }) => {
    // return listDictionaries({ ...orders });
  };

  // 字典项列配置
  const dictDataColumns = ref([
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      prop: 'dictDataName',
      label: '字典项名称',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'dictDataCode',
      label: '字典项代码',
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

  // 字典项数据源
  const dictDataDatasource = ({ where, orders }) => {
    return listDictionaryData({ ...where, ...orders });
  };

  /* 删除字典项 */
  const removeDictData = (row) => {
    console.log('点击了删除', row);
  };
</script>
