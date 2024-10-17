<template>
  <ele-page>
    <demo-picker />
    <demo-map />
    <demo-track />
  </ele-page>
</template>

<script setup>
  import DemoPicker from './components/demo-picker.vue';
  import DemoMap from './components/demo-map.vue';
  import DemoTrack from './components/demo-track.vue';
</script>

<script>
  export default {
    name: 'ExtensionMap'
  };
</script>
