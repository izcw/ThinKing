<template>
  <ele-card header="支持多选">
    <ele-upload-list
      :limit="8"
      :drag="true"
      :multiple="true"
      v-model="images"
      @upload="onUpload"
      @remove="onRemove"
    />
    <el-button type="primary" @click="getData">获取数据</el-button>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';

  // 已上传数据
  const images = ref([
    {
      key: 1,
      name: 'c184eef391ae48dba87e3057e70238fb.jpg',
      url: 'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg',
      status: 'done'
    },
    {
      key: 2,
      name: 'WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg',
      url: 'https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg',
      status: 'done'
    },
    {
      key: 3,
      name: 'f6bc05af944a4f738b54128717952107.jpg',
      url: 'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg',
      status: 'done'
    }
  ]);

  /* 获取当前数据 */
  const getData = () => {
    console.log('data:', images.value);
    EleMessage.success('数据已打印在控制台');
  };

  /* 上传 item */
  const onUpload = (d) => {
    if (!d.file) {
      return;
    }
    if (!d.file.type.startsWith('image')) {
      EleMessage.error('只能选择图片');
      return;
    }
    if (d.file.size / 1024 / 1024 > 2) {
      EleMessage.error('大小不能超过 2MB');
      return;
    }
    images.value.push({ ...d });
    const item = images.value.find((t) => t.key === d.key);
    console.log('item:', item);
    if (!item) {
      return;
    }
    // 模拟上传
    item.status = 'uploading';
    item.progress = 20;
    const timer = setInterval(() => {
      if (item.progress == null) {
        item.progress = 20;
      } else {
        item.progress += 20;
      }
      if (item.progress === 100) {
        item.status = 'done';
        clearInterval(timer);
      }
    }, 1000);
  };

  /* 删除事件 */
  const onRemove = (item) => {
    images.value.splice(images.value.indexOf(item), 1);
  };
</script>
