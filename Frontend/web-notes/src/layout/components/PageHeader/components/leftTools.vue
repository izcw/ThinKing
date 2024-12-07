<template>
    <div class="leftTools">
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item" @click="toggleSidebarStatus" v-show="!parentSidebarStatus">
                    <n-icon size="20">
                        <ChevronDoubleRight16Filled />
                    </n-icon>
                </div>
            </template>
            <span>展开侧边栏 Ctrl+\</span>
        </n-tooltip>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item">
                    <n-icon size="16">
                        <ArrowLeft28Filled />
                    </n-icon>
                </div>
            </template>
            <span>返回 Ctrl+[</span>
        </n-tooltip>
        <n-tooltip placement="bottom" trigger="hover" class="LessHiddenElements">
            <template #trigger>
                <div class="Tools-item">
                    <n-icon size="16">
                        <ArrowRight28Filled />
                    </n-icon>
                </div>
            </template>
            <span>前进 Ctrl+]</span>
        </n-tooltip>
        <!-- 前进后退 -->

        <div class="Breadcrumb text-select">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item :to="{ path: '/space1' }">
                    <el-text style="max-width: 120px;" truncated size="small">
                        面包屑
                    </el-text>
                </el-breadcrumb-item>
                <el-breadcrumb-item :to="{ path: './pfdgg' }">
                    <el-text style="max-width: 120px;" truncated size="small">
                        面包屑
                    </el-text>
                </el-breadcrumb-item>
                <el-breadcrumb-item>
                    <el-text style="max-width: 120px;" truncated size="small">
                        欢迎来到ThinKing笔记
                    </el-text></el-breadcrumb-item>
            </el-breadcrumb>
        </div><!-- 面包屑 -->

    </div>

</template>
<script setup>
import { inject } from 'vue';
import { StarRegular } from '@vicons/fa'
import { ArrowLeft28Filled, ArrowRight28Filled, ChevronDoubleRight16Filled } from '@vicons/fluent'

// 展开关闭侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus'); // 注入父组件的状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};
</script>
<style scoped lang='scss'>
.leftTools {
    display: flex;
    align-items: center;

    .Breadcrumb {
        margin-left: 12px;
    }

    .Tools-item {
        margin-right: 6px;
    }
}


@media (max-width: 768px) {
    .LessHiddenElements {
        display: none;
    }
}
</style>
