<template>
    <div class="sidebar">
        <UserBox /><!-- 用户头像 -->
        <collectBox /><!-- 快速访问 收藏 -->
        <n-tree block-line draggable :data="data" :checked-keys="checkedKeys" :expanded-keys="expandedKeys"
            @drop="handleDrop" @update:checked-keys="handleCheckedKeysChange"
            @update:expanded-keys="handleExpandedKeysChange">
            <template #title="{ node }">
                <n-icon size="20" :component="node.icon"></n-icon> {{ node.label }}
            </template>
        </n-tree>
        <spaceBox />
    </div>
</template>

<script setup>
import { ref } from "vue";
import UserBox from './components/UserBox.vue';
import collectBox from './components/collect.vue';
import spaceBox from './components/space.vue';
import { Crow, Connectdevelop, Blackberry, Magic } from '@vicons/fa';

// 加载 JSON 数据
let treeData = [
    {
        "label": "哈哈哈",
        "key": "0",
        "icon": Blackberry,
        "children": [
            {
                "label": "一生二",
                "key": "1",
                "icon": Connectdevelop,
                "children": []
            },
            {
                "label": "二生三",
                "key": "2",
                "icon": Crow,
                "children": []
            }
        ]
    },
    {
        "label": "三生万物",
        "key": "3",
        "icon": Magic,
        "children": []
    }
];

// 创建树数据
const data = ref(treeData);

// 定义 refs
const expandedKeys = ref([]);
const checkedKeys = ref([]);

// 处理展开节点变化
function handleExpandedKeysChange(expandedKeysVal) {
    expandedKeys.value = expandedKeysVal;
}

// 处理勾选节点变化
function handleCheckedKeysChange(checkedKeysVal) {
    checkedKeys.value = checkedKeysVal;
}

// 处理拖拽节点
function handleDrop({ node, dragNode, dropPosition }) {
    // ...处理逻辑保持不变
}
</script>

<style scoped lang='scss'>
.sidebar{
    width: 100%;
    height: 100%;
    position: relative;
}
</style>
