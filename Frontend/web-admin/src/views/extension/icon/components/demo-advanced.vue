<template>
  <ele-card header="进阶用法">
    <div style="max-width: 260px">
      <ele-icon-select
        clearable
        filterable
        :data="icons"
        v-model="selectedIcon"
        :hide-on-single-tab="true"
        placeholder="请选择"
      >
        <template #icon="{ icon, prefix }">
          <img
            :src="`https://cdn.eleadmin.com/20200609/ic_file_${icon}_sm.png`"
            :style="
              prefix
                ? { maxWidth: '22px', maxHeight: '22px' }
                : { maxWidth: '100%', maxHeight: '100%' }
            "
          />
        </template>
      </ele-icon-select>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';

  // 选中值
  const selectedIcon = ref('');

  // 图标数据
  const icons = ref([
    {
      title: '',
      children: [
        {
          title: '文档',
          icons: [
            'folder',
            'word',
            'excel',
            'ppt',
            'pdf',
            'visio',
            'text',
            'code',
            'htm',
            'fonts',
            'zip',
            'ps',
            'cad',
            'bt',
            'misc'
          ]
        },
        {
          title: '媒体',
          icons: ['flash', 'music', 'video', 'picture']
        },
        {
          title: '应用',
          icons: ['android', 'exe', 'ipa']
        }
      ]
    }
  ]);
</script>
