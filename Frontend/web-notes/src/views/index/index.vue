<template>
    <div class="blankPage">
        <CollapseMenuBox />
        <div class="container">
            <div class="title text-select">
                <h1>晚上好呀，{{ store.userInfoData.nickname }}</h1>
            </div>
            <el-row :gutter="30">
                <el-col :xs="24" :sm="24" :md="24" :lg="14" :xl="16">
                    <el-row :gutter="30">
                        <el-col :span="24">
                            <el-input v-model="search" size="large" style="width:320px;" placeholder="全局搜索，请输入..."
                                clearable />
                        </el-col>
                        <el-col :span="24">
                            <searchItemBox :search="search" />
                        </el-col>
                        <el-col :span="24">
                            <recommendBox />
                        </el-col>
                        <!-- <el-col :span="24">
                            <contributeBox />
                        </el-col> -->
                    </el-row>
                </el-col>
                <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="8">
                    <!-- <calendarBox /> -->
                    <RecentlyEditedBox />
                    <RelationshipDiagramBox />
                </el-col>
            </el-row>
        </div>
    </div>
</template>
<script setup>
import { ref, onBeforeUnmount } from 'vue'
import RecentlyEditedBox from './components/RecentlyEdited.vue';
import calendarBox from './components/calendar.vue';
import RelationshipDiagramBox from './components/RelationshipDiagram.vue';
import contributeBox from './components/contribute.vue';
import recommendBox from './components/recommend.vue';
import searchItemBox from '@/components/searchItem.vue';
import CollapseMenuBox from '@/components/CollapseMenu.vue';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

let search = ref();
</script>
<style scoped lang='scss'>
.title {
    width: 100%;
    text-align: center;
    padding: 3rem 0 5rem 0;
    box-sizing: border-box;

    h1 {
        font-size: 28px;
    }
}

.container {
    // width: 1200px;
    padding: 0 80px;
    box-sizing: border-box;
    height: 100%;
    margin: 0 auto;
}
</style>
