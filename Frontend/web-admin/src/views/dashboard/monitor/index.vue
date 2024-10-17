<template>
  <ele-page>
    <statistics-card />
    <el-row :gutter="16">
      <el-col :md="18" :sm="24" :xs="24">
        <map-card />
      </el-col>
      <el-col :md="6" :sm="24" :xs="24">
        <online-num />
        <browser-card />
      </el-col>
    </el-row>
    <el-row :gutter="16">
      <el-col :lg="12" :md="24" :sm="24" :xs="24">
        <user-rate />
      </el-col>
      <el-col :lg="6" :md="24" :sm="24" :xs="24">
        <user-satisfaction />
      </el-col>
      <el-col :lg="6" :md="24" :sm="24" :xs="24">
        <user-liveness />
      </el-col>
    </el-row>
  </ele-page>
</template>

<script setup>
  import StatisticsCard from './components/statistics-card.vue';
  import MapCard from './components/map-card.vue';
  import OnlineNum from './components/online-num.vue';
  import BrowserCard from './components/browser-card.vue';
  import UserRate from './components/user-rate.vue';
  import UserSatisfaction from './components/user-satisfaction.vue';
  import UserLiveness from './components/user-liveness.vue';
</script>

<script>
  export default {
    name: 'DashboardMonitor'
  };
</script>
