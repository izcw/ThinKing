<!-- 搜索表单 -->
<template>
  <el-space wrap>
    <div
      style="width: 220px; max-width: calc(100vw - 84px); padding-right: 12px"
    >
      <el-input
        clearable
        v-model.trim="form.keywords"
        placeholder="输入关键字搜索"
      />
    </div>
    <el-button
      type="primary"
      class="ele-btn-icon"
      :icon="Search"
      @click="search"
    >
      查询
    </el-button>
    <el-button type="primary" class="ele-btn-icon" :icon="Plus" @click="add">
      新建
    </el-button>
    <el-button
      type="danger"
      class="ele-btn-icon"
      :icon="Delete"
      @click="remove"
    >
      删除
    </el-button>
  </el-space>
</template>

<script setup>
  import { Plus, Delete, Search } from '@element-plus/icons-vue';
  import { useFormData } from '@/utils/use-form-data';

  const emit = defineEmits(['search', 'add', 'remove']);

  // 表单数据
  const { form } = useFormData({
    keywords: ''
  });

  /* 搜索 */
  const search = () => {
    emit('search', form);
  };

  /* 添加 */
  const add = () => {
    emit('add');
  };

  /* 删除 */
  const remove = () => {
    emit('remove');
  };
</script>
