<template>
    <div class="layout">
        <PanelSplitBox :defaultSize="280" :minPanelSize="200" :maxPanelSize="800" contentPanel="left">
            <template v-slot:1>
                <div class="sidebar">
                    <SidebarBox /><!-- 系统侧边栏 -->
                </div>
            </template>
            <template v-slot:2>
                <main class="content">
                    <MainContentBox />
                </main>
            </template>
        </PanelSplitBox>
    </div>
</template>

<script setup>

import SidebarBox from './components/sidebar/index.vue';
import MainContentBox from './components/MainContent.vue';
import PanelSplitBox from './components/PanelSplit.vue'
</script>

<style scoped>
.layout {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100vh;
}

.sidebar {
    width: 100%;
    height: 100%;
    background-color: #F7F7F5;
    padding: 1rem;
    box-sizing: border-box
}

.content {
    flex: 1;
    background-color: #fff;
    overflow-y: auto;
    width: 100%;
    height: 100%;
}
</style>