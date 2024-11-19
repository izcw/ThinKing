<!-- 套餐选择下拉框 -->
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
      :key="item.subscribeId"
      :value="item.subscribeId"
      :label="item.subscribeName"
    />
  </el-select>
</template>

<script setup>
  import { ref } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { listSubscribe } from '@/api/note/subscribe/index';

  const emit = defineEmits(['update:modelValue']);

  defineProps({
    modelValue: Number,
    placeholder: {
      type: String,
      default: '请选择套餐'
    }
  });

  // 字典数据
  const data = ref([]);

  /* 更新选中数据 */
  const updateValue = (value) => {
    emit('update:modelValue', value);
  };

  /* 获取字典数据 */
  listSubscribe ()
    .then((list) => {
      data.value = list;
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
</script>
