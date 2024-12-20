<template>
    <div class="layout" v-if="store.userInfoData">
        <PanelSplitBox :defaultSize="320" :minPanelSize="200" :maxPanelSize="800" contentPanel="left"
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
    <div v-else v-loading="true" style="width: 100%;height: 100%;">

    </div>
</template>

<script setup>
import { ref } from 'vue';
import SidebarBox from './components/sidebar/index.vue';
import PanelSplitBox from './components/PanelSplit.vue'

import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()



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
    background-color: #f7f7f7;
}

.content {
    flex: 1;
    background-color: #fff;
    overflow-y: auto;
    width: 100%;
    height: 100%;
}
</style>