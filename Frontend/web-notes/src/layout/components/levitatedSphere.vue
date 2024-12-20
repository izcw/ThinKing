<!--
* @FileDescription: 悬浮球
-->
<template>
    <!-- <n-tooltip trigger="hover" placement="right">
        <template #trigger>
            <n-float-button @click="scrollIntoViewUp" style="position:absolute;bottom:2.5rem ;right:2.5rem ;">
                <n-icon>
                    <ArrowCircleUp16Filled />
                </n-icon>
            </n-float-button>
        </template>
        回到顶部
    </n-tooltip> -->
    <n-flex>
        <n-tooltip trigger="hover" placement="right">
            <template #trigger>
                <n-float-button class="levitatedSphere" position="absolute" bottom="2.5rem" right="2.5rem"
                    menu-trigger="hover">
                    <n-icon>
                        <Crow />
                    </n-icon>
                    <template #menu>
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square"  @click="requestFullScreen">
                                    <n-icon>
                                        <FullScreenMaximize16Filled />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            全屏预览
                        </n-tooltip>
                        <!-- <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square" @click="openAiTool">
                                    <n-icon>
                                        <Connectdevelop />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            AI
                        </n-tooltip>
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <router-link to="/template">
                                    <n-float-button shape="square">
                                        <n-icon>
                                            <Diamond16Regular />
                                        </n-icon>
                                    </n-float-button>
                                </router-link>
                            </template>
                            模板
                        </n-tooltip> -->
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square" @click="scrollIntoViewUp">
                                    <n-icon>
                                        <ArrowCircleUp16Filled />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            回到顶部
                        </n-tooltip>
                    </template>
                </n-float-button>
            </template>
            回到顶部、全屏预览等
        </n-tooltip>
    </n-flex>
</template>

<script setup>
import { ref, defineEmits, watch, defineProps, inject } from 'vue'
import { Crow, Connectdevelop, Magic } from '@vicons/fa'
import { ArrowCircleUp16Filled, Diamond16Regular,FullScreenMaximize16Filled } from '@vicons/fluent'

import { useSettingStore } from '@/stores/setting'
const store = useSettingStore()

// 回到顶部的函数
const scrollIntoViewUp = () => {
    let element = document.getElementById('BackTop')
    element.scrollIntoView({
        behavior: "smooth",
        inline: "nearest"
    });
};

// 切换到ai标签页
const openAiTool = () => {
    store.TabsStatus = 'tabP2';
    store.switchTabsStatus = !store.switchTabsStatus
};


// 点击全屏预览
const emit = defineEmits(['requestFullScreen']);
function requestFullScreen() {
  emit('requestFullScreen')
}

</script>

<style scoped lang='scss'></style>