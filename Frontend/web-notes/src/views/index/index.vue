<template>
    <div class="blankPage">
        <div class="title text-select">
            <h1>晚上好呀，Yoko</h1>
        </div>
        <div class="container">
            <el-row :gutter="30">
                <el-col :span="15">
                    <el-row :gutter="30">
                        <el-col :span="24">
                            <el-input v-model="input" size="large" style="width:350px;" placeholder="搜索笔记" clearable />
                        </el-col>
                        <el-col :span="24">
                            <contributeBox />
                        </el-col>
                        <el-col :span="24">
                            <searchItemBox />
                        </el-col>
                        <el-col :span="24">
                            <recommendBox />
                        </el-col>
                    </el-row>
                </el-col>
                <el-col :span="9">
                    <!-- <calendarBox /> -->
                    <RecentlyEditedBox />
                    <RelationshipDiagramBox />
                </el-col>
            </el-row>
        </div>
    </div>
</template>
<script setup>
import RecentlyEditedBox from './components/RecentlyEdited.vue';
import calendarBox from './components/calendar.vue';
import RelationshipDiagramBox from './components/RelationshipDiagram.vue';
import contributeBox from './components/contribute.vue';
import recommendBox from './components/recommend.vue';
import searchItemBox from './components/searchItem.vue';
</script>
<style scoped lang='scss'>
.title {
    width: 100%;
    text-align: center;
    padding: 3rem 0 5rem 0;

    h1 {
        font-size: 28px;
    }
}

.container {
    width: 1200px;
    height: 100%;
    margin: 0 auto;

}
</style>
