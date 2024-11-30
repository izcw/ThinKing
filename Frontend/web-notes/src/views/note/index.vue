<template>
    <div class="contentPage GMargin">
        <div class="pageIcon"></div>
        <el-input v-model="title" :resize="'none'" style="width: 100%" autosize type="textarea" placeholder="未命名页面" />
        <TipTapEditor />
        <!-- <p>大师风范的返回结果吧据东方大师风范的返回结果吧据东方化工科技和就返回港口集团引入俄国热狗图也工程包括v凯瑞福永看过热炕头给大师风范的返回结果吧据东方化工科技和就返回港口集团引入俄国热狗图也工程包括v凯瑞福永看过热炕头给化工科技和就返回港口集团引入俄国热狗图也工程包括v凯瑞福永看过热炕头给</p> -->
    </div>
</template>
<script setup>
import { ref, watch } from 'vue';
import TipTapEditor from '@/components/TipTapEditor/index.vue'


let title = ref('你好Hello!!. ')
watch(title, (newValue, oldValue) => {
    console.log('标题发生变化了');
    console.log('新值:', newValue);
});
</script>
<style lang='scss'>
.contentPage {
    width: 100%;
    height: 100%;
    margin-top: 1rem;
    margin-bottom: 100px; // background-color: aqua;
    position: relative;

    // 页面图标
    .pageIcon {
        position: absolute;
        top: -46px;
        left: 12px;
        width: 60px;
        height: 60px;
        background-color: #efefed;
        cursor: pointer;
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
        margin-top: 3rem !important;
        margin-bottom: 1rem !important;
        border-bottom: 1px solid #eee;


        &::-webkit-input-placeholder {
            color: #E1E1E0;
        }
    }
}
</style>
