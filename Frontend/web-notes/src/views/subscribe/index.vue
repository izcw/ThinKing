<template>
    <div class="blankPage">
        <CollapseMenuBox />
        <div class="container">
            <div class="banner">
                <h1>加入ThinKing会员</h1>
            </div>
            <MySubscribeInfoBox />
            <suggestBox />
            <!-- <div>
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
</div> -->
        </div>
    </div>

</template>
<script setup>
import { ref } from 'vue';
import CollapseMenuBox from '@/components/CollapseMenu.vue';
import suggestBox from '@/views/subscribe/components/suggest.vue';
import MySubscribeInfoBox from '@/views/subscribe/components/MySubscribeInfo.vue';

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
    padding: 0 150px;
    box-sizing: border-box;
    height: 100%;
    margin: 0 auto;


    .banner {
        width: 100%;
        height: 300px;
        background-image: url("/src/assets/images/subscribe-banner.png");
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-bottom: 60px;
        border-radius: 10px;
        box-shadow: 0 0 5px #eee;
        padding: 1rem;
        box-sizing: border-box;

        display: flex;
        align-items: center;

        h1 {
            font-size: 34px;
            color: #0355E3;
            // border-bottom: 1px solid #eee;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
        }
    }



}
</style>
