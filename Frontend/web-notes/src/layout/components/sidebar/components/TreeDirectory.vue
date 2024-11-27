<template>
    <el-tree style="background-color: transparent;" :allow-drop="allowDrop" :allow-drag="allowDrag" :data="data"
        draggable node-key="id" :expand-on-click-node="false" @node-drag-start="handleDragStart"
        @node-drag-enter="handleDragEnter" @node-drag-leave="handleDragLeave" @node-drag-over="handleDragOver"
        @node-drag-end="handleDragEnd" @node-drop="handleDrop">
        <template #default="{ node, data }">
            <div class="custom-tree-node">
                <div class="title" @click="openPage(node)">
                    <span class="icon">🥈</span>
                    <el-text truncated>{{ node.label }}</el-text>
                </div>
                <div class="tools">
                    <div class="item" @click="append(data)">
                        +
                    </div>
                    <div class="item" @click="remove(node, data)">
                        ...
                    </div>
                </div>
            </div>
        </template>
    </el-tree>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router'
const router = useRouter()

let openPage = (val) => {
    router.push('/space1/' + val.label)
}

// Data
const data = ref([
    {
        label: '莎士比亚笔下的爱情观',
        children: [
            {
                label: 'Level two 1-1',
                children: [
                    {
                        label: 'Level three 1-1-1',
                    },
                ],
            },
        ],
    },
    {
        label: 'Java',
        children: [
            {
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
    width: calc(100% - 26px);
    display: flex;
    align-items: center;
    justify-content: space-between;

    .icon {
        margin-right: 10px;
    }

    .title {
        display: flex;
        align-items: center;
        overflow: hidden;
        padding-left: 4px;
        
        width: 100%;
        height: 100%;
        padding-right: 10px;
        box-sizing: border-box;

        span{
            font-size: 15px !important;
        }
        .icon {
            font-size: 18px !important;
            opacity: 1;
        }
    }

    .tools {
        display: flex;
        align-items: center;
        opacity: 0;

        .item {
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 4px;

            &:hover,
            &:active {
                background-color: #fff;
            }
        }
    }
}

.custom-tree-node:hover .tools,
.custom-tree-node:active .tools {
    opacity: 1;
}
</style>