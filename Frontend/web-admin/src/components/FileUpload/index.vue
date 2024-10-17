<template>
  <ele-upload-list
    :limit="limit"
    :drag="true"
    v-model="data"
    :item-style="itemStyle"
    :button-style="buttonStyle"
    :accept="accept"
    :progress-props="{ strokeWidth: 2 }"
    class="ele-attachment-upload"
    @upload="onUpload"
    @retry="(item) => onUpload(item, true)"
    @remove="onRemove"
    @itemClick="onItemClick"
  >
    <template #thumbnail="{ item }">
      <div class="ele-upload-thumbnail">
        <el-icon :size="16" style="margin-right: 6px">
          <document />
        </el-icon>
        <div class="ele-attachment-text">{{ item.name }}</div>
      </div>
    </template>
  </ele-upload-list>
</template>

<script setup>
  import { ref, watch } from 'vue';
  import { Document } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { uploadFile } from '@/api/system/file';

  const props = defineProps({
    // 绑定值
    modelValue: String,
    // 选择数量限制
    limit: Number,
    // 文件大小限制, 单位MB
    fileLimit: {
      type: Number,
      default: 20
    },
    // 自定义样式
    itemStyle: Object,
    // 自定义上传按钮样式
    buttonStyle: Object,
    // 接受上传的文件类型
    accept: {
      type: String,
      default: ''
    }
  });

  const emit = defineEmits(['update:modelValue', 'change']);

  // 数据
  const data = ref([]);

  /* 上传事件 */
  const onUpload = (d, retry) => {
    if (!d.file) {
      return;
    }
    if (props.accept === 'image/*') {
      if (!d.file.type.startsWith('image')) {
        EleMessage.error('只能选择图片');
        return;
      }
    } else if (props.accept === '.xls,.xlsx') {
      if (
        ![
          'application/vnd.ms-excel',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        ].includes(d.file.type)
      ) {
        EleMessage.error('只能选择 excel 文件');
        return false;
      }
    }
    if (d.file.size / 1024 / 1024 > props.fileLimit) {
      EleMessage.error(`大小不能超过 ${props.fileLimit}MB`);
      return;
    }
    if (!retry) {
      data.value.push({ ...d });
    }
    const item = data.value.find((t) => t.key === d.key);
    if (!item) {
      return;
    }
    item.status = 'uploading';
    uploadFile(d.file, {
      onUploadProgress: (e) => {
        if (e.total != null) {
          item.progress = (e.loaded / e.total) * 100;
        }
      }
    })
      .then((res) => {
        item.status = 'done';
        item.name = res.name;
        item.fileUrl = res.url;
        if (isImage(item.fileUrl)) {
          item.url = item.fileUrl;
        }
      })
      .catch((e) => {
        item.status = 'exception';
        EleMessage.error(e.message);
      });
  };

  /* 判断是否是图片 */
  const isImage = (url) => {
    if (!url) {
      return false;
    }
    return (
      url.endsWith('.png') ||
      url.endsWith('.jpg') ||
      url.endsWith('.jpeg') ||
      url.endsWith('.gif') ||
      url.endsWith('.svg')
    );
  };

  /* 删除事件 */
  const onRemove = (item) => {
    data.value.splice(data.value.indexOf(item), 1);
  };

  /* 点击事件 */
  const onItemClick = (item) => {
    if (!item.url && item.fileUrl) {
      window.open(item.fileUrl);
    }
  };

  /* 更新绑定值 */
  const updateModelValue = (value) => {
    if (props.modelValue !== value) {
      emit('update:modelValue', value);
      emit('change', value);
    }
  };

  /* 判断是否全部上传完成 */
  const isDone = () => {
    return !data.value.some((d) => d.status !== 'done');
  };

  /* 获取已上传的图片地址 */
  const getDataValue = () => {
    return data.value.map((d) => {
      return { url: d.fileUrl ?? d.url, name: d.name };
    });
  };

  // 同步绑定值
  watch(
    data,
    () => {
      const res = getDataValue();
      if (props.limit === 1) {
        updateModelValue(res.length ? JSON.stringify(res[0]) : '');
        return;
      }
      updateModelValue(res.length ? JSON.stringify(res) : '');
    },
    { deep: true }
  );

  watch(
    () => props.modelValue,
    (value) => {
      if (!value) {
        if (data.value.length) {
          data.value = [];
        }
        return;
      }
      if (props.limit === 1) {
        const temp = JSON.parse(value);
        if (
          data.value.length === 1 &&
          data.value[0].fileUrl === temp.url &&
          data.value[0].name === temp.name &&
          data.value[0].status === 'done'
        ) {
          return;
        }
        data.value = [
          {
            key: `0-${temp.url}`,
            name: temp.name,
            fileUrl: temp.url,
            url: isImage(temp.url) ? temp.url : void 0,
            status: 'done'
          }
        ];
        return;
      }
      try {
        const temp = JSON.parse(value);
        if (
          temp.length === data.value.length &&
          JSON.stringify(getDataValue()) === value
        ) {
          return;
        }
        data.value = temp.map((t, i) => {
          return {
            key: `${i}-${t.url}`,
            name: t.name,
            fileUrl: t.url,
            url: isImage(t.url) ? t.url : void 0,
            status: 'done'
          };
        });
      } catch (e) {
        console.error(e);
        data.value = [];
      }
    },
    { immediate: true }
  );

  defineExpose({ isDone });
</script>

<style scoped lang="scss">
  .ele-attachment-upload.ele-upload-list {
    width: 100%;

    :deep(.ele-upload-item) {
      display: block;
      width: 100%;
      height: 26px;
      margin: 0 0 6px 0;
      padding: 0 20px 0 8px;
    }

    :deep(.ele-upload-button) {
      padding: 0;

      .ele-upload-icon {
        font-size: 15px;
      }
    }

    :deep(.ele-upload-progress) {
      flex-direction: row;
      align-items: center;
      justify-content: flex-start;
      padding: 0 20px 0 8px;

      .ele-upload-text {
        flex: 1;
        margin-bottom: 0;
      }

      .ele-upload-retry {
        margin: 0;
      }

      .el-progress {
        position: absolute;
        left: 4px;
        right: 4px;
        bottom: 0;
      }
    }

    .ele-upload-thumbnail {
      flex-direction: row;
      justify-content: flex-start;
    }

    .ele-attachment-text {
      flex: 1;
      font-size: 14px;
      line-height: 22px;
      text-align: left;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      word-break: break-all;
    }
  }
</style>
