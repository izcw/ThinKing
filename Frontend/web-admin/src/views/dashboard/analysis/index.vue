<template>
  <ele-page>
    <statistics-card />
    <sale-card />
    <el-row :gutter="16">
      <el-col :md="16" :sm="14" :xs="24">
        <visit-hour />
      </el-col>
      <el-col :md="8" :sm="10" :xs="24">
        <hot-search />
      </el-col>
    </el-row>
  </ele-page>
</template>

<script setup>
  import StatisticsCard from './components/statistics-card.vue';
  import SaleCard from './components/sale-card.vue';
  import VisitHour from './components/visit-hour.vue';
  import HotSearch from './components/hot-search.vue';
</script>

<script>
  export default {
    name: 'DashboardAnalysis'
  };
</script>
