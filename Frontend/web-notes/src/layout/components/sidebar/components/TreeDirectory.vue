<template>
    <n-collapse :trigger-areas="['main', 'arrow']" default-expanded-names="1">

        <!-- 添加 -->
        <template #header-extra>
            <el-tooltip content="添加页面" placement="bottom" effect="light" :hide-after="0">
                <n-button strong secondary size="tiny" @click="addPageFun(0)">
                    <n-icon>
                        <Add16Filled />
                    </n-icon>
                </n-button>
            </el-tooltip>
        </template>

        <!-- 树形目录 -->
        <n-collapse-item title="我的页面" name="1">
            <div class="sidebarTree">
                <n-infinite-scroll style="height: 360px" :distance="10">
                    <n-skeleton v-if="!store.treeData || !store.spacePageData" :repeat="5"
                        style="width: 100%; height: 20px;margin-bottom: 10px;" :sharp="false" size="medium" />
                    <el-tree v-else style="background-color: transparent;" :allow-drop="allowDrop"
                        :allow-drag="allowDrag" :data="store.treeData" draggable :expand-on-click-node="false"
                        @node-drag-start="handleDragStart" @node-drag-enter="handleDragEnter"
                        @node-drag-leave="handleDragLeave" @node-drag-over="handleDragOver"
                        @node-drag-end="handleDragEnd" @node-drop="handleDrop" node-key="pageId"
                        :default-expanded-keys="[store.routerParamsId.pageId ? store.routerParamsId.pageId : '']"
                        highlight-current>
                        <template #default="{ node, data }">
                            <div class="custom-tree-node"
                                :class="{ 'Current-Open-Page': store.routerParamsId.pageId == node.data.pageId }"
                                :style="{ 'background-color': store.routerParamsId.spaceId == node.data.pageId ? '#efefed' : 'transparent' }">
                                <div class="title" @click="openPage(node.data)">
                                    <span class="icon" v-if="node.data.icon">{{ node.data.icon }}</span>
                                    <n-icon class="icon" size="16" v-else>
                                        <FileTextOutlined />
                                    </n-icon>
                                    <el-text truncated>{{ node.data.title ? node.data.title : '未命名页面' }}</el-text>
                                </div>
                                <div class="tools">
                                    <div class="content">
                                        <!-- <el-tooltip placement="bottom" effect="light">
                                            <n-button strong secondary size="tiny">
                                                <n-icon>
                                                    <MoreHorizontal24Filled />
                                                </n-icon>
                                            </n-button>
                                        </el-tooltip> -->
                                        <el-popover placement="top" trigger="click">
                                            <template #reference>
                                                <n-button strong secondary size="tiny">
                                                    <n-icon>
                                                        <MoreHorizontal24Filled />
                                                    </n-icon>
                                                </n-button>
                                            </template>
                                            <!-- 删除 -->
                                            <el-popconfirm title="你确定要删除?" @confirm="DeletePageFun(node.data)">
                                                <template #reference>
                                                    <n-button strong secondary size="small">
                                                        <n-icon>
                                                            <Delete48Filled />
                                                        </n-icon>
                                                    </n-button>
                                                </template>
                                            </el-popconfirm>

                                        </el-popover>

                                        <el-tooltip content="添加子页面" placement="bottom" effect="light" :hide-after="0">
                                            <n-button strong secondary size="tiny" style="margin-left: 4px;"
                                                @click="addPageFun(node.data.pageId)">
                                                <n-icon>
                                                    <Add16Filled />
                                                </n-icon>
                                            </n-button>
                                        </el-tooltip>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </el-tree>
                </n-infinite-scroll>
            </div>
        </n-collapse-item>
    </n-collapse>
</template>

<script setup>
import { onMounted, ref, computed, watch } from 'vue';
import { Add16Filled, MoreHorizontal24Filled, ArrowDownload20Filled, Delete48Filled } from '@vicons/fluent'
import { FileTextOutlined } from '@vicons/antd'
import { ElMessage } from 'element-plus'
import { addPage, getSpacePage, upRecycle } from '@/api/note/index.js'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

