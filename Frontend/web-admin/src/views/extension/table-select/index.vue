<template>
  <ele-page>
    <demo-basic />
    <demo-basic-page />
    <demo-multiple />
    <demo-advanced />
  </ele-page>
</template>

<script setup>
  import DemoBasic from './components/demo-basic.vue';
  import DemoBasicPage from './components/demo-basic-page.vue';
  import DemoMultiple from './components/demo-multiple.vue';
  import DemoAdvanced from './components/demo-advanced.vue';
</script>

<script>
  export default {
    name: 'ExtensionTableSelect'
  };
</script>
