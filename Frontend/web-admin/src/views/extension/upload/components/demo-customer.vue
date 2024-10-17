<template>
  <ele-card header="二次封装简化使用">
    <div style="margin-bottom: 24px">
      二次封装后无需再处理上传事件及转换数据格式，使用起来就像一个普通输入框一样简单
    </div>
    <el-form
      ref="formRef"
      :model="form"
      :rules="rules"
      label-width="100px"
      style="max-width: 460px"
    >
      <el-form-item label="真实姓名" prop="realName">
        <el-input
          clearable
          :maxlength="20"
          v-model="form.realName"
          placeholder="请输入真实姓名"
        />
      </el-form-item>
      <el-form-item label="身份证正面" prop="idCardImg1">
        <image-upload
          :limit="1"
          v-model="form.idCardImg1"
          :item-style="{ width: '260px', height: '160px', margin: 0 }"
          :button-style="{ width: '260px', height: '160px', margin: 0 }"
        />
      </el-form-item>
      <el-form-item label="身份证反面" prop="idCardImg2">
        <image-upload
          :limit="1"
          v-model="form.idCardImg2"
          :item-style="{ width: '260px', height: '160px', margin: 0 }"
          :button-style="{ width: '260px', height: '160px', margin: 0 }"
        />
      </el-form-item>
      <el-form-item label="投诉内容" prop="content">
        <el-input
          :rows="4"
          type="textarea"
          v-model="form.content"
          placeholder="请输入投诉内容"
        />
      </el-form-item>
      <el-form-item label="现场照片" prop="images">
        <image-upload :limit="3" v-model="form.images" />
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
  import ImageUpload from '@/components/ImageUpload/index.vue';

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, assignFields } = useFormData({
    id: void 0,
    realName: '',
    // 身份证正面
    idCardImg1: '',
    // 身份证反面
    idCardImg2: '',
    content: '',
    // 现场照片
    images: ''
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
    idCardImg1: [
      {
        required: true,
        message: '请上传身份证正面',
        type: 'string',
        trigger: 'change'
      },
      {
        type: 'string',
        trigger: 'change',
        validator: (_rule, value, callback) => {
          if (value && value.startsWith('blob:')) {
            return callback(new Error('图片还未上传完毕'));
          }
          callback();
        }
      }
    ],
    idCardImg2: [
      {
        required: true,
        message: '请上传身份证反面',
        type: 'string',
        trigger: 'change'
      },
      {
        type: 'string',
        trigger: 'change',
        validator: (_rule, value, callback) => {
          if (value && value.startsWith('blob:')) {
            return callback(new Error('图片还未上传完毕'));
          }
          callback();
        }
      }
    ],
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
        type: 'string',
        trigger: 'change'
      },
      {
        type: 'string',
        trigger: 'change',
        validator: (_rule, value, callback) => {
          if (
            value &&
            JSON.parse(value).some((d) => !d || d.startsWith('blob:'))
          ) {
            return callback(new Error('照片还未上传完毕'));
          }
          callback();
        }
      }
    ]
  });

  /* 保存编辑 */
  const save = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      console.log(form);
      EleMessage.success('数据已打印在控制台');
    });
  };

  /* 回显数据 */
  const setData = () => {
    const data = {
      id: 1,
      realName: '张三',
      idCardImg1:
        'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg',
      idCardImg2:
        'https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg',
      content: '2栋楼下的路灯已经坏了几天了都没人来维修一下',
      images:
        '["https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg","https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg"]'
    };
    assignFields(data);
    formRef.value?.clearValidate();
  };
</script>
