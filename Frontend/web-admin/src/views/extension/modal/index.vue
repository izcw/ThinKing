<template>
  <ele-page>
    <demo-modal />
    <multiple-modal />
  </ele-page>
</template>

<script setup>
  import DemoModal from './components/demo-modal.vue';
  import MultipleModal from './components/multiple-modal.vue';
</script>

<script>
  export default {
    name: 'ExtensionDialog'
  };
</script>
