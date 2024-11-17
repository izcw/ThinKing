<template>
    <div class="searchItem text-select">
        <p v-if="data.length > 0"><el-text class="mx-1" type="primary">搜索结果：</el-text></p>
        <img class="logo" v-if="data.length == 0" src="@/assets/images/logo.png" alt="">
        <div class="content">
            <div class="item" v-for="item in data" :key="item.id">
                <div class="time">{{ timeAgo(item.time) }}</div>
                <div>
                    <div class="title">
                        {{ item.title }}
                    </div>
                    <p class="article">
                        {{ item.article }}
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue'
import { timeAgo } from '@/utils/timeAgo'

let data = ref([
    // {
    //     id:"1",
    //     title: "基于Spring Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现",
    //     time: "2024/11/17",
    //     article: "u受到广泛的官方原版就辜负的官方发的花骨朵人员的发个v的反恐顾问u发的感慨道的飞机工业 发达结果的独具一格东方精工女方风格结合地方v"
    // },
    // {
    //     id:"2",
    //     title: "English",
    //     time: "2024/11/17 13:07:03",
    //     article: "符号恐惧感发动机空格"
    // },
    // {
    //     id:"1",
    //     title: "基于Spring Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现",
    //     time: "2024/11/17",
    //     article: "u受到广泛的官方原版就辜负的官方发的花骨朵人员的发个v的反恐顾问u发的感慨道的飞机工业 发达结果的独具一格东方精工女方风格结合地方v"
    // },
    // {
    //     id:"2",
    //     title: "English",
    //     time: "2024/11/17 13:07:03",
    //     article: "符号恐惧感发动机空格"
    // },
    // {
    //     id:"1",
    //     title: "基于Spring Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现",
    //     time: "2024/11/17",
    //     article: "u受到广泛的官方原版就辜负的官方发的花骨朵人员的发个v的反恐顾问u发的感慨道的飞机工业 发达结果的独具一格东方精工女方风格结合地方v"
    // },
    // {
    //     id:"2",
    //     title: "English",
    //     time: "2024/11/17 13:07:03",
    //     article: "符号恐惧感发动机空格"
    // },
    // {
    //     id:"1",
    //     title: "基于Spring Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现Boot开发的在线笔记软件设计与实现",
    //     time: "2024/11/17",
    //     article: "u受到广泛的官方原版就辜负的官方发的花骨朵人员的发个v的反恐顾问u发的感慨道的飞机工业 发达结果的独具一格东方精工女方风格结合地方v"
    // },
    // {
    //     id:"2",
    //     title: "English",
    //     time: "2024/11/17 13:07:03",
    //     article: "符号恐惧感发动机空格"
    // }
])
</script>
<style scoped lang='scss'>
.searchItem {
    width: 100%;
    min-height: 450px;
    max-height: 400px;
    margin:1rem 0 2rem 0;
    position: relative;
    overflow-y: auto;

    .logo {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        margin: auto;
        width: 100px;
        height: 100px;
        opacity: 0.1;
        filter: grayscale(100%);
    }

    .content {

        .item {
            display: flex;
            border-bottom: 1px solid #f2f2f2;
            padding: 10px 0;
            box-sizing: border-box;
            margin-bottom: 4px;
            cursor: pointer;
            transition: all 0.3s ease;

            .title {
                font-size: 18px;
                font-weight: bold;
                padding-bottom: 6px;
                display: -webkit-box;
                overflow: hidden;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 1;
            }

            .article {
                font-size: 12px;
                display: -webkit-box;
                overflow: hidden;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 2;
            }

            .time {
                width: 52px;
                min-width: 52px;
                color: #999;
                font-size: 12px;
                margin-right: 10px;
            }
        }

        .item:hover,
        .item:active {
            padding-left: 10px;
        }
    }
}
</style>
