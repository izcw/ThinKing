<template>
    <n-collapse :trigger-areas="['main', 'arrow']" default-expanded-names="1">
        <template #header-extra>
            <el-tooltip content="添加页面" placement="bottom" effect="light" :hide-after="0">
                <n-button strong secondary size="tiny">
                    <n-icon>
                        <Add16Filled />
                    </n-icon>
                </n-button>
            </el-tooltip>
        </template>
        <n-collapse-item title="我的页面" name="1">
            <div class="sidebarTree">
                <n-infinite-scroll style="height: 360px" :distance="10">
                    <el-tree style="background-color: transparent;" :allow-drop="allowDrop" :allow-drag="allowDrag"
                        :data="data" draggable node-key="id" :expand-on-click-node="false"
                        @node-drag-start="handleDragStart" @node-drag-enter="handleDragEnter"
                        @node-drag-leave="handleDragLeave" @node-drag-over="handleDragOver"
                        @node-drag-end="handleDragEnd" @node-drop="handleDrop" :default-expanded-keys="['1']"
                        highlight-current>
                        <template #default="{ node, data }">
                            <div class="custom-tree-node">
                                <div class="title" @click="openPage(node)">
                                    <span class="icon">🥈</span>
                                    <el-text truncated>{{ node.label }}</el-text>
                                </div>
                                <div class="tools">
                                    <div class="content">
                                        <el-tooltip content="删除，创建副本等。" placement="bottom" effect="light"  :hide-after="0">
                                            <n-button strong secondary size="tiny">
                                                <n-icon>
                                                    <MoreHorizontal24Filled />
                                                </n-icon>
                                            </n-button>
                                        </el-tooltip>
                                        <el-tooltip content="添加子页面" placement="bottom" effect="light"  :hide-after="0">
                                            <n-button strong secondary size="tiny" style="margin-left: 4px;">
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
import { ref } from 'vue';
import { Add16Filled, MoreHorizontal24Filled, ArrowDownload20Filled, Copy16Regular } from '@vicons/fluent'
import { useRouter } from 'vue-router'
const router = useRouter()

let openPage = (val) => {
    router.push('/space1/' + val.label)
}

// Data
const data = ref([
    {
        id: '1',
        label: '欢迎来到ThinKing笔记',
        children: [
            {
                id: '1.2',
                label: '我能用ThinKing来干什么？',
            },
            {
                id: '1.3',
                label: '入门教程',
            },
        ],
    },
    {
        id: '2',
        label: '莎士比亚笔下的爱情观',
        children: [
            {
                id: '2.1',
                label: 'Level two 1-1',
                children: [
                    {
                        id: '2.1.1',
                        label: 'Level three 1-1-1',
                    },
                ],
            },
        ],
    },
    {
        id: '3',
        label: 'Java',
        children: [
            {
                id: '3.1',
                label: '探索Java世界的奥秘',
                children: [
                    {
                        label: '第一章学习',
                    },
                    {
                        label: '第二章学习',
                    },
                ],
            },
            {
                label: 'Springboot',
                children: [
                    {
                        label: 'Level three 2-2-1',
                    },
                ],
            },
        ],
    },
    {
        label: '文字的力量',
        children: [
            {
                label: '文学的启示',
                children: [
                    {
                        label: 'Level three 3-1-1',
                    },
                ],
            },
            {
                label: 'Level two 3-2',
                children: [
                    {
                        label: 'Level three 3-2-1',
                    },
                ],
            },
        ],
    },
]);

// Methods
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