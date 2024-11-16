<template>
    <div class="collect GMargin">
        <n-grid cols="3 300:4 400:5 500:6 600:7" :y-gap="8" style="justify-items: center;">
            <n-grid-item style="width: 100%;">
                <router-link to="/space1">
                    <div class="Tools-item item">
                        <n-icon size="20">
                            <Home48Regular />
                        </n-icon>
                    </div>
                </router-link>
            </n-grid-item>
            <n-grid-item style="width: 100%;" @click="dialogTableVisible = true">
                <div class="Tools-item item">
                    <n-icon size="20">
                        <Search28Filled />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <n-icon size="20">
                        <Lock />
                    </n-icon>
                </div>
            </n-grid-item>

            <n-grid-item style="width: 100%;" v-for="(item, index) in data" :key="item.id">
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
            </n-grid-item>
        </n-grid>
        <el-dialog v-model="dialogTableVisible" width="800"  :show-close="false">
            <template #header>
                <el-input v-model="input"  style="width: 100%" placeholder="请搜索..." />
            </template>
        </el-dialog>

    </div>
</template>
<script setup>
import { Home48Regular, Search28Filled } from '@vicons/fluent'
import { BellRegular, Star ,Lock} from '@vicons/fa'
import { ref } from 'vue';

let dialogTableVisible = ref(false)

let data = ref([
    {
        name: 'link1',
        id: 4,
        link: '/space1/345rsdsdfg',
        icon: Star
    },
    {
        name: 'link2',
        id: 5,
        link: '/space1/345rsdsdfg',
        icon: Star
    }, {
        name: 'link3',
        id: 6,
        link: '/space1/345rsdsdfg',
        icon: Star
    }, {
        name: 'link4',
        id: 7,
        link: '/space1/345rsdsdfg',
        icon: Star
    }, {
        name: 'link5',
        id: 8,
        link: '/space1/345rsdsdfg',
        icon: Star
    }, {
        name: 'link6',
        id: 9,
        link: '/space1/345rsdsdfg',
        icon: Star
    }
])

let searchFor = () => {
    console.log("搜索");

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
    background-color: #EFEFED;
    margin: 0 auto;

    img {
        width: 15px;
        height: 15px;
    }
}

.item:hover,
.item:active {
    background-color: #E9E9E9;
}
</style>
