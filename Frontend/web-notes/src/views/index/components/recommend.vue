<template>
    <div class="recommend text-select" v-if="!store.filterCollect.length == 0">
        <p><el-text class="mx-1" type="primary">收藏</el-text></p>
        <div class="content">
            <div class="item" v-for="item in store.filterCollect" :key="item.pageId"
                :class="{ 'bgNot': item.cover == null }"
                :style="{ 'background-image': 'URL(' + FILE_PATH_API_URL + item.cover + ')' }"
                @click="openPage(item.pageId)">
                <div class="info">
                    <p class="time">{{ timeAgo(item.updateTime) }}</p>
                    <p class="title"><el-text truncated>{{ item.title }}</el-text></p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import { timeAgo } from '@/utils/timeAgo'
import { FILE_PATH_API_URL } from "@/config/setting"
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
import { useRouter } from 'vue-router'
const router = useRouter()

let openPage = (val) => {
    router.push('/space/' + store.routerParamsId.spaceId + '/' + val)
}

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
            position: relative;



            display: flex;
            flex-direction: column;
            justify-content: center;
            box-sizing: border-box;
            // transition: all 0.3s ease;
            cursor: pointer;

            .info {
                position: absolute;
                width: 100%;
                height: 100%;
                z-index: 2;
                padding: 0 2rem;
                display: flex;
                flex-direction: column;
                justify-content: center;


                .time {
                    font-size: 14px;
                    color: #333;
                    // mix-blend-mode: difference;
                    // text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
                }

                .title span {
                    padding: 1rem 0;
                    width: calc(100% - 3rem);
                    box-sizing: border-box;
                    font-size: 26px;
                    color: #333;
                    font-weight: bold;
                    // mix-blend-mode: difference;
                    // text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
                }
            }


        }

        .item::after {
            display: block;
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.3);
            z-index: 1;
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
