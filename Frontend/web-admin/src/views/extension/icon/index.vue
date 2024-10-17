<template>
  <ele-page multi-card>
    <demo-basic />
    <demo-advanced />
  </ele-page>
</template>

<script setup>
  import DemoBasic from './components/demo-basic.vue';
  import DemoAdvanced from './components/demo-advanced.vue';
</script>

<script>
  export default {
    name: 'ExtensionIcon'
  };
</script>
