<template>
  <el-select
    clearable
    :model-value="modelValue"
    :placeholder="placeholder"
    class="ele-fluid"
    @update:modelValue="updateValue"
  >
    <el-option
      v-for="item in data"
      :key="item.code"
      :value="item.code"
      :label="item.describe"
    />
  </el-select>
</template>

<script setup>
import { ref } from 'vue';
import { SubscribeListStatus } from '@/api/common/index.js';

// 定义事件触发器
const emit = defineEmits(['update:modelValue']);

// 定义 Props
defineProps({
  modelValue: Number,
  placeholder: {
    type: String,
    default: '请选择状态',
  },
});

// 字典数据
const data = ref([]);

// 获取状态数据
SubscribeListStatus()
  .then((response) => {
    data.value = response;
  })
  .catch((e) => {
    EleMessage.error(e.message);
  });

/* 更新选中数据 */
const updateValue = (value) => {
  emit('update:modelValue', value);
};
</script>
