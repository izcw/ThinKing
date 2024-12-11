<template>
    <div class="contentPage">
        <div class="pageIcon">
            <span class="icon" v-if="StorePage.pageData.icon">{{ StorePage.pageData.icon }}</span>
            <n-icon class="icon" v-else color="#666">
                <FileTextOutlined />
            </n-icon>
        </div>
        <el-input v-model.trim="title" :resize="'none'" @blur="updateTitle" style="width: 100%" autosize type="textarea"
            placeholder="未命名页面" />
        <TipTapEditor />
    </div>
</template>
<script setup>
import { ref, watch } from 'vue';
import TipTapEditor from '@/components/TipTapEditor/index.vue'
import { FileTextOutlined } from '@vicons/antd'
import { update } from '@/api/note/index.js'
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()


let title = ref(StorePage.pageData.title)
// watch(title, (newValue, oldValue) => {
//     console.log('标题发生变化了');
//     console.log('新值:', newValue);
// });


// 更新title
let updateTitle = () => {
    console.log("jiao");
    update({ pageId: StorePage.pageData.pageId, title: title.value }).then((data) => {
        console.log("修改成功", data);
        StorePage.pageData = data
    }).catch((e) => {
        console.error('修改失败', e);
    });
}
</script>
<style lang='scss'>
.contentPage {
    width: 100%;
    height: 100%;
    margin-top: 1rem;
    margin-bottom: 100px;
    position: relative;

    // 页面图标
    .pageIcon {
        position: absolute;
        top: -65px;
        left: 0;
        font-size: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        .pageIcon {
            top: -45px;
            width: 55px;
            height: 55px;
            font-size: 45px;
        }
    }

    // 标题
    .el-textarea__inner {
        color: #333;
        font-size: 36px !important;
        font-weight: 600 !important;
        box-shadow: none !important;
        padding: 0 !important;
        margin: 0 !important;
        padding-bottom: 1rem !important;
        margin-top: 50px !important;
        margin-bottom: 1rem !important;
        border-bottom: 1px solid #eee;

        &::-webkit-input-placeholder {
            color: #E1E1E0;
        }
    }
}
</style>
