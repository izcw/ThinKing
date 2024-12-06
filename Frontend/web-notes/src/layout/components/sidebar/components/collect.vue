<template>
    <div class="collect GMargin">
        <n-grid cols="3 200:4 300:5 400:6 500:7 600:8" :y-gap="8" style="justify-items: center;">
            <n-grid-item style="width: 100%;">
                <el-tooltip :hide-after="0" content="主页" placement="top" effect="light">
                    <router-link to="/space">
                        <div class="Tools-item item official">
                            <n-icon size="20">
                                <Home48Regular />
                            </n-icon>
                        </div>
                    </router-link>
                </el-tooltip>
            </n-grid-item>
            <n-grid-item style="width: 100%;" @click="dialogTableVisible = true">
                <el-tooltip :hide-after="0" content="搜索" placement="top" effect="light">
                    <div class="Tools-item item official">
                        <n-icon size="20">
                            <Search28Filled />
                        </n-icon>
                    </div>
                </el-tooltip>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <el-tooltip :hide-after="0" content="双击'锁屏'" placement="top" effect="light">
                    <div class="Tools-item item official" @dblclick="LockScreen">
                        <n-icon size="20">
                            <LockClosed32Regular />
                        </n-icon>
                    </div>
                </el-tooltip>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <el-tooltip :hide-after="0" content="全屏" placement="top" effect="light">
                    <div class="Tools-item item official" @click="toggleFullScreen">
                        <n-icon size="20">
                            <FullScreenMaximize16Filled />
                        </n-icon>
                    </div>
                </el-tooltip>
            </n-grid-item>


            <n-grid-item style="width: 100%;" v-for="(item, index) in data" :key="item.id">
                <el-tooltip :hide-after="0" placement="top" effect="light">
                    <template #content><el-text truncated style="max-width: 150px;">收藏页：{{ item.title
                            }}</el-text></template>
                    <router-link :to="item.link">
                        <div class="Tools-item item">
                            <n-icon size="20">
                                <component :is="item.icon" />
                            </n-icon>
                            <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                                <Star />
                            </n-icon>
                        </div>
                    </router-link>
                </el-tooltip>
            </n-grid-item>
        </n-grid>

        <el-dialog v-model="dialogTableVisible" width="800" :show-close="false">
            <template #header>
                <el-input v-model="input" style="width: 100%;padding: 1rem;box-sizing: border-box;"
                    placeholder="全局搜索，请输入..." />
                <div style="padding:1rem;box-sizing: border-box;">
                    <searchItemBox />
                </div>
            </template>
        </el-dialog><!-- 搜索对话框 -->
    </div>
</template>
<script setup>
import { ref, markRaw } from 'vue';
import searchItemBox from '@/components/searchItem.vue';
import { Home48Regular, Search28Filled, FullScreenMaximize16Filled, LockClosed32Regular } from '@vicons/fluent'
import { BellRegular, Star, Lock } from '@vicons/fa'
import screenfull from "screenfull";

import { useRouter } from 'vue-router';
const router = useRouter();

let dialogTableVisible = ref(false) // 搜索对话框

// 使用 markRaw 来标记组件
const StarIcon = markRaw(Star);

let data = ref([
    {
        title: 'link1',
        id: 4,
        link: '/space/345rsdsdfg345rsdsdfg345rsdsdfg345rsdsdfg345rsdsdfg345rsdsdfg',
        icon: Star
    },
    {
        title: 'link2',
        id: 5,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: 'link3',
        id: 6,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: '你好Hello!!. ',
        id: 7,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: '探索java世界的奥秘',
        id: 8,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: 'link6',
        id: 9,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: 'link5',
        id: 8,
        link: '/space/345rsdsdfg',
        icon: Star
    }, {
        title: 'link6',
        id: 9,
        link: '/space/345rsdsdfg',
        icon: Star
    }
])

let searchFor = () => {
    console.log("搜索");

}

// 锁屏
let LockScreen = () => {
    router.push({ name: 'lock' })
}


// 全屏
let toggleFullScreen = () => {
    if (screenfull.isEnabled) {
        screenfull.toggle();
    }
}
</script>
<style scoped lang='scss'>
.collect {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 30px;
}

.item {
    position: relative;
    width: calc(100% - 10px);
    height: 40px;
    // background-color: #f0f0f0;
    background-color: rgba(255, 255, 255, 80%);
    box-shadow: 0 0 5px #eee;
    margin: 0 auto;

    img {
        width: 15px;
        height: 15px;
    }

    i {
        color: #999;
    }
}

// .item.official {
//     background-color: #eeeeee;
// }

.item:hover,
.item:active {
    background-color: rgba(255, 255, 255, 100%);
}
</style>
