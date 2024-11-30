<template>
    <div class="recommend text-select" v-if="!data.length == 0">
        <p><el-text class="mx-1" type="primary">收藏</el-text></p>
        <div class="content">
            <div class="item" v-for="item in data" :key="item.id" :class="{ 'bgNot': item.cover == null }"
                :style="{ 'background-image': 'URL(' + item.cover + ')' }">
                <p class="time">{{ timeAgo(item.time) }}</p>
                <p class="title"><el-text truncated>{{ item.title }}</el-text></p>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import { timeAgo } from '@/utils/timeAgo'

let data = ref([
    {
        id: "1",
        title: "莎士比亚笔下的爱情观",
        time: "2024/10/06",
        cover: "/src/assets/images/cover/recommend-item1.png"
    },
    {
        id: "1",
        title: "开始弄人",
        time: "2024/9/06",
        cover: "/src/assets/images/cover/recommend-item2.jpg"
    },
    {
        id: "1",
        title: "半生荒唐 只因有你",
        time: "2023/4/19",
        cover: null
    },
    {
        id: "1",
        title: "人士需要浮士德精神",
        time: "2023/4/19",
        cover: "/src/assets/images/cover/recommend-item3.jpg"
    }
])
</script>
<style scoped lang='scss'>
.recommend {
    width: 100%;
    min-height: 300px;

    .content {

        .item {
            margin: 1rem 0;
            width: 100%;
            height: 220px;
            // background-image: url("@/assets/images/logo.png");
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;

            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 2rem;
            box-sizing: border-box;
            // transition: all 0.3s ease;
            cursor: pointer;


            .time {
                font-size: 14px;
                color: #fff;
            }

            .title span {
                padding: 1rem 0;
                font-size: 26px;
                color: #fff;
            }
        }

        .item:hover,
        .item:active {
            animation: amplify 0.3s forwards;
        }

        @keyframes amplify {
            0% {
                background-size: 100%;
            }

            100% {
                background-size: 110%;
            }
        }

        .bgNot {
            padding: 0;

            .time {
                color: #666;
            }

            .title span {
                color: #000;
            }
        }
    }
}
</style>
