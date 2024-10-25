<template>
    <div class="PageHeader">
        <leftToolsBox />
        <rightToolsBox />
    </div>
</template>
<script setup>
import leftToolsBox from './components/leftTools.vue';
import rightToolsBox from './components/rightTools.vue';
</script>
<style scoped lang='scss'>
.PageHeader {
    padding: 0 6px;
    box-sizing: border-box;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
</style>
