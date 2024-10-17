<template>
  <ele-card header="拖拽、拉伸、全屏">
    <el-form label-width="120px" style="max-width: 380px">
      <el-form-item label="是否可拖出边界">
        <el-select
          multiple
          clearable
          v-model="moveOut"
          placeholder="不可拖出边界"
          class="ele-fluid"
        >
          <el-option value="top" label="top" />
          <el-option value="bottom" label="bottom" />
          <el-option value="left" label="left" />
          <el-option value="right" label="right" />
        </el-select>
      </el-form-item>
      <el-form-item label="是否可拉伸大小">
        <el-select v-model="resizable" class="ele-fluid">
          <el-option value="false" label="不可拉伸大小" />
          <el-option value="true" label="可以拉伸大小" />
          <el-option value="horizontal" label="只可横向拉伸" />
          <el-option value="vertical" label="只可纵向拉伸" />
        </el-select>
      </el-form-item>
      <el-form-item label="最大化切换按钮">
        <el-switch v-model="maxable" size="small" />
      </el-form-item>
      <el-form-item label="关闭后重置位置">
        <el-switch v-model="resetOnClose" size="small" />
      </el-form-item>
      <el-form-item label="限制在主体区域">
        <el-switch v-model="inner" size="small" />
      </el-form-item>
      <el-form-item label="默认打开位置">
        <el-select
          clearable
          v-model="position"
          placeholder="请选择"
          class="ele-fluid"
        >
          <el-option value="top" label="顶部" />
          <el-option value="bottom" label="底部" />
          <el-option value="left" label="左边" />
          <el-option value="right" label="右边" />
          <el-option value="leftTop" label="左上角" />
          <el-option value="leftBottom" label="左下角" />
          <el-option value="rightTop" label="右上角" />
          <el-option value="rightBottom" label="右下角" />
          <el-option value="center" label="正中间" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" class="ele-btn-icon" @click="openDialog">
          打开弹窗
        </el-button>
      </el-form-item>
    </el-form>
  </ele-card>
  <ele-modal
    form
    :width="400"
    title="高级弹窗"
    v-model="visible"
    :move-out="moveOut"
    :resizable="modalResizable"
    :maxable="maxable"
    :inner="inner"
    :reset-on-close="resetOnClose"
    :position="position"
    :append-to-body="true"
    @closed="cancelDialog"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="70px">
      <el-form-item label="用户名" prop="nickname">
        <el-input
          clearable
          v-model="form.nickname"
          placeholder="请输入用户名"
        />
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-select
          clearable
          v-model="form.sex"
          placeholder="请选择性别"
          class="ele-fluid"
        >
          <el-option value="男">男</el-option>
          <el-option value="女">女</el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="手机号" prop="phone">
        <el-input clearable v-model="form.phone" placeholder="请输入手机号" />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input clearable v-model="form.email" placeholder="请输入邮箱" />
      </el-form-item>
      <el-form-item label="个人简介">
        <el-input
          :rows="4"
          type="textarea"
          v-model="form.introduction"
          placeholder="请输入个人简介"
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="cancelDialog">取消</el-button>
      <el-button type="primary" @click="onSave">保存</el-button>
    </template>
  </ele-modal>
</template>

<script setup>
  import { ref, reactive, computed } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';

  // 弹窗是否打开
  const visible = ref(false);

  // 是否允许拖出边界
  const moveOut = ref([]);

  // 是否可拉伸
  const resizable = ref('false');

  // 是否显示最大化切换按钮
  const maxable = ref(true);

  // 关闭后重置位置
  const resetOnClose = ref(true);

  // 限制在主体区域
  const inner = ref(false);

  // 默认位置
  const position = ref();

  // 表单实例
  const formRef = ref(null);

  // 弹窗拉伸属性
  const modalResizable = computed(() => {
    return resizable.value === 'true'
      ? true
      : resizable.value === 'false'
      ? false
      : resizable.value;
  });

  // 表单数据
  const { form, resetFields } = useFormData({
    nickname: '',
    sex: void 0,
    phone: '',
    email: '',
    introduction: ''
  });

  // 表单验证规则
  const rules = reactive({
    nickname: [
      {
        required: true,
        message: '请输入用户名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    sex: [
      {
        required: true,
        message: '请选择性别',
        type: 'string',
        trigger: 'blur'
      }
    ],
    phone: [
      {
        required: true,
        message: '请输入手机号',
        type: 'string',
        trigger: 'blur'
      }
    ],
    email: [
      {
        required: true,
        message: '请输入邮箱',
        type: 'string',
        trigger: 'blur'
      }
    ]
  });

  /* 打开弹窗 */
  const openDialog = () => {
    if (!visible.value) {
      visible.value = true;
    }
  };

  /* 关闭弹窗 */
  const cancelDialog = () => {
    resetFields();
    formRef.value?.clearValidate();
    visible.value = false;
  };

  /* 保存编辑 */
  const onSave = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      EleMessage.success('保存成功');
    });
  };
</script>
