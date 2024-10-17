<template>
  <ele-page>
    <lazy-tree-table />
    <default-sorter />
    <reset-sorter />
    <merge-cell />
    <total-row />
    <expandable-table />
    <nested-table />
  </ele-page>
</template>

<script setup>
  import LazyTreeTable from './components/lazy-tree-table.vue';
  import DefaultSorter from './components/default-sorter.vue';
  import ResetSorter from './components/reset-sorter.vue';
  import MergeCell from './components/merge-cell.vue';
  import TotalRow from './components/total-row.vue';
  import ExpandableTable from './components/expandable-table.vue';
  import NestedTable from './components/nested-table.vue';
</script>

<script>
  export default {
    name: 'ExtensionTable'
  };
</script>
