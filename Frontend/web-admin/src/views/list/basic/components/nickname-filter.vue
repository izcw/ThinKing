<!-- 表头筛选框 -->
<template>
  <div
    style="position: absolute; right: 4px; top: 50%; margin-top: -12px"
    @click.stop=""
  >
    <ele-popover
      :width="200"
      trigger="click"
      placement="bottom-end"
      :popper-options="{
        modifiers: [
          { name: 'arrow', options: { padding: 24 } },
          { name: 'offset', options: { offset: [24, 4] } }
        ]
      }"
    >
      <template #reference>
        <ele-text type="placeholder" :icon="Search" />
      </template>
      <div style="margin-bottom: 12px">
        <el-input
          size="small"
          v-model="nickname"
          placeholder="请输入关键字"
          @change="onSearch"
        />
      </div>
      <el-space size="default" style="width: 100%; justify-content: end">
        <el-button size="small" @click="onReset">重置</el-button>
        <el-button
          size="small"
          type="primary"
          :icon="Search"
          class="ele-btn-icon"
          @click="onSearch"
        >
          搜索
        </el-button>
      </el-space>
    </ele-popover>
  </div>
</template>

<script setup>
  import { ref } from 'vue';
  import { Search } from '@element-plus/icons-vue';

  const emit = defineEmits(['search']);

  const nickname = ref('');

  /* 搜索 */
  const onSearch = () => {
    emit('search', nickname.value);
  };

  /*  重置 */
  const onReset = () => {
    nickname.value = '';
    onSearch();
  };
</script>
