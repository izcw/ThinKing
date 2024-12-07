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
                    <el-tree v-if="treeData" style="background-color: transparent;" :allow-drop="allowDrop"
                        :allow-drag="allowDrag" :data="treeData" draggable node-key="id" :expand-on-click-node="false"
                        @node-drag-start="handleDragStart" @node-drag-enter="handleDragEnter"
                        @node-drag-leave="handleDragLeave" @node-drag-over="handleDragOver"
                        @node-drag-end="handleDragEnd" @node-drop="handleDrop" :default-expanded-keys="['1']"
                        highlight-current>
                        <template #default="{ node, data }">
                            <div class="custom-tree-node"
                                :style="{ 'background-color': store.routerParamsId.spaceId == node.data.pageId ? '#efefed' : 'transparent' }">
                                <div class="title" @click="openPage(node.data)">
                                    <span class="icon">{{ node.data.icon }}</span>
                                    <el-text truncated>{{ node.data.title }}</el-text>
                                </div>
                                <div class="tools">
                                    <div class="content">
                                        <el-tooltip content="删除，创建副本等。" placement="bottom" effect="light"
                                            :hide-after="0">
                                            <n-button strong secondary size="tiny">
                                                <n-icon>
                                                    <MoreHorizontal24Filled />
                                                </n-icon>
                                            </n-button>
                                        </el-tooltip>
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
import { Add16Filled, MoreHorizontal24Filled, ArrowDownload20Filled, Copy16Regular } from '@vicons/fluent'
import { ElMessage } from 'element-plus'
import { addPage, getSpacePage } from '@/api/note/index.js'
import { useRouter, useRoute } from 'vue-router'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

// 获取当前路由参数
const router = useRouter()
const route = useRoute();


// 空间路由改变获取当前空间笔记
watch(() => store.routerParamsId.spaceId, (newVal, oldVal) => {
    if (newVal !== oldVal && newVal != undefined) {
        getSpaceData(newVal)
    }
});

let getSpaceData = (val) => {
    getSpacePage({ spaceId: val }).then((data) => {
        console.log("获取当前空间的所有笔记");
        console.log(data);

        treeData.value = buildTree(data)
    }).catch((e) => {
        console.error('获取失败', e);
    });
}
getSpaceData(store.routerParamsId.spaceId)

// 打开页面
let openPage = (val) => {
    console.log("打开页面");
    router.push('/space/' + store.routerParamsId.spaceId + '/' + val.pageId)
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
        store.fetchUserInfo();
    }).catch((e) => {
        console.error('添加失败', e);
    });
}



// 笔记数据
const treeData = ref()


// 将笔记数据构建树形结构的函数
function buildTree(data) {
    const tree = [];
    const map = new Map();

    if (data) {
        data.forEach(item => {
            const node = { ...item, children: [] };
            map.set(item.pageId, node);
        });

        data.forEach(item => {
            const node = map.get(item.pageId);
            if (item.parentId === '0') {
                tree.push(node);
            } else {
                const parentNode = map.get(item.parentId);
                if (parentNode) {
                    parentNode.children.push(node);
                }
            }
        });
    }

    return tree;
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

            // .item {
            //     width: 24px;
            //     height: 24px;
            //     display: flex;
            //     align-items: center;
            //     justify-content: center;

            //     border-radius: 4px;

            //     &:hover,
            //     &:active {
            //         background-color: #DDDDDB;
            //     }
            // }
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