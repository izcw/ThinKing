<template>
    <div class="rightTools">
        <p class="updatetime-text text-select">上次编辑&nbsp;47分&nbsp;前</p>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item">
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
                    <n-rate clearable count="1">
                        <n-icon size="18">
                            <StarRegular />
                        </n-icon>
                    </n-rate>
                </div>
            </template>
            <span>收藏 加入快速访问</span>
        </n-tooltip>
        <p class="share-text text-select Tools-item">分享</p>
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

        <n-drawer v-model:show="active" :width="340" :placement="placement" show-mask="transparent">
            <n-drawer-content title="页面设置">
                <PageSettingsBox />
            </n-drawer-content>
        </n-drawer>
    </div>
</template>
<script setup>
import { ref, onMounted, onBeforeUnmount, inject } from 'vue';
import { StarRegular } from '@vicons/fa'
import { MoreHorizontal32Filled, Search28Filled, ChevronDoubleRight16Filled } from '@vicons/fluent'
import PageSettingsBox from '@/components/PageSettings.vue'

// 抽屉
const active = ref(false);
const placement = ref('right');

const activate = (place) => {
    active.value = true;
    placement.value = place;
};
</script>
<style scoped lang='scss'>
.rightTools {
    display: flex;
    align-items: center;

    .updatetime-text {
        font-size: 12px;
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
</style>
