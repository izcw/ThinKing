<template>
    <div class="sidebar">
        <UserBox /><!-- 用户头像 -->
        <collectBox /><!-- 快速访问 收藏 -->
        <div class="text-select GMargin">
           <TreeDirectoryBox />
        </div>
        <spaceBox />
        <moreBox />
    </div>
</template>

<script setup>
import { ref } from "vue";
import UserBox from './components/UserBox.vue';
import collectBox from './components/collect.vue';
import spaceBox from './components/space.vue';
import moreBox from './components/more.vue';
import TreeDirectoryBox from './components/TreeDirectory.vue';

</script>

<style scoped lang='scss'>
.sidebar{
    width: 100%;
    height: 100%;
    position: relative;
    overflow: hidden;
    padding-bottom: 50px;
    box-sizing: border-box;
}
</style>
