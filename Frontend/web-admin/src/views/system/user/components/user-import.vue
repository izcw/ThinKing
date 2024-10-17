<!-- 用户导入弹窗 -->
<template>
  <ele-modal
    :width="460"
    title="导入用户"
    :model-value="modelValue"
    @update:modelValue="updateModelValue"
  >
    <div v-loading="loading">
      <el-upload
        drag
        action=""
        accept=".xls,.xlsx"
        :show-upload-list="false"
        :before-upload="doUpload"
      >
        <ele-text
          type="placeholder"
          :icon="UploadFilled"
          :icon-props="{ size: 68, style: { opacity: 0.6 } }"
        />
        <ele-text type="placeholder">将文件拖到此处, 或点击上传</ele-text>
      </el-upload>
    </div>
    <div style="display: flex; align-items: center; justify-content: center">
      <span style="padding-right: 8px">只能上传 xls、xlsx 文件,</span>
      <el-link
        type="primary"
        :underline="false"
        href="https://cdn.eleadmin.com/20200610/用户导入模板.xlsx"
        download="用户导入模板.xlsx"
      >
        下载模板
      </el-link>
    </div>
  </ele-modal>
</template>

<script setup>
  import { ref } from 'vue';
  import { UploadFilled } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { importUsers } from '@/api/system/user';

  const emit = defineEmits(['done', 'update:modelValue']);

  defineProps({
    // 是否打开弹窗
    modelValue: Boolean
  });

  // 导入请求状态
  const loading = ref(false);

  /* 上传 */
  const doUpload = (file) => {
    if (
      ![
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      ].includes(file.type)
    ) {
      EleMessage.error('只能选择 excel 文件');
      return false;
    }
    if (file.size / 1024 / 1024 > 10) {
      EleMessage.error('大小不能超过 10MB');
      return false;
    }
    loading.value = true;
    importUsers(file)
      .then((msg) => {
        loading.value = false;
        EleMessage.success(msg);
        updateModelValue(false);
        emit('done');
      })
      .catch((e) => {
        loading.value = false;
        EleMessage.error(e.message);
      });
    return false;
  };

  /* 更新modelValue */
  const updateModelValue = (value) => {
    emit('update:modelValue', value);
  };
</script>
