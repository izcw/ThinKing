<!-- 机构类型选择下拉框 -->
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
      :key="item.dictDataCode"
      :value="item.dictDataCode"
      :label="item.dictDataName"
    />
  </el-select>
</template>

<script setup>
  import { ref } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { listDictionaryData } from '@/api/system/dictionary-data';

  const emit = defineEmits(['update:modelValue']);

  defineProps({
    modelValue: String,
    placeholder: {
      type: String,
      default: '请选择机构类型'
    }
  });

  // 机构类型数据
  const data = ref([]);

  /* 更新选中数据 */
  const updateValue = (value) => {
    emit('update:modelValue', value);
  };

  /* 获取机构类型数据 */
  listDictionaryData({
    dictCode: 'organization_type'
  })
    .then((list) => {
      data.value = list;
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
</script>
