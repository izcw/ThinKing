<template>
    <div v-if="loading" class="shareBox">
        <div
            style="background-color: #fff;padding:2rem 3rem;margin: 0 auto; max-width: 720px;width: 720px; height: 50vh;">
            <n-skeleton text :repeat="7" style="height: 20px;margin-bottom: 10px;" />
            <n-skeleton text style="width: 60%;height: 20px;margin-bottom: 10px;" />
        </div>
    </div>
    <div v-else-if="StorePage.pageData.share == 0" class="shareBox">
        <div
            style="background-color: #fff;padding:2rem 3rem;margin: 0 auto; max-width: 720px;width: 720px; height: 50vh;display: flex;align-items: center;justify-content: center;">
            <n-empty description="此页面不能查看">
                <template #icon>
                    <n-icon>
                        <LockOutlined />
                    </n-icon>
                </template>
                <template #extra>
                    <router-link to="/login">
                        <n-button>
                            登录&nbsp;/&nbsp;注册
                        </n-button>
                    </router-link>
                </template>
            </n-empty>
        </div>
    </div>
    <div v-else class="shareBox">
        <!-- 内容 -->
        <div class="centent">
            <h1 class="article-h1">{{ StorePage.pageData.title }}</h1>
            <TipTapEditorBox />
        </div>

        <!-- 目录 -->
        <div class="catalog" v-show="storeEditor.catalog.length != 0">
            <Toc :editor="storeEditor.editor" :items="storeEditor.catalog" />
        </div>
    </div>
</template>
<script setup>
import { ref, onMounted, watch } from 'vue'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'
import { getSharePageId } from '@/api/note/index.js'
import { usePageStore } from '@/stores/page'
import { LockOutlined } from '@vicons/antd'
import TipTapEditorBox from '@/components/TipTapEditor/index.vue'
import Toc from '@/components/TipTapEditor/components/TableOfContents/index.vue'
import { setPageTitle } from '@/utils/page-title-util';
const StorePage = usePageStore()
import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore()
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
const router = useRouter()


const loading = ref(true);
// 监听 shareId 的变化
watch(() => store.routerParamsId.shareId, (newVal, oldVal) => {
    console.log("777777" + newVal);

    if (newVal !== oldVal && newVal != undefined) {
        console.log(newVal);
        fetchData(newVal);
    }
});

// 获取数据的函数
const fetchData = (id) => {
    loading.value = true;
    getSharePageId(id).then((data) => {
        console.log("获取当前页面数据");
        console.log(data);
        loading.value = false;
        data.readonly = 1;
        StorePage.pageData = data;
        setPageTitle(StorePage.pageData.title);

    }).catch((e) => {
        ElMessage({
            message: '没有这个页面',
            type: 'warning',
        });
        router.push('/')
        console.error('获取页面数据失败', e);
    });
}
// 在组件挂载时获取数据
onMounted(() => {
    fetchData(store.routerParamsId.shareId);
});
</script>
<style lang='scss'>
.homePage {
    background-color: #f9f9f9;
}

.shareBox {
    display: flex;
    justify-content: center;
    padding-top: 100px;
    margin-bottom: 200px;

    .article-h1 {
        font-weight: 520;
        font-size: 26px;
        line-height: 42px;
        color: #292525;
        text-align: center;
        padding: 2rem 0;
        transition: all 0.5s ease;
    }


    .centent {
        max-width: 720px;
        background-color: #fff;
        padding: 2rem 3rem;
        box-sizing: border-box;
        border-radius: 5px;
    }

    .catalog {
        width: 280px;
        height: 100%;
        margin-left: 1rem;
        padding: 2rem 1rem;
        box-sizing: border-box;
        border-radius: 5px;
        background-color: #fff;
        border-bottom: 3px solid #eee;

        position: sticky;
        top: 120px;
    }

}

@media (max-width: 992px) {
    .homePage {
        background-color: #fff !important;
    }

    .shareBox {
        padding-top: 0px !important;
    }

    .catalog {
        display: none;
    }

    .centent {
        padding: 0px !important;
    }
}
</style>
