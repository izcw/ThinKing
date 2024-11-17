<template>
    <n-tooltip placement="bottom" trigger="hover">
        <template #trigger>
            <div class="Tools-item"
                style="width: 36px;height: 36px;position: fixed;top: 1rem;left: 1rem;z-index: 99999;background-color: #fff"
                @click="toggleSidebarStatus" v-show="!parentSidebarStatus">
                <n-icon size="20">
                    <ChevronDoubleRight16Filled />
                </n-icon>
            </div>
        </template>
        <span>展开侧边栏 Ctrl+\</span>
    </n-tooltip>
</template>
<script setup>
import { inject } from 'vue';
import { ChevronDoubleRight16Filled } from '@vicons/fluent'

// 展开关闭侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus'); // 注入父组件的状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};
</script>
<style scoped lang='scss'></style>
