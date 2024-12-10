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
                <el-breadcrumb-item v-for="(item, index) in getBreadcrumbItems"
                    :to="{ path: '/space/' + item.spaceId + '/' + item.pageId }">
                    <el-text style="max-width: 120px;display: flex;align-items: center;" truncated size="small">
                        <span class="icon" v-if="item.icon">{{ item.icon }}</span>
                        <n-icon class="icon" size="12" v-else>
                            <FileTextOutlined />
                        </n-icon>
                        {{ item.title }}
                    </el-text>
                </el-breadcrumb-item>

                <!-- 超过三个 -->
                <!-- <el-breadcrumb-item v-else>
                    <el-text style="display: flex;align-items: center;" truncated size="small">
                        <n-icon class="icon" size="12">
                            <MoreHorizontal32Regular />
                        </n-icon>
                    </el-text>
                </el-breadcrumb-item> -->
            </el-breadcrumb>
        </div><!-- 面包屑 -->

    </div>

</template>
<script setup>
import { ref, inject, computed } from 'vue';
import { StarRegular } from '@vicons/fa'
import { ArrowLeft28Filled, ArrowRight28Filled, ChevronDoubleRight16Filled, MoreHorizontal32Regular } from '@vicons/fluent'
import { FileTextOutlined } from '@vicons/antd'
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()

// 展开关闭侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus'); // 注入父组件的状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};



// 计算需要显示的面包屑数据
let exceedItem = ref(false)
const getBreadcrumbItems = computed(() => {
    const data = StorePage.pageDataParent;
    if (data.length <= 2) {
        return data; // 不超过 2 个时直接返回
    }
    exceedItem.value = true;
    // 超过 2 个时，取前两个和最后一个
    return [...data.slice(0, 1), data[data.length - 2], data[data.length - 1]];
});
</script>
<style scoped lang='scss'>
.leftTools {
    display: flex;
    align-items: center;

    .Breadcrumb {
        margin-left: 12px;

        span {
            font-size: 12px !important;
        }

        .icon {
            margin-right: 2px;
        }
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
