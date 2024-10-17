<template>
  <ele-page>
    <excel-export />
    <excel-import />
  </ele-page>
</template>

<script setup>
  import ExcelExport from './components/excel-export.vue';
  import ExcelImport from './components/excel-import.vue';
</script>

<script>
  export default {
    name: 'ExtensionExcel'
  };
</script>
