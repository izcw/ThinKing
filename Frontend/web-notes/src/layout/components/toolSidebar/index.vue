<!--
* @FileDescription: 工具侧边栏
-->
<template>
    <div class="toolSidebar">
        <div v-if="storeEditor.isEditable" style="padding: 1rem 0;box-sizing: border-box;">
            <catalogOutlineBox />
        </div>
        <n-tabs v-else type="segment" v-model:value="store.TabsStatus" animated @before-leave="handleBeforeLeave">
            <n-tab-pane name="tabP1" tab="目录">
                <catalogOutlineBox />
            </n-tab-pane>
            <n-tab-pane name="tabP2" tab="AI">
                <AIStormBox />
            </n-tab-pane>
        </n-tabs>
    </div>
</template>
<script setup>
import { ref, onMounted, watch, inject, provide } from 'vue';
import catalogOutlineBox from './components/catalogOutline.vue'
import AIStormBox from './components/AIStorm.vue'
import { useSettingStore } from '@/stores/setting'
const store = useSettingStore()

import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()

import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore()



// 展开关闭侧边栏宽度
const updateParentSidebarWidth = inject('updateParentSidebarWidth'); // 注入更新状态的方法
const toggleSidebarWidth = (width) => {
    updateParentSidebarWidth(width);
};

// 展开关闭侧边栏状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = (val) => {
    updateParentSidebarStatus(val);
};

// 监听ai悬浮球
watch(() => store.switchTabsStatus, (newValue) => {
    handleBeforeLeave(store.TabsStatus)
});

const handleBeforeLeave = (tabName) => {
    switch (tabName) {
        case 'tabP2':
            toggleSidebarStatus(true)
            toggleSidebarWidth(500)
            return true;
        default:
            toggleSidebarWidth(300)
            return true;
    }
};



</script>
<style scoped lang='scss'>
.toolSidebar {
    width: 100%;
    height: 100%;
    padding: 0 1rem;
    padding-top: 0.5rem;
    box-sizing: border-box;
}
</style>
