<template>
    <div class="searchItem text-select">
        <p v-if="filteredPages"><el-text class="mx-1" type="primary">搜索结果（{{ filteredPages.length }}条）：</el-text></p>
        <img class="logo" v-else="filteredPages" src="@/assets/images/logo-grey.png" alt="">
        <div class="content">
            <div class="item" v-for="item in filteredPages" :key="item.id" @click="openPage(item.pageId)">
                <div class="time">{{ timeAgo(item.updateTime) }}</div>
                <div>
                    <div class="title">
                        <span class="icon" v-if="item.icon">{{ item.icon }}</span>
                        <n-icon class="icon" size="16" v-else>
                            <FileTextOutlined />
                        </n-icon>
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
import { ref, defineProps, computed, onMounted } from 'vue'
import { timeAgo } from '@/utils/timeAgo'
import { FileTextOutlined } from '@vicons/antd'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore();
import { useRouter } from 'vue-router'
const router = useRouter()

let openPage = (val) => {
    router.push('/space/' + store.routerParamsId.spaceId + '/' + val)
}


// 定义接收搜索的值 props
const props = defineProps({
    search: {
        type: String,
        required: true
    }
});


// 计算属性，基于 search 值和 spacePageData 进行过滤
const filteredPages = computed(() => {
    if (props.search && store.spacePageData) {
        const searchTerm = props.search.toLowerCase();
        return store.spacePageData.filter(page => page.title.toLowerCase().includes(searchTerm));
    }
});

// onMounted(() => {
//     props.search = ''
// })
</script>
<style scoped lang='scss'>
.searchItem {
    width: 100%;
    min-height: 450px;
    max-height: 400px;
    margin: 1rem 0 2rem 0;
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
        // opacity: 0.1;
        // filter: grayscale(100%);
    }

    .content {

        .item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #f2f2f2;
            padding: 10px 0;
            margin: 10px 0;
            box-sizing: border-box;
            margin-bottom: 4px;
            cursor: pointer;
            transition: all 0.3s ease;

            .title {
                font-size: 18px;
                font-weight: bold;
                // padding-bottom: 6px;
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
            background-color: #f7f7f7;
        }

        .item:hover,
        .item:active {
            padding-left: 10px;
        }
    }
}
</style>
