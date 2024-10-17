<template>
  <ele-upload-list
    :limit="limit"
    :drag="true"
    v-model="data"
    :item-style="itemStyle"
    :button-style="buttonStyle"
    @upload="onUpload"
    @retry="(item) => onUpload(item, true)"
    @remove="onRemove"
  />
</template>

<script setup>
  import { ref, watch } from 'vue';
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
    buttonStyle: Object
  });

  const emit = defineEmits(['update:modelValue', 'change']);

  // 数据
  const data = ref([]);

  /* 上传事件 */
  const onUpload = (d, retry) => {
    if (!d.file) {
      return;
    }
    if (!d.file.type.startsWith('image')) {
      EleMessage.error('只能选择图片');
      return;
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
        item.url = res.url;
      })
      .catch((e) => {
        item.status = 'exception';
        EleMessage.error(e.message);
      });
  };

  /* 删除事件 */
  const onRemove = (item) => {
    data.value.splice(data.value.indexOf(item), 1);
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
    return data.value.map((d) => d.url);
  };

  // 同步绑定值
  watch(
    data,
    () => {
      const res = getDataValue();
      if (props.limit === 1) {
        updateModelValue(res.join());
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
        if (
          data.value.length === 1 &&
          data.value[0].url === value &&
          data.value[0].status === 'done'
        ) {
          return;
        }
        data.value = [{ key: `0-${value}`, url: value, status: 'done' }];
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
          return { key: `${i}-${t}`, url: t, status: 'done' };
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
