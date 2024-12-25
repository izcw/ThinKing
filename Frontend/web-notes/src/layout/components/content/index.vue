<template>
    <div v-if="loading" v-loading="loading" style="width: 100%;height: 100%;">

    </div>
    <div v-else class="MainContent">
        <div class="PageHeader">
            <PageHeaderBox />
        </div><!-- 页头 -->
        <div class="mainbox" ref="pageContentRef">
            <PanelSplitBox :defaultSize="300" :minPanelSize="250" :maxPanelSize="800" contentPanel="right"
                :defaultSwitch="true">
                <template v-slot:1>
                    <div class="sidebar">
                        <ToolSidebarBox />
                    </div>
                </template>
                <template v-slot:2>
                    <main class="content">
                        <el-button size="small" style="position: absolute;top: 1rem;left: 1rem;z-index: 99;"
                            v-if="FullDocumentStatus" @click="exitFullScreen">
                            <n-icon size="12">
                                <ArrowLeft12Filled />
                            </n-icon>退出预览模式</el-button>
                        <ContentBox />
                        <levitatedSphereBox @requestFullScreen="requestFullScreen" />
                    </main>
                </template>
            </PanelSplitBox><!-- 分割面板 -->
        </div>
    </div>

</template>
<script setup>
import { ref, onMounted, watch } from 'vue'
import { ArrowLeft12Filled } from '@vicons/fluent'
import PanelSplitBox from '@/layout/components/PanelSplit.vue'
import ToolSidebarBox from '@/layout/components/toolSidebar/index.vue'
import ContentBox from './contentPage.vue'
import { ElMessage } from 'element-plus'
import screenfull from "screenfull";

import levitatedSphereBox from '@/layout/components/levitatedSphere.vue'
import PageHeaderBox from '@/layout/components/PageHeader/index.vue'
import { useRouter } from 'vue-router'
import { getPageId } from '@/api/note/index.js'
import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore()
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
const router = useRouter()


const loading = ref(true);

// 监听 pageId 的变化
watch(() => store.routerParamsId.pageId, (newVal, oldVal) => {
    if (newVal !== oldVal && newVal != undefined) {
        fetchData(newVal);
    }
});

watch(() => store.spacePageData, (newVal) => {
    if (store.spacePageData) {
        StorePage.pageDataParent = []
        findParents(getid.value, store.spacePageData);
    }
})

let getid = ref()
// 获取数据的函数
const fetchData = (id) => {
    getid.value = id
    loading.value = true;
    getPageId(id).then((data) => {
        console.log("获取当前页面数据");
        console.log(data);
        loading.value = false;
        StorePage.pageData = data;

        // console.log("当方法-------");
        // findParents(id, store.spacePageData);
        if (store.spacePageData) {
            StorePage.pageDataParent = []
            findParents(getid.value, store.spacePageData);
        }

    }).catch((e) => {
        ElMessage({
            message: '没有这个页面',
            type: 'warning',
        });
        router.push('/space/' + store.routerParamsId.spaceId)
        console.error('获取页面数据失败', e);
    });
}

// 在组件挂载时获取数据
onMounted(() => {
    fetchData(store.routerParamsId.pageId)
});



// 递归查找父级
function findParents(pageId, pagesArray) {
    for (const page of pagesArray) {
        if (page.pageId === pageId) {
            // 当前页加入结果，保留完整 children 结构
            StorePage.pageDataParent.unshift({ ...page });
            // 如果存在父级，继续递归查找
            if (page.parentId && page.parentId !== '0') {
                findParents(page.parentId, pagesArray);
            }
            break;
        }
        // 如果当前页有子级，递归查找
        if (page.children && page.children.length > 0) {
            findParents(pageId, page.children);
        }
    }
}


// 文档全屏
let FullDocumentStatus = ref(false)
let pageContentRef = ref(null)
let requestFullScreen = () => {
    if (screenfull.isEnabled) {
        screenfull.request(pageContentRef.value);
        FullDocumentStatus.value = true
        storeEditor.editor.setEditable(false)
    }
}

// 退出全屏
let exitFullScreen = () => {
    if (screenfull.isEnabled) {
        screenfull.exit(pageContentRef.value);
        FullDocumentStatus.value = false;
        storeEditor.editor.setEditable(true)
    }
}
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
    background-color: #fff;


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
