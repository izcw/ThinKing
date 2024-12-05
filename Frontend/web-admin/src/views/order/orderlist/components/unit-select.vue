<template>
  <el-select clearable :model-value="modelValue" :placeholder="placeholder" class="ele-fluid"
    @update:modelValue="updateValue">
    <el-option v-for="(item, index) in data" :key="index" :value="item.unit" :label="item.describe" />
  </el-select>
</template>

<script setup>
import { ref } from 'vue';
import { SnitListStatus } from '@/api/common/index.js';

// 定义事件触发器
const emit = defineEmits(['update:modelValue']);

// 定义 Props
defineProps({
  modelValue: String,
  placeholder: {
    type: String,
    default: '请选择',
  },
});

// 字典数据
const data = ref([]);

// 获取数据
SnitListStatus()
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