const router = useRouter()

// 目录标题改变
watch(() => store.treeData.value, (newVal) => {
    console.log("标题改变");

})


// 空间路由改变获取当前空间笔记
watch(() => store.routerParamsId.spaceId, (newVal, oldVal) => {
    console.log("切换" + newVal);
    if (newVal !== oldVal && newVal != undefined) {
        store.getSpaceData(newVal)
    }
});

store.getSpaceData(store.routerParamsId.spaceId)

// 打开页面
let openPage = (val) => {
    console.log("打开页面");
    router.push('/space/' + val.spaceId + '/' + val.pageId)
}


// 添加页面
let addPageFun = (val) => {
    console.log("添加页面" + val);
    addPage({ spaceId: store.routerParamsId.spaceId, parentId: val }).then((data) => {
        console.log("添加成功", data);
        ElMessage({
            message: '添加成功',
            type: 'success',
        });
        store.getSpaceData(store.routerParamsId.spaceId)
    }).catch((e) => {
        console.error('添加失败', e);
    });
}


// 删除页面
let DeletePageFun = (val) => {
    console.log(val);

    upRecycle({ pageId: val.pageId, status: 1 }).then((msg) => {
        console.log("删除成功", msg);
        // if (store.routerParamsId.pageId == val) {
        router.push('/space/' + val.spaceId)
        // }
        ElMessage({
            message: msg,
            type: 'success',
        });
        setTimeout(() => {
            getSpacePage({ spaceId: store.routerParamsId.spaceId }).then((data) => {
                console.log("获取当前空间的所有笔记");
                store.spacePageData = data;
            }).catch((e) => {
                console.error('获取失败', e);
            });
        }, 100);
    }).catch((e) => {
        console.error(e);
    });
}




// 树形目录的操作
const handleDragStart = (node, ev) => {
    console.log('drag start', node);
};
const handleDragEnter = (draggingNode, dropNode, ev) => {
    console.log('tree drag enter:', dropNode.label);
};
const handleDragLeave = (draggingNode, dropNode, ev) => {
    console.log('tree drag leave:', dropNode.label);
};
const handleDragOver = (draggingNode, dropNode, ev) => {
    console.log('tree drag over:', dropNode.label);
};
const handleDragEnd = (draggingNode, dropNode, dropType, ev) => {
    console.log('tree drag end:', dropNode && dropNode.label, dropType);
};
const handleDrop = (draggingNode, dropNode, dropType, ev) => {
    console.log('tree drop:', dropNode.label, dropType);
};
const allowDrop = (draggingNode, dropNode, type) => {
    if (dropNode.data.label === 'Level two 3-1') {
        return type !== 'inner';
    } else {
        return true;
    }
};
const allowDrag = (draggingNode) => {
    return !draggingNode.data.label.includes('Level three 3-1-1');
};

// Append and Remove methods
const append = (data) => {
    console.log('append', data);
};

const remove = (node, data) => {
    console.log('remove', node, data);
};
</script>

<style scoped lang='scss'>
.custom-tree-node {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;


    .title {
        display: flex;
        align-items: center;
        overflow: hidden;
        padding-left: 4px;
        padding-right: 10px;

        width: 100%;
        height: 100%;
        box-sizing: border-box;

        span {
            font-size: 15px !important;
        }

        .icon {
            font-size: 15px !important;
            opacity: 1;
            margin-right: 12px;

        }
    }

    .tools {
        position: absolute;
        right: 4px;
        top: 0;
        bottom: 0;
        margin: auto;
        opacity: 0;

        .content {
            display: flex;
            align-items: center;
            padding-right: 4px;
        }
    }
}

.custom-tree-node:hover .title {
    width: calc(100% - 52px);
}

.custom-tree-node:hover .tools {
    opacity: 1;
}
</style>