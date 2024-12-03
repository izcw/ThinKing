<template>
    <div class="catalogOutline">
        <!-- 目录 -->
        <n-collapse default-expanded-names="1" arrow-placement="right">
            <n-collapse-item title="目录" name="1">
                <template v-if="store.editor">
                    <Toc :editor="store.editor" :items="store.catalog" />
                </template>
            </n-collapse-item>
        </n-collapse>

        <!-- 其它 -->
        <n-collapse default-expanded-names="1" arrow-placement="right">
            <n-collapse-item title="标签" name="1">
                <el-space wrap>
                    <el-tag type="info">Vue</el-tag>
                    <el-tag type="info">Java</el-tag>
                </el-space>
            </n-collapse-item>
            <n-collapse-item title="文件目录" name="2">
                <n-space vertical :size="12">
                    <n-alert type="default" :show-icon="false">
                        <div style="display: flex;align-items: center;">
                            <n-image width="40" height="30"
                                src="https://www.notion.so/images/page-cover/rijksmuseum_jansz_1649.jpg"
                                :render-toolbar="renderToolbar">
                            </n-image>
                            <n-ellipsis style="padding:0 10px;box-sizing: border-box;">
                                Snipaste_2024-09-29_00-35-00.png
                            </n-ellipsis>
                            <n-popover trigger="click">
                                <template #trigger>
                                    <n-button quaternary size="small">
                                        <n-icon size="18" style="color:#333;">
                                            <MoreCircle32Regular />
                                        </n-icon>
                                    </n-button>
                                </template>
                                <!--  -->
                                <n-button quaternary size="small">
                                    <n-icon size="18" style="color:#333;">
                                        <Share48Regular />
                                    </n-icon>
                                </n-button>
                                <n-button quaternary size="small">
                                    <n-icon size="18" style="color:#333;">
                                        <ArrowDownload20Filled />
                                    </n-icon>
                                </n-button>
                                <n-button quaternary size="small">
                                    <n-icon size="18" style="color:#333;">
                                        <Copy16Regular />
                                    </n-icon>
                                </n-button>
                            </n-popover>
                        </div>
                    </n-alert>
                </n-space>
            </n-collapse-item>
            <n-collapse-item title="双向链接" name="3">
                <RelationshipDiagramBox />
            </n-collapse-item>
        </n-collapse>
    </div>
</template>

<script scoped setup>
import { ref, onMounted, watch, reactive } from 'vue'
import Toc from '@/components/TipTapEditor/components/TableOfContents/index.vue'
import RelationshipDiagramBox from '@/views/index/components/RelationshipDiagram.vue';
import { MoreCircle32Regular, Share48Regular, ArrowDownload20Filled, Copy16Regular } from '@vicons/fluent'
import { useEditorPageStore } from '@/stores/EditorPage'
const store = useEditorPageStore()


// 回到顶部的函数
const scrollIntoViewUp = () => {
    let element = document.getElementById('BackTop')
    element.scrollIntoView({
        behavior: "smooth",
        inline: "nearest"
    });
};
</script>

<style lang='scss'>
.catalogOutline {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    overflow-y: auto;
}
</style>