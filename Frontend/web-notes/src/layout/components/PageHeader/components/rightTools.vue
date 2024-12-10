<template>
    <div class="rightTools">
        <p class="updatetime-text text-select">上次编辑&nbsp;{{ timeAgo(StorePage.pageData.updateTime) }}</p>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item" @click="dialogTableVisible = !dialogTableVisible">
                    <n-icon size="18">
                        <Search28Filled />
                    </n-icon>
                </div>
            </template>
            <span>查找文档内容 Ctrl+P</span>
        </n-tooltip>

        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div
                    style="padding: 4px 8px;box-sizing: border-box;margin-left: 6px;display: flex;align-items: center;justify-content: center">
                    <n-rate v-model:value="rateValue" clearable :count="1" @click="updateRate">
                        <n-icon size="18" color="#999">
                            <Star />
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


        <el-popover ref="popoverRef" :virtual-ref="buttonRef" placement="bottom" trigger="click" :width="400"
            virtual-triggering>
            <div class="sharebox">
                <SharePageBox/>
            </div>
        </el-popover><!-- 分享弹出框 -->

        <div v-if="dialogTableVisible" class="searchHighlight" tabindex="0" @focus="onFocus" @blur="onBlur">
            <el-input v-model="findlook" style="width: 100%;" autofocus placeholder="查找本页内容..." />
        </div><!-- 搜索对话框 -->
    </div>
</template>
<script setup>
import { ref, watch, onBeforeUnmount, inject } from 'vue';
import { timeAgo } from '@/utils/timeAgo'
import { highlightText } from '@/utils/searchHighlightText.js'
import { StarRegular, Star } from '@vicons/fa'
import { MoreHorizontal32Filled, Search28Filled, ChevronDoubleRight16Filled } from '@vicons/fluent'
import PageSettingsBox from '@/components/PageSettings.vue'
import SharePageBox from '@/components/SharePage.vue'
import { update } from '@/api/note/index.js'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()

// 分享弹出框
const buttonRef = ref()
const popoverRef = ref()
const onClickOutside = () => {
    unref(popoverRef).popperRef?.delayHide?.()
}

// 搜索对话框
const dialogTableVisible = ref(false);
// 获取焦点时，显示搜索框
const onFocus = () => {
    dialogTableVisible.value = true
    console.log('Div 获得了焦点')
}

// 失去焦点时，隐藏搜索框
const onBlur = () => {
    // 使用 setTimeout 延时隐藏，以防止焦点移动时触发隐藏
    console.log('Div 失去了焦点')
    setTimeout(() => {
        dialogTableVisible.value = false
    }, 200) // 延迟200ms，防止焦点移动时立即关闭
}





// 抽屉
const active = ref(false);

const activate = (place) => {
    active.value = true;
};


// 查找
let findlook = ref()

watch(findlook, (newVal, oldVal) => {
    console.log("搜索");

    highlightText(newVal)
})



// 收藏
const rateValue = ref(StorePage.pageData.collect); // 默认评分为1
const updateRate = () => {
    console.log(StorePage.pageData.collect);
    let collect = StorePage.pageData.collect == 0 ? 1 : 0
    update({ pageId: StorePage.pageData.pageId, collect: collect }).then((data) => {
        console.log("收藏成功", data);
        StorePage.pageData = data
        store.getSpaceData(store.routerParamsId.spaceId)
    }).catch((e) => {
        console.error('收藏失败', e);
    });
}
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


// 高亮搜索框
.searchHighlight {
    position: fixed;
    top: 100px;
    right: 200px;
    z-index: 999;
    padding: 1rem;
    background-color: #fff;
    border-radius: 6px;
    box-shadow: 0 0 5px #ccc;
}
</style>
