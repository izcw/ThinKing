<!-- 状态选择下拉框 -->
<template>
  <el-select clearable :model-value="modelValue" :placeholder="placeholder" class="ele-fluid"
    @update:modelValue="updateValue">
    <el-option v-for="item in data" :key="item.code" :value="item.code" :label="item.describe" />
  </el-select>
</template>

<script setup>
import { ref } from 'vue';

const emit = defineEmits(['update:modelValue']);

defineProps({
  modelValue: Number,
  placeholder: {
    type: String,
    default: '请选择状态'
  }
});

// 字典数据
const data = ref([
  { code: 0, describe: '正常' },
  { code: 1, describe: '冻结' },
  { code: 2, describe: '异常' },
  { code: 3, describe: '注销' },
]);

/* 更新选中数据 */
const updateValue = (value) => {
  emit('update:modelValue', value);
};
</script>
