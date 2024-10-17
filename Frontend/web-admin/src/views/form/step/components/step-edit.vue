<template>
  <el-form
    ref="formRef"
    :model="form"
    :rules="rules"
    label-width="108px"
    style="padding-right: 60px"
  >
    <el-form-item label="付款账户" prop="account">
      <el-select
        clearable
        v-model="form.account"
        placeholder="请选择付款账户"
        class="ele-fluid"
      >
        <el-option value="eleadmin@eclouds.com" label="eleadmin@eclouds.com" />
      </el-select>
    </el-form-item>
    <el-form-item label="收款账户" prop="receiver">
      <el-input clearable v-model="form.receiver" placeholder="请输入收款账户">
        <template #prepend>
          <el-select v-model="form.pay" style="width: 100px">
            <el-option value="alipay" label="支付宝" />
            <el-option value="wxpay" label="微信" />
          </el-select>
        </template>
      </el-input>
    </el-form-item>
    <el-form-item label="收款人姓名" prop="name">
      <el-input clearable v-model="form.name" placeholder="请输入收款人姓名" />
    </el-form-item>
    <el-form-item label="转账金额" prop="amount">
      <el-input
        clearable
        v-model.number="form.amount"
        placeholder="请输入转账金额"
        :prefix-icon="prefixIcon"
      />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" :loading="loading" @click="submit">
        下一步
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script setup>
  import { ref, reactive, h } from 'vue';
  import { useFormData } from '@/utils/use-form-data';

  const prefixIcon = h('span', { style: { fontStyle: 'normal' } }, '￥');

  const emit = defineEmits(['done']);

  // 提交状态
  const loading = ref(false);

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form } = useFormData({
    account: 'eleadmin@eclouds.com',
    receiver: 'test@example.com',
    pay: 'alipay',
    name: 'Alex',
    amount: 500
  });

  // 表单验证规则
  const rules = reactive({
    account: [
      {
        required: true,
        message: '请选择付款账户',
        type: 'string',
        trigger: 'blur'
      }
    ],
    receiver: [
      {
        required: true,
        message: '请输入收款账户',
        type: 'string',
        trigger: 'blur'
      }
    ],
    name: [
      {
        required: true,
        message: '请输入收款人姓名',
        type: 'string',
        trigger: 'blur'
      }
    ],
    amount: [
      {
        required: true,
        message: '请输入合法金额数字',
        type: 'number',
        trigger: 'blur'
      }
    ]
  });

  /* 步骤一提交 */
  const submit = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      loading.value = true;
      setTimeout(() => {
        loading.value = false;
        emit('done', form);
      }, 300);
    });
  };
</script>
