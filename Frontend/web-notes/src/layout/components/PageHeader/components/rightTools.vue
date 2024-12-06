<template>
    <div class="rightTools">
        <p class="updatetime-text text-select">上次编辑&nbsp;{{ timeAgo(StorePage.pageData.updateTime) }}</p>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item" @click="dialogTableVisible = true">
                    <n-icon size="18">
                        <Search28Filled />
                    </n-icon>
                </div>
            </template>
            <span>查找文档内容 Ctrl+P</span>
        </n-tooltip>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item">
                    <n-rate clearable :count="1">
                        <n-icon size="18">
                            <StarRegular />
                        </n-icon>
                    </n-rate>
                </div>
            </template>
            <span>收藏 加入快速访问</span>
        </n-tooltip>
        <p class="share-text text-select Tools-item" ref="buttonRef" v-click-outside="onClickOutside">分享</p>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item" @click="activate('right')">
                    <n-icon size="18">
                        <MoreHorizontal32Filled />
                    </n-icon>
                </div>
            </template>
            <span>页面设置</span>
        </n-tooltip>


        <el-drawer v-model="active" :size="340" direction="rtl" title="页面设置">
            <PageSettingsBox />
        </el-drawer>


        <el-popover ref="popoverRef" :virtual-ref="buttonRef" placement="bottom" trigger="click" :width="500"
            virtual-triggering>
            <div class="sharebox"></div>
        </el-popover><!-- 分享弹出框 -->

        <el-dialog v-model="dialogTableVisible" width="400" :show-close="false">
            <el-input v-model="findlook" style="width: 100%;" :autofocus="true" placeholder="查找本页内容..." />
        </el-dialog><!-- 搜索对话框 -->
    </div>
</template>
<script setup>
import { ref, onMounted, onBeforeUnmount, inject } from 'vue';
import { timeAgo } from '@/utils/timeAgo'
import { StarRegular } from '@vicons/fa'
import { MoreHorizontal32Filled, Search28Filled, ChevronDoubleRight16Filled } from '@vicons/fluent'
import PageSettingsBox from '@/components/PageSettings.vue'
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()

// 分享弹出框
const buttonRef = ref()
const popoverRef = ref()
const onClickOutside = () => {
    unref(popoverRef).popperRef?.delayHide?.()
}

// 搜索对话框
const dialogTableVisible = ref(false)

// 抽屉
const active = ref(false);

const activate = (place) => {
    active.value = true;
};


// 查找
let findlook = ref()
</script>
<style scoped lang='scss'>
.rightTools {
    display: flex;
    align-items: center;

    .updatetime-text {
        font-size: 12px;
        transform: scale(0.9);
        color: #999;
        padding: 4px 8px;
        box-sizing: border-box;
    }

    .share-text {
        font-size: 14px;
        color: #333;
        cursor: pointer;
    }

    .Tools-item {
        margin-left: 6px;
    }
}

// 分享
.sharebox {
    min-height: 200px;
    margin: 1rem 0 3rem 0;

}
</style>
