<template>
  <ele-card header="使用案例二">
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      style="max-width: 460px"
    >
      <el-form-item label="投诉内容" prop="content">
        <el-input
          :rows="4"
          type="textarea"
          v-model="form.content"
          placeholder="请输入投诉内容"
        />
      </el-form-item>
      <el-form-item label="现场照片" prop="images">
        <ele-upload-list
          :limit="3"
          :drag="true"
          v-model="form.images"
          @upload="onUpload"
          @remove="onRemove"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="save">提交</el-button>
        <el-button type="primary" @click="setData">回显数据</el-button>
      </el-form-item>
    </el-form>
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { uploadFile } from '@/api/system/file';

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, assignFields } = useFormData({
    id: void 0,
    content: '',
    // 现场照片
    images: []
  });

  // 表单验证规则
  const rules = reactive({
    content: [
      {
        required: true,
        message: '请输入投诉内容',
        type: 'string',
        trigger: 'blur'
      }
    ],
    images: [
      {
        required: true,
        message: '请上传现场照片',
        type: 'array',
        trigger: 'change'
      }
    ]
  });

  /* 保存编辑 */
  const save = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      const data = {
        ...form,
        // 上传组件的数据格式转为字符串
        images: JSON.stringify(form.images.map((d) => d.url))
      };
      console.log(data); // 实际项目用data提交到后台而不是form
      EleMessage.success('数据已打印在控制台');
    });
  };

  /* 上传事件 */
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
    form.images.push({ ...d });
    const item = form.images.find((t) => t.key === d.key);
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
        // 上传后清空验证
        formRef.value?.clearValidate('images');
      })
      .catch((e) => {
        item.status = 'exception';
        EleMessage.error(e.message);
      });
  };

  /* 删除事件 */
  const onRemove = (item) => {
    form.images.splice(form.images.indexOf(item), 1);
  };

  /* 回显数据 */
  const setData = () => {
    const data = {
      id: 1,
      content: '2栋楼下的路灯已经坏了几天了都没人来维修一下',
      images:
        '["https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg","https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg"]'
    };
    // 图片url转为上传组件需要的格式
    const images = data.images
      ? JSON.parse(data.images).map((d, i) => {
          return { key: i, url: d, status: 'done' };
        })
      : [];
    assignFields({ ...data, images });
    formRef.value?.clearValidate();
  };
</script>
