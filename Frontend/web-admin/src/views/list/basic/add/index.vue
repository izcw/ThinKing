<template>
  <div>
    <ele-card style="border-radius: 0">
      <ele-text type="heading" size="lg">添加用户</ele-text>
      <ele-text type="placeholder" style="margin-top: 6px">
        填写用户基本信息后点击保存按钮
      </ele-text>
    </ele-card>
    <ele-page>
      <ele-card>
        <edit-form />
      </ele-card>
    </ele-page>
  </div>
</template>

<script setup>
  import EditForm from '../components/edit-form.vue';
</script>

<script>
  export default {
    name: 'ListBasicAdd'
  };
</script>
