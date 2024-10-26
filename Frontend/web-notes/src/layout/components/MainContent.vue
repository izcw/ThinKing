<template>
    <div class="MainContent">
        <div class="PageHeader">
            <PageHeaderBox />
        </div><!-- 页头 -->
        <div class="mainbox">
            <router-view></router-view>
        </div>
    </div>
</template>

<script setup>
import { RouterLink, RouterView } from 'vue-router'
import PageHeaderBox from './PageHeader/index.vue'

</script>
<style scoped lang='scss'>
.MainContent {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.PageHeader {
    width: 100%;
    height: 50px;
    display: flex;
}

.mainbox {
    width: 100%;
    height: calc(100% - 50px);
}
</style>