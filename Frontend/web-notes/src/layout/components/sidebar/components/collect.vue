<template>
    <div class="collect GMargin">
        <n-grid cols="3 300:4 400:5 500:6 600:7" :y-gap="8" style="justify-items: center;">
                <n-grid-item style="width: 100%;" v-for="(item,index) in data" :key="item.id" >
                    <div class="Tools-item item">
                        <n-icon size="20">
                            <component :is="item.icon" />
                        </n-icon>
                        <n-icon size="10" color="#F6C050cc" v-if="index >= 3" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                    </div>
                </n-grid-item>
        </n-grid>
    </div>
</template>
<script setup>
import { Home48Regular, Search28Filled } from '@vicons/fluent'
import { BellRegular, Star } from '@vicons/fa'
import { ref } from 'vue';

let data = ref([
    {
        name: '主页',
        id: 1,
        icon: Home48Regular
    },
    {
        name: '搜索',
        id: 2,
        icon: Search28Filled
    },
    {
        name: '消息',
        id: 3,
        icon: BellRegular
    },
    {
        name: 'link1',
        id: 4,
        icon: Star
    },
    {
        name: 'link2',
        id: 5,
        icon: Star
    }, {
        name: 'link3',
        id: 6,
        icon: Star
    }, {
        name: 'link4',
        id: 7,
        icon: Star
    }, {
        name: 'link5',
        id: 8,
        icon: Star
    }, {
        name: 'link6',
        id: 9,
        icon: Star
    }
])
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
    background-color: #EBEBEB;
}
</style>
