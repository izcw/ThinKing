<template>
    <div v-if="loading" v-loading="loading" style="width: 100%;height: 100%;">

    </div>
    <div v-else class="MainContent">
        <div class="PageHeader">
            <PageHeaderBox />
        </div><!-- 页头 -->
        <div class="mainbox">
            <PanelSplitBox :defaultSize="300" :minPanelSize="250" :maxPanelSize="800" contentPanel="right"
                :defaultSwitch="true">
                <template v-slot:1>
                    <div class="sidebar">
                        <ToolSidebarBox />
                    </div>
                </template>
                <template v-slot:2>
                    <main class="content">
                        <ContentBox />
                        <levitatedSphereBox />
                    </main>
                </template>
            </PanelSplitBox><!-- 分割面板 -->
        </div>
    </div>

</template>
<script setup>
import { ref, onMounted, watch } from 'vue'
import PanelSplitBox from '@/layout/components/PanelSplit.vue'
import ToolSidebarBox from '@/layout/components/toolSidebar/index.vue'
import ContentBox from './contentPage.vue'
import levitatedSphereBox from '@/layout/components/levitatedSphere.vue'
import PageHeaderBox from '@/layout/components/PageHeader/index.vue'
import { getPageId } from '@/api/note/index.js'
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()


const loading = ref(true);

// 监听 pageId 的变化
watch(() => store.routerParamsId.pageId, (newVal, oldVal) => {
    if (newVal !== oldVal && newVal != undefined) {
        fetchData(newVal);
    }
});

// 获取数据的函数
const fetchData = (id) => {
    loading.value = true;
    getPageId(id).then((data) => {
        console.log("获取当前页面数据");
        console.log(data);
        loading.value = false;
        StorePage.pageData = data
    }).catch((e) => {
        console.error('获取页面数据失败', e);
    });
}

// 在组件挂载时获取数据
onMounted(() => {
    fetchData(store.routerParamsId.pageId)
});

</script>
<style scoped lang='scss'>
.MainContent {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.PageHeader {
    width: 100%;
    height: 50px;
    display: flex;
}

.mainbox {
    width: 100%;
    height: calc(100% - 50px);

    .sidebar {
        width: 100%;
        height: 100%;
    }

    .content {
        width: 100%;
        height: 100%;
        position: relative;
    }
}
</style>
