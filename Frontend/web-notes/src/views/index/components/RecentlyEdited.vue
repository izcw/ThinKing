<template>
    <div class="RecentlyEdited card text-select">
        <p><el-text class="mx-1" type="primary">最近编辑</el-text></p>
        <div class="time-base-mark"></div>
        <div class="content">
            <div class="item" v-for="item in data" :key="item.id">
                <div class="time">{{ timeAgo(item.time) }}</div>
                <div class="recentPage">
                    <div class="title">{{ item.title }}</div>
                    <p>
                        <el-text line-clamp="4">
                            {{ item.article }}
                        </el-text>
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
    {
        id: "1",
        title: "探索Java世界的奥秘",
        time: "2024/11/28 13:07:03",
        article: "本文将深入探讨Java编程语言的核心概念，包括面向对象编程、异常处理和多线程编程，以及它们如何帮助开发者构建高效、可扩展的应用程序。"
    },
    {
        id: "2",
        title: "文字的力量：文学的启示",
        time: "2024/11/17 9:07:03",
        article: "文学作品如何影响我们的情感和思想，分析经典文学作品中的主题和象征，以及它们在现代社会中的相关性和启示。文学作品如何影响我们的情感和思想，分析经典文学作品中的主题和象征，以及它们在现代社会中的相关性和启示。"
    },
    {
        id: "2",
        title: "日常生活的哲学思考",
        time: "2024/11/13 13:07:03",
        article: "日常活动找到快乐和满足感，以及如何将哲学应用于个人成长和自我提升。"
    },
    {
        id: "2",
        title: "计算机毕设：从构思到实现",
        time: "2023/1/11 9:07:03",
        article: "如何规划和实施一个计算机科学毕业设计项目，从选题、研究、设计到最终的实现和答辩，提供实用的建议和技巧。"
    }
])
</script>
<style scoped lang='scss'>
.RecentlyEdited {
    width: 100%;
    height: 500px;
    padding-right: 0;
    overflow: hidden;
    position: relative;


    .content {
        position: absolute;
        left: 0;
        bottom: -30px;
        width: 100%;

        .item {
            padding-left: 1rem;
            box-sizing: border-box;
            height: 110px;
            position: relative;
            cursor: pointer;

            .recentPage {
                position: absolute;
                bottom: -10px;
                right: -10px;

                max-width: 280px;
                margin-left: 120px;
                height: calc(100% + 30px);
                background-color: #fff;
                border: 1px solid #e3e2e4;
                border-radius: 8px 8px 0 0;
                box-shadow: 0 1px 6px #0000000d;
                padding: 1rem 1.5rem;
                box-sizing: border-box;

                p span {
                    font-size: 12px;
                    line-height: 20px;
                }

                .title {
                    font-size: 18px;
                    font-weight: bold;
                    padding-bottom: 6px;
                    display: -webkit-box;
                    overflow: hidden;
                    -webkit-box-orient: vertical;
                    -webkit-line-clamp: 1;
                }
            }


            .time {
                position: relative;
                padding-left: 16px;
                transition: all 0.2s ease;
                color: #999;
                font-size: 12px;
                z-index: 20;
                transform: scale(0.9);
            }

            .time::after {
                position: absolute;
                left: -20px;
                top: 10px;
                display: block;
                content: "";
                width: 30px;
                height: 1px;
                background-color: #BEC2CA;
            }



        }

        .item:hover .recentPage,
        .item:active .recentPage {
            animation: smooth 0.3s forwards;
        }

        .item:hover .time,
        .item:active .time {
            font-size: 14px;
        }

        @keyframes smooth {
            from {
                bottom: -10px;
                right: -10px;
            }

            to {
                bottom: 0;
                right: 0;
            }
        }
    }


    .time-base-mark {
        width: 16px;
        height: calc(100% - 30px);
        background-size: 16px 10px;
        background-image: linear-gradient(rgba(0, 0, 0, .1) 1px, transparent 0);
        position: absolute;
        bottom: 2px;
        left: 20px;
        -webkit-mask-image: linear-gradient(180deg, transparent, #000 14%, #000);
        pointer-events: none;
    }
}
</style>
