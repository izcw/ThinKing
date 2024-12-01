<template>
    <div class="layout">
        <PanelSplitBox :defaultSize="300" :minPanelSize="200" :maxPanelSize="800" contentPanel="left"
            :defaultSwitch="true">
            <template v-slot:1>
                <div class="sidebar">
                    <SidebarBox /><!-- 系统侧边栏 -->
                </div>
            </template>
            <template v-slot:2>
                <main class="content">
                    <router-view></router-view>
                </main>
            </template>
        </PanelSplitBox>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import SidebarBox from './components/sidebar/index.vue';
import PanelSplitBox from './components/PanelSplit.vue'

</script>

<style scoped lang='scss'>
.layout {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100vh;
}

.sidebar {
    width: 100%;
    height: 100%;
    background-color: #FAFAFA;
}

.content {
    flex: 1;
    background-color: #fff;
    overflow-y: auto;
    width: 100%;
    height: 100%;
}
</style>