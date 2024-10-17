<template>
  <ele-page>
    <el-row :gutter="16">
      <el-col :md="12" :sm="24" :xs="24">
        <demo-basic />
      </el-col>
      <el-col :md="12" :sm="24" :xs="24">
        <demo-danmu />
      </el-col>
      <el-col :md="12" :sm="24" :xs="24">
        <demo-live />
      </el-col>
      <el-col :md="12" :sm="24" :xs="24">
        <demo-music />
      </el-col>
    </el-row>
  </ele-page>
</template>

<script setup>
  import DemoBasic from './components/demo-basic.vue';
  import DemoDanmu from './components/demo-danmu.vue';
  import DemoLive from './components/demo-live.vue';
  import DemoMusic from './components/demo-music.vue';
</script>

<script>
  export default {
    name: 'ExtensionPlayer'
  };
</script>
