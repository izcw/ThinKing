<template>
    <div class="contentBox" ref="contentBoxRef">
        <div id="BackTop"></div><!-- 回到顶部 -->
        <div class="cover" :style="{
            'background-image': coverImage ? 'url(' + coverImage + ')' : 'none',
            'height': coverImage ? '280px' : '70px'
        }">
            <div class="SelectCover">
                <el-button plain size="small" ref="buttonCoverRef" v-click-outside="onClickOutside">更换封面</el-button>
            </div>
            <el-popover ref="popoverCoverRef" :virtual-ref="buttonCoverRef" placement="bottom" trigger="click"
                @show="showPopover" @hide="hidePopover" :hide-after="0" :width="600" virtual-triggering>
                <n-tabs type="line" animated>
                    <n-tab-pane name="oasis" tab="画廊">
                        <div style="height: 360px;">
                            <n-infinite-scroll :distance="10">
                                <el-input v-model="SearchCover" style="width: 100%;margin-bottom: 1rem;"
                                    placeholder="筛选" />

                                <el-space direction="vertical" alignment="normal" style="margin-bottom: 1rem">
                                    <el-text size="small">渐变</el-text>
                                    <el-row :gutter="20">
                                        <el-col :span="6" v-for="(item, index) in 20" :key="index">
                                            <el-image style="width: 100%; height: 70px;"
                                                src="https://picserver.duoyu.link/picfile/image/202403/31-1711877892472.jpg"
                                                loading="lazy" fit="cover">
                                            </el-image>
                                        </el-col>
                                    </el-row>
                                </el-space>

                            </n-infinite-scroll>
                        </div>
                    </n-tab-pane>
                    <n-tab-pane name="the beatles" tab="上传">
                        上传
                    </n-tab-pane>
                    <n-tab-pane name="jay chou" tab="链接">
                        链接
                    </n-tab-pane>
                </n-tabs>
            </el-popover>
        </div> <!-- 封面 -->

        <div class="pagebox" :style="pageBoxStyle" style="max-width:920px;">
            <contentPageBox />
        </div> <!-- 页面 -->

        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item"
                    style="width: 26px;height: 26px; position: absolute;right: 14px;top: 0;bottom: 0;margin: auto;font-size: 28px;background-color: #f3f3f363;"
                    @click="toggleSidebarStatus">
                    <n-icon size="24" v-if="parentSidebarStatus">
                        <ChevronRight16Filled />
                    </n-icon>
                    <n-icon size="24" v-else>
                        <ChevronLeft16Filled />
                    </n-icon>
                </div>
            </template>
            <span v-if="parentSidebarStatus">收起侧边栏 Ctrl+\</span>
            <span v-else>展开侧边栏 Ctrl+\</span>
        </n-tooltip>
    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, inject } from 'vue';
import { ChevronLeft16Filled, ChevronRight16Filled, ImageGlobe24Regular } from '@vicons/fluent';
import contentPageBox from '@/views/note/index.vue';

let coverImage = ref('https://www.notion.so/images/page-cover/rijksmuseum_jansz_1649.jpg')

// 父组件的侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus');
const updateParentSidebarStatus = inject('updateParentSidebarStatus');

const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};

const contentBoxRef = ref(null); // 获取 contentBox 的引用
const pageBoxStyle = ref({ padding: '0 100px' }); // 默认的 padding

// 使用 ResizeObserver 实时监听 contentBox 的宽度变化
const updatePadding = () => {
    if (contentBoxRef.value && contentBoxRef.value.offsetWidth < 768) {
        pageBoxStyle.value = { padding: '0 1.5rem' };
    } else {
        pageBoxStyle.value = { padding: '0 100px' };
    }
};

onMounted(() => {
    // 初始化时检测一次
    updatePadding();

    // 创建 ResizeObserver 来监听 contentBox 宽度变化
    const resizeObserver = new ResizeObserver(() => {
        updatePadding(); // 每次宽度变化时更新 padding
    });

    // 观察 contentBox 元素
    if (contentBoxRef.value) {
        resizeObserver.observe(contentBoxRef.value);
    }

    // 在组件卸载时停止监听
    onBeforeUnmount(() => {
        if (contentBoxRef.value) {
            resizeObserver.unobserve(contentBoxRef.value);
        }
    });
});


// 搜索封面
let SearchCover = ref()

// 弹出框
const buttonCoverRef = ref()
const popoverCoverRef = ref()
const onClickOutside = () => {
    unref(popoverCoverRef).popoverCoverRef?.delayHide?.()
}

// 弹出框显示
const showPopover = () => {
    // 禁止页面滚动
    contentBoxRef.value.style.overflow = 'hidden';
}

// 弹出框隐藏
const hidePopover = () => {
    // 恢复页面滚动
    contentBoxRef.value.style.overflow = '';
}
</script>

<style scoped lang="scss">
.contentBox {
    width: 100%;
    height: 100%;
    overflow-y: auto;
}


// 滚动条样式
/* 高度和宽度分别对应横竖滚动条的尺寸 */
.contentBox::-webkit-scrollbar {
    width: 10px;
    height: 10px;
}

// 滚动条两端的按钮
.contentBox::-webkit-scrollbar-button {
    // display: block;
    background-size: 8px;
    background-repeat: no-repeat;
}

/* Up箭头按钮 */
.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement {
    height: 12px;
    width: 12px;
    background-position: center 4px;
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(211,209,203)'><polygon points='50,00 0,50 100,50'/></svg>");
}

.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement:hover,
.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement:active {
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(112, 112, 112)'><polygon points='50,00 0,50 100,50'/></svg>");
}

/* Down箭头按钮 */
.contentBox::-webkit-scrollbar-button:single-button:vertical:increment {
    height: 12px;
    width: 12px;
    background-position: center 4px;
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(211,209,203)'><polygon points='0,0 100,0 50,50'/></svg>");
}

.contentBox::-webkit-scrollbar-button:single-button:vertical:increment:hover,
.contentBox::-webkit-scrollbar-button:single-button:vertical:increment:active {
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(112, 112, 112)'><polygon points='0,0 100,0 50,50'/></svg>");
}

/* 滚动条里面的小方块 */
.contentBox::-webkit-scrollbar-thumb {
    background: #DCDCDC;
}

/* 滚动条里面的轨道 */
.contentBox::-webkit-scrollbar-track {
    // background-color: #F7F7F5;
}


.cover {
    width: 100%;
    background-color: #fff;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    position: relative;

    .SelectCover {
        display: none;
        position: absolute;
        top: 1rem;
        right: 3rem;
    }

    &:hover .SelectCover {
        display: block;
    }
}

.pagebox {
    margin: 0 auto;
    padding: 0 100px;
    box-sizing: border-box;
}
</style>
