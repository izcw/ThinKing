<template>
  <ele-page>
    <ele-card header="基础用法">
      <ele-avatar-group
        :data="data"
        :max-count="4"
        :overflow-popover="false"
        :item-style="{ borderWidth: '2px' }"
      />
    </ele-card>
    <ele-card header="超出显示">
      <ele-avatar-group
        :data="data"
        :max-count="4"
        :item-style="{ borderWidth: '2px' }"
      />
    </ele-card>
    <ele-card header="鼠标移入展开">
      <ele-avatar-group
        hover-open
        :data="data"
        :item-style="{ borderWidth: '2px' }"
      />
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';

  // 数据
  const data = ref([
    {
      label: 'SunSmile',
      value:
        'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
    },
    {
      label: '你的名字很好听',
      value:
        'https://cdn.eleadmin.com/20200609/b6a811873e704db49db994053a5019b2.jpg'
    },
    {
      label: '全村人的希望',
      value:
        'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
    },
    {
      label: 'Jasmine',
      value:
        'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg'
    },
    {
      label: '酷酷的大叔',
      value:
        'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
    },
    {
      label: '管理员',
      value: 'https://cdn.eleadmin.com/20200610/avatar.jpg'
    }
  ]);
</script>

<script>
  export default {
    name: 'ExtensionAvatar'
  };
</script>
