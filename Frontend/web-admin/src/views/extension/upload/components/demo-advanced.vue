<template>
  <ele-card header="手动上传">
    <ele-upload-list
      :drag="true"
      v-model="images"
      :readonly="loading"
      :disabled="disabled"
      @upload="onUpload"
      @retry="uploadItem"
      @remove="onRemove"
    />
    <div style="display: flex; align-items: center">
      <el-button type="primary" :loading="loading" @click="onSubmit">
        提交
      </el-button>
      <div style="line-height: 22px; margin-left: 22px">禁用:</div>
      <div style="flex: 1; padding-left: 12px">
        <el-radio-group v-model="disabled">
          <el-radio :label="false">否</el-radio>
          <el-radio :label="true">是</el-radio>
        </el-radio-group>
      </div>
    </div>
    <div style="margin-top: 20px">
      默认选择文件后就会调用请求后端上传的方法，也可以改为在点击提交按钮后才上传
    </div>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { ElMessageBox } from 'element-plus';
  import { EleMessage } from 'ele-admin-plus/es';

  // 数据
  const images = ref([
    {
      key: 1,
      url: 'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg',
      status: 'done'
    },
    {
      key: 2,
      url: 'https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg',
      status: 'done'
    },
    {
      key: 3,
      url: 'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg',
      status: 'done'
    }
  ]);

  // 是否禁用
  const disabled = ref(false);

  // 上传状态
  const loading = ref(false);

  /* 上传事件, 只添加, 不请求后台 */
  const onUpload = (item) => {
    if (!item.file) {
      return;
    }
    if (item.file.size / 1024 / 1024 > 2) {
      EleMessage.error('大小不能超过 2MB');
      return;
    }
    images.value.push({ ...item });
    console.log('item:', item);
  };

  /* 删除事件 */
  const onRemove = (item) => {
    ElMessageBox.confirm('确定要删除吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        images.value.splice(images.value.indexOf(item), 1);
      })
      .catch(() => {});
  };

  /* 手动上传 */
  const onSubmit = () => {
    if (checkDone()) {
      submitForm();
      return;
    }
    loading.value = true;
    images.value.forEach((item) => {
      if (item.status == null || item.status === 'exception') {
        uploadItem(item);
      }
    });
  };

  /* 请求后台上传 */
  const uploadItem = (item) => {
    // 模拟上传
    item.status = 'uploading';
    if (item.progress == null) {
      item.progress = 20;
    }
    const timer = setInterval(
      () => {
        if (Math.round(Math.random() * 10) < 3) {
          item.status = 'exception';
          EleMessage.error('上传失败, 服务器繁忙');
          clearInterval(timer);
          return;
        }
        if (item.progress == null) {
          item.progress = 20;
        } else {
          item.progress += 20;
        }
        if (item.progress === 100) {
          item.status = 'done';
          clearInterval(timer);
          // 每个图片上传完成后都检查是否全部上传完成
          if (checkDone()) {
            submitForm();
          }
        }
      },
      Math.round(Math.random() * 2500) + 500
    );
  };

  /* 检查是否全部上传完毕 */
  const checkDone = () => {
    return !images.value.some((d) => d.status !== 'done');
  };

  /* 全部上传完毕后与其它表单数据一起提交 */
  const submitForm = () => {
    EleMessage.success('已全部上传完毕');
    console.log('data:', images.value);
    loading.value = false;
  };
</script>
