<template>
    <div class="RecentlyEdited card text-select">
        <p><el-text class="mx-1" type="primary">最近编辑</el-text></p>
        <div class="time-base-mark"></div>
        <div class="content">
            <div class="item" v-for="item in recentPages" :key="item.id" @click="openPage(item.pageId)">
                <div class="time">{{ timeAgo(item.updateTime) }}</div>
                <div class="recentPage">
                    <div class="title">{{ item.title }}</div>
                    <p>
                        <el-text line-clamp="4" v-if="isContentEmpty(item.content)">
                            <span v-if="item.content?.content[0].content">
                                {{ item.content?.content[0]?.content[0]?.text }}
                            </span>
                        </el-text>
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref, computed } from 'vue'
import { timeAgo } from '@/utils/timeAgo'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore();
import { useRouter } from 'vue-router'
const router = useRouter()
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()


// 计算属性：按 updateTime 排序并取出最近的 4 条数据
const recentPages = computed(() => {
    if (store.spacePageData) {
        return store.spacePageData
            .sort((a, b) => new Date(b.updateTime) - new Date(a.updateTime))  // 按照 updateTime 降序排序
            .slice(0, 4);  // 取出前 4 条
    }
});

let openPage = (val) => {
    router.push('/space/' + store.routerParamsId.spaceId + '/' + val)
}


// 检测数据是否为空
const isContentEmpty = (val) => {
    if (val && val.content && val.content.content) {
        if (val.content.content.length <= 1) {
            return val.content.content[0].content === undefined
        }
        return false;
    }
    return true; // 如果 parsedContent 不存在或内容为空数组，也视为“空”
}
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

                width: 100%;
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
