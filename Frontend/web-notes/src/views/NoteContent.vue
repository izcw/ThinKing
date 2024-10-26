<template>
    <PanelSplitBox :defaultSize="300" :minPanelSize="280" :maxPanelSize="800" contentPanel="right"
        :defaultSwitch="true">
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
</template>
<script setup>
import PanelSplitBox from '@/layout/components/PanelSplit.vue'

import ToolSidebarBox from '@/layout/components/toolSidebar/index.vue'
import ContentBox from '@/layout/components/content/index.vue'
import levitatedSphereBox from '@/layout/components/levitatedSphere.vue'
</script>
<style scoped lang='scss'></style>
