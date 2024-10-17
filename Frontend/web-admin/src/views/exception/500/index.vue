<template>
  <div style="padding-top: 40px">
    <el-result title="500">
      <template #icon>
        <div style="width: 250px; height: 295px; margin-bottom: 10px">
          <icon-svg />
        </div>
      </template>
      <template #sub-title>
        <ele-text type="placeholder">抱歉, 服务器出错了.</ele-text>
      </template>
      <template #extra>
        <router-link to="/" style="display: inline-flex; text-decoration: none">
          <el-button type="primary">返回首页</el-button>
        </router-link>
      </template>
    </el-result>
  </div>
</template>

<script setup>
  import IconSvg from './components/icon-svg.vue';
</script>

<script>
  export default {
    name: 'Exception500'
  };
</script>
