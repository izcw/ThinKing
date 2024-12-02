<template>
    <div class="catalogOutline">
        <!-- 目录 -->
        <div class="sidebar">
            <div class="sidebar-options">
                <div class="label-large">目录</div>
                <div class="table-of-contents">
                    <template v-if="store.editor">
                        <Toc :editor="store.editor" :items="store.catalog" />
                    </template>
                </div>
            </div>
        </div>

        <!-- 其它 -->
        <n-collapse default-expanded-names="1">
            <n-collapse-item title="文件目录" name="1">
                <div class="">
                    图片
                    PDF
                </div>
            </n-collapse-item>
            <n-collapse-item title="日历" name="2">
                <div>1，2，3，4，5，6，7</div>
            </n-collapse-item>
            <n-collapse-item title="标签" name="3">
                <div>vue、java</div>
            </n-collapse-item>
            <n-collapse-item title="双向链接" name="4">
                <div>1——2——3</div>
            </n-collapse-item>
        </n-collapse>
    </div>
</template>

<script scoped setup>
import { ref, onMounted, watch, reactive } from 'vue'
import Toc from '@/components/TipTapEditor/components/TableOfContents/index.vue'
import { useEditorPageStore } from '@/stores/EditorPage'
const store = useEditorPageStore()
</script>

<style lang='scss'>
.catalogOutline {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}


</style>