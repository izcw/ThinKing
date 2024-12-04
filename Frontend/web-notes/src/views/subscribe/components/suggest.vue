<template>
    <div class="current">
        <p>当前方案</p>
        <p><span class="my">个人免费版</span><span class="recommend">升级个人Plus版，支持至多5个空间</span></p>
    </div>
    <el-row :gutter="20" class="scheme">
        <el-col :sm="24" :md="8" v-for="item in data" :key="item.id">
            <div class="item">
                <div class="title">{{ item.title }}<span class="hot" v-if="item.hot">热门方案</span></div>
                <p class="describe"><el-text line-clamp="2" size="small">
                        {{ item.describe }}
                    </el-text></p>
                <div class="price">
                    <p>折扣价：<span class="Current">￥{{ item.priceCurrent }}</span><span>&nbsp;/&nbsp;月</span></p>
                    <p>原&emsp;价：<del>￥{{ item.price }}<span>&nbsp;/&nbsp;月</span></del></p>
                </div>
                <el-button type="primary">升级</el-button>
            </div>
        </el-col>
    </el-row>
</template>
<script setup>
import { ref } from 'vue'
let data = ref([
    {
        id: 1,
        title: "个人Plus版",
        describe: "升级个人Plus版，支持至多5个空间升级个人Plus版，支持至多5个空间升级个人Plus版，支持至多5个空间升级个人Plus版，支持至多5个空间升级个人Plus版，支持至多5个空间",
        hot: true,
        price: "12",
        priceCurrent: "6"
    },
    {
        id: 2,
        title: "团队版",
        describe: "包括团队版所有权益",
        hot: false,
        price: "24",
        priceCurrent: "12"
    },
    {
        id: 3,
        title: "企业版",
        describe: "最多255位访客",
        hot: false,
        price: "48",
        priceCurrent: "24"
    }
])
</script>
<style scoped lang='scss'>
.current {
    font-size: 14px;
    color: #666;

    .my {
        font-size: 16px;
        color: #333;
        font-weight: bold;
        margin-right: 1rem;
    }

    .recommend {}
}

// 方案
.scheme {
    // display: flex;
    margin: 3rem 0;

    .item {
        min-height: 270px;
        max-height: 270px;
        padding: 1rem;
        box-sizing: border-box;
        border: 1px solid #eee;
        margin-bottom: 1rem;

        .title {
            display: flex;
            align-items: flex-start;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 1rem;

            .hot {
                font-size: 12px;
                color: #ED6C7B;
                padding: 4px;
                border-radius: 2px;
                margin-left: 6px;
                background-color: #ffeaea;
            }
        }

        .describe {
            font-size: 14px;
            height: 40px;
            color: #666;
        }

        .price {
            margin: 1rem 0;

            p {
                font-size: 14px;
                color: #999;
            }

            .Current {
                font-weight: bold;
                font-size: 30px;
                color: #0355E3;
            }
        }
    }
}
</style>
