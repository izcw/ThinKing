<template>
    <div class="blankPage">
        <div class="container">
            <div class="banner">

            </div>
            <h1>加入或续费 NexNote会员</h1>
            <div class="current">
                <p>当前方案</p>
                <p><span class="my">个人免费板</span><span class="recommend">升级个人Plus版，支持至多5个空间</span></p>
            </div>
            <el-row :gutter="20" class="scheme">
                <el-col :span="8" v-for="item in data" :key="item.id">
                    <div class="item">
                        <div class="title">{{ item.title }}<span class="hot" v-if="item.hot">热门方案</span></div>
                        <p class="describe">{{ item.describe }}</p>
                        <div class="price">
                            <p>折扣价：<span class="Current">￥{{ item.priceCurrent }}</span><span>&nbsp;/&nbsp;月</span></p>
                            <p>原&emsp;价：<del>￥{{ item.price }}<span>&nbsp;/&nbsp;月</span></del></p>
                        </div>
                        <el-button type="primary">升级</el-button>
                    </div>
                </el-col>
            </el-row>
            <div>
                <el-table :data="tableData" style="width: 100%">
                    <el-table-column prop="describe" label="范围对比" />
                    <el-table-column prop="person" label="个人Plus版" width="180">
                        <template #default="scope">
                            <div v-if="typeof scope.row.person === 'boolean'">
                                <el-text v-if="scope.row.person" type="primary">√</el-text>
                                <el-text v-else type="info">×</el-text>
                            </div>
                            <div v-else>
                                {{ scope.row.person }}
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="team" label="团队版" width="180">
                        <template #default="scope">
                            <div v-if="typeof scope.row.team === 'boolean'">
                                <el-text v-if="scope.row.team" type="primary">√</el-text>
                                <el-text v-else type="info">×</el-text>
                            </div>
                            <div v-else>
                                {{ scope.row.team }}
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="enterprise" label="企业版" width="180">
                        <template #default="scope">
                            <div v-if="typeof scope.row.enterprise === 'boolean'">
                                <el-text v-if="scope.row.enterprise" type="primary">√</el-text>
                                <el-text v-else type="info">×</el-text>
                            </div>
                            <div v-else>
                                {{ scope.row.enterprise }}
                            </div>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
        </div>
    </div>

</template>
<script setup>
import { ref } from 'vue';

let data = ref([
    {
        id: 1,
        title: "个人Plus版",
        describe: "升级个人Plus版，支持至多5个空间",
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


let tableData = ref([
    {
        describe: "页面和区块",
        person: false,
        team: false,
        enterprise: true
    },
    {
        describe: "空间",
        person: 2,
        team: 5,
        enterprise: 10
    },
    {
        describe: "文件上传",
        person: "最多5M/个",
        team: "最多20M/个",
        enterprise: "无限"
    },
    {
        describe: "存储空间",
        person: "1G",
        team: "10G",
        enterprise: "100G"
    },
    {
        describe: "页面历史记录",
        person: "7天",
        team: "30天",
        enterprise: "1年"
    },
    {
        describe: "回收站",
        person: "7天",
        team: "30天",
        enterprise: "1年"
    }
])
</script>
<style scoped lang='scss'>
.container {
    width: 1200px;
    height: 100%;
    margin: 0 auto;

    .banner {
        width: 100%;
        height: 350px;
        background-image: url("/src/assets/images/subscribe-banner.png");
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-bottom: 60px;
        border-radius: 10px;
    }

    h1 {
        font-size: 28px;
        color: #0355E3;
        border-bottom: 1px solid #eee;
        margin-bottom: 1rem;
        padding-bottom: 1rem;
    }

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
            padding: 1rem;
            box-sizing: border-box;
            min-width: 300px;
            border: 1px solid #eee;

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
}

</style>
