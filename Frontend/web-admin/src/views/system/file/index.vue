<template>
  <ele-page>
    <!-- 搜索表单 -->
    <file-search @search="reload" />
    <ele-card :body-style="{ paddingTop: '8px' }">
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="id"
        :columns="columns"
        :datasource="datasource"
        v-model:selections="selections"
        cache-key="systemFileTable"
      >
        <template #toolbar>
          <el-space>
            <el-upload
              action=""
              :show-upload-list="false"
              :before-upload="onUpload"
            >
              <el-button type="primary" class="ele-btn-icon" :icon="Upload">
                上传
              </el-button>
            </el-upload>
            <el-button
              type="danger"
              class="ele-btn-icon"
              :icon="Delete"
              @click="removeBatch"
            >
              删除
            </el-button>
          </el-space>
        </template>
        <template #path="{ row }">
          <ele-ellipsis :tooltip="false">
            <el-link
              type="primary"
              :href="row.url"
              target="_blank"
              :underline="false"
            >
              {{ row.path }}
            </el-link>
          </ele-ellipsis>
        </template>
        <template #action="{ row }">
          <el-space>
            <el-link
              type="primary"
              :underline="false"
              :href="row.downloadUrl"
              target="_blank"
            >
              下载
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-popconfirm
              :width="190"
              placement="top-end"
              title="确定要删除此文件吗？"
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
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { Delete, Upload } from '@element-plus/icons-vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';
  import FileSearch from './components/file-search.vue';
  import {
    pageFiles,
    removeFile,
    removeFiles,
    uploadFile
  } from '@/api/system/file';

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
      prop: 'name',
      label: '文件名称',
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'path',
      label: '文件路径',
      sortable: 'custom',
      showOverflowTooltip: true,
      slot: 'path'
    },
    {
      prop: 'length',
      label: '文件大小',
      width: 120,
      sortable: 'custom',
      showOverflowTooltip: true,
      formatter: (row) => {
        if (row.length < 1024) {
          return row.length + 'B';
        } else if (row.length < 1024 * 1024) {
          return (row.length / 1024).toFixed(1) + 'KB';
        } else if (row.length < 1024 * 1024 * 1024) {
          return (row.length / 1024 / 1024).toFixed(1) + 'M';
        } else {
          return (row.length / 1024 / 1024 / 1024).toFixed(1) + 'G';
        }
      }
    },
    {
      prop: 'createNickname',
      label: '上传人',
      width: 120,
      sortable: 'custom',
      showOverflowTooltip: true
    },
    {
      prop: 'createTime',
      label: '上传时间',
      width: 160,
      sortable: 'custom',
      showOverflowTooltip: true
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

  // 表格选中数据
  const selections = ref([]);

  // 表格数据源
  const datasource = ({ page, limit, where, orders }) => {
    return pageFiles({ ...where, ...orders, page, limit });
  };

  /* 搜索 */
  const reload = (where) => {
    selections.value = [];
    tableRef?.value?.reload({ page: 1, where });
  };

  /* 删除单个 */
  const remove = (row) => {
    const loading = EleMessage.loading('请求中..');
    removeFile(row.id)
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
    ElMessageBox.confirm('确定要删除选中的文件吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeFiles(selections.value.map((d) => d.id))
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

  /* 上传 */
  const onUpload = (file) => {
    if (file.size / 1024 / 1024 > 100) {
      EleMessage.error('大小不能超过 100MB');
      return false;
    }
    const loading = EleMessage.loading({
      message: '上传中..',
      mask: true
    });
    uploadFile(file)
      .then(() => {
        loading.close();
        EleMessage.success('上传成功');
        reload();
      })
      .catch((e) => {
        loading.close();
        EleMessage.error(e.message);
      });
    return false;
  };
</script>

<script>
  export default {
    name: 'SystemFile'
  };
</script>
