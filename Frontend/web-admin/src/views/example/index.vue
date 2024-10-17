<template>
  <ele-page>
    <menu-badge />
    <menu-group />
    <demo-tab />
    <demo-component />
  </ele-page>
</template>

<script setup>
  import MenuBadge from './components/menu-badge.vue';
  import MenuGroup from './components/menu-group.vue';
  import DemoTab from './components/demo-tab.vue';
  import DemoComponent from './components/demo-component.vue';
</script>

<script>
  export default {
    name: 'Example'
  };
</script>
