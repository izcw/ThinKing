<template>
    <div class="MainContent">
        <div class="PageHeader">
            <PageHeaderBox />
        </div><!-- 页头 -->
        <div class="mainbox">
            <PanelSplitBox :defaultSize="0" :minPanelSize="280" :maxPanelSize="800" contentPanel="right">
                <template v-slot:1>
                    <ToolSidebarBox /><!-- 工具侧边栏 -->
                </template>
                <template v-slot:2>
                    <div style="width: 100%;height: 100%; position: relative;">
                        <ContentBox />
                        <levitatedSphereBox /><!-- 悬浮球 -->
                    </div>
                </template>
            </PanelSplitBox><!-- 分割面板 -->
        </div>

    </div>


</template>

<script setup>
import { Crow, Connectdevelop, Blackberry, Magic } from '@vicons/fa'
import PanelSplitBox from '../components/PanelSplit.vue'
import PageHeaderBox from './PageHeader/index.vue'
import ToolSidebarBox from './toolSidebar/index.vue'
import ContentBox from './content/index.vue'
import levitatedSphereBox from './levitatedSphere.vue'

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