<template>
    <div class="MainContent">
        <div class="PageHeader">
            <PageHeaderBox />
        </div><!-- 页头 -->
        <div class="mainbox">
            <PanelSplitBox :defaultSize="300" :minPanelSize="250" :maxPanelSize="800" contentPanel="right"
                :defaultSwitch="true">
                <template v-slot:1>
                    <div class="sidebar">
                        <ToolSidebarBox />
                    </div>
                </template>
                <template v-slot:2>
                    <main class="content">
                        <ContentBox />
                        <levitatedSphereBox/>
                    </main>
                </template>
            </PanelSplitBox><!-- 分割面板 -->
        </div>
    </div>

</template>
<script setup>
import { ref } from 'vue'
import PanelSplitBox from '@/layout/components/PanelSplit.vue'
import ToolSidebarBox from '@/layout/components/toolSidebar/index.vue'
import ContentBox from './contentPage.vue'
import levitatedSphereBox from '@/layout/components/levitatedSphere.vue'
import PageHeaderBox from '@/layout/components/PageHeader/index.vue'

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

    .sidebar {
        width: 100%;
        height: 100%;
    }

    .content {
        width: 100%;
        height: 100%;
        position: relative;
    }
}
</style>
