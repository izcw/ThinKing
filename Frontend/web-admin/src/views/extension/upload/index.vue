<template>
  <ele-page>
    <demo-basic />
    <demo-advanced />
    <demo-multiple />
    <demo-form1 />
    <demo-form2 />
    <demo-customer />
    <demo-file />
  </ele-page>
</template>

<script setup>
  import DemoBasic from './components/demo-basic.vue';
  import DemoAdvanced from './components/demo-advanced.vue';
  import DemoMultiple from './components/demo-multiple.vue';
  import DemoForm1 from './components/demo-form1.vue';
  import DemoForm2 from './components/demo-form2.vue';
  import DemoCustomer from './components/demo-customer.vue';
  import DemoFile from './components/demo-file.vue';
</script>

<script>
  export default {
    name: 'ExtensionUpload'
  };
</script>
