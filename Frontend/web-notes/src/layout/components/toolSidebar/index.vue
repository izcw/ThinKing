<!--
* @FileDescription: 工具侧边栏
-->
<template>
    <div class="toolSidebar">
        <n-tabs type="segment" animated default-value="chap1" @before-leave="handleBeforeLeave"
            @update:value="handleUpdateValue">
            <n-tab-pane name="chap1" tab="目录">
                <catalogOutlineBox />
            </n-tab-pane>
            <n-tab-pane name="chap2" tab="AI">
                <AIStormBox />
            </n-tab-pane>
            <!-- <n-tab-pane name="chap3" tab="批注">
                <AnnotationsBox />
            </n-tab-pane> -->
        </n-tabs>
    </div>


</template>
<script setup>
import { ref, onMounted, onBeforeUnmount, inject } from 'vue';
import catalogOutlineBox from './components/catalogOutline.vue'
import AIStormBox from './components/AIStorm.vue'
import AnnotationsBox from './components/Annotations.vue'


let handleUpdateValue = ref()

// 展开关闭侧边栏状态
const updateParentSidebarWidth = inject('updateParentSidebarWidth'); // 注入更新状态的方法
const toggleSidebarWidth = (width) => {
    updateParentSidebarWidth(width);
};

const handleBeforeLeave = (tabName) => {
    switch (tabName) {
        case 'chap2':
            console.log('ai')
            toggleSidebarWidth(550)
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
    box-sizing: border-box;
}
</style>
