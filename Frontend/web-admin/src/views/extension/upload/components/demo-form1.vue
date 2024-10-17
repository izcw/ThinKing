<template>
  <ele-card header="使用案例一">
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      style="max-width: 380px"
    >
      <el-form-item label="真实姓名" prop="realName">
        <el-input
          clearable
          :maxlength="20"
          v-model="form.realName"
          placeholder="请输入真实姓名"
        />
      </el-form-item>
      <el-form-item label="身份证号" prop="idCard">
        <el-input
          clearable
          :maxlength="20"
          v-model="form.idCard"
          placeholder="请输入身份证号"
        />
      </el-form-item>
      <el-form-item label="身份证正面" prop="idCardImg1">
        <ele-upload-list
          :limit="1"
          :drag="true"
          :sortable="false"
          v-model="form.idCardImg1"
          :item-style="{ width: '260px', height: '160px', margin: 0 }"
          :button-style="{ width: '260px', height: '160px', margin: 0 }"
          style="max-width: 100%"
          @upload="(d) => onUpload(0, d)"
          @remove="(d) => onRemove(0, d)"
        />
      </el-form-item>
      <el-form-item label="身份证反面" prop="idCardImg2">
        <ele-upload-list
          :limit="1"
          :drag="true"
          :sortable="false"
          v-model="form.idCardImg2"
          :item-style="{ width: '260px', height: '160px', margin: 0 }"
          :button-style="{ width: '260px', height: '160px', margin: 0 }"
          @upload="(d) => onUpload(1, d)"
          @remove="(d) => onRemove(1, d)"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="save">提交</el-button>
        <el-button type="primary" @click="setData">回显数据</el-button>
      </el-form-item>
    </el-form>
    <div style="padding-top: 8px">
      可以很方便的修改宽高等样式，单选的时候使用也非常的 nice
    </div>
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
    realName: '',
    idCard: '',
    // 身份证正面
    idCardImg1: [],
    // 身份证反面
    idCardImg2: []
  });

  // 表单验证规则
  const rules = reactive({
    realName: [
      {
        required: true,
        message: '请输入真实姓名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    idCard: [
      {
        required: true,
        message: '请输入身份证号',
        type: 'string',
        trigger: 'blur'
      }
    ],
    idCardImg1: [
      {
        required: true,
        message: '请上传身份证正面',
        type: 'array',
        trigger: 'change'
      }
    ],
    idCardImg2: [
      {
        required: true,
        message: '请上传身份证反面',
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
        idCardImg1: form.idCardImg1.map((d) => d.url).join(),
        idCardImg2: form.idCardImg2.map((d) => d.url).join()
      };
      console.log(data); // 实际项目用data提交到后台而不是form
      EleMessage.success('数据已打印在控制台');
    });
  };

  /* 上传事件 */
  const onUpload = (type, d) => {
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
    (type === 1 ? form.idCardImg2 : form.idCardImg1).push({ ...d });
    const item = (type === 1 ? form.idCardImg2 : form.idCardImg1).find(
      (t) => t.key === d.key
    );
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
        formRef.value?.clearValidate(type === 1 ? 'idCardImg2' : 'idCardImg1');
      })
      .catch((e) => {
        item.status = 'exception';
        EleMessage.error(e.message);
      });
  };

  /* 删除事件 */
  const onRemove = (type, item) => {
    const temp = type === 1 ? form.idCardImg2 : form.idCardImg1;
    temp.splice(temp.indexOf(item), 1);
  };

  /* 回显数据 */
  const setData = () => {
    const data = {
      id: 1,
      realName: '张三',
      idCard: '420111200001013807',
      idCardImg1:
        'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg',
      idCardImg2:
        'https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg'
    };
    // 图片url转为上传组件需要的格式
    const idCardImg1 = data.idCardImg1
      ? [{ key: 1, url: data.idCardImg1, status: 'done' }]
      : [];
    const idCardImg2 = data.idCardImg2
      ? [{ key: 1, url: data.idCardImg2, status: 'done' }]
      : [];
    assignFields({
      ...data,
      idCardImg1,
      idCardImg2
    });
    formRef.value?.clearValidate();
  };
</script>
