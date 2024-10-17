<template>
    <n-tree block-line draggable :data="data" :checked-keys="checkedKeys" :expanded-keys="expandedKeys"
        @drop="handleDrop" @update:checked-keys="handleCheckedKeysChange"
        @update:expanded-keys="handleExpandedKeysChange" />
</template>

<script setup>
import { ref } from "vue";
import { repeat } from "seemly";

// 创建树数据
function createData(level = 4, baseKey = "") {
    if (!level) return;
    return repeat(6 - level, void 0).map((_, index) => {
        const key = `${baseKey}${level}${index}`;
        return {
            label: createLabel(level),
            key,
            children: createData(level - 1, key),
        };
    });
}

// 根据层级创建标签
function createLabel(level) {
    if (level === 4) return "道生一";
    if (level === 3) return "一生二";
    if (level === 2) return "二生三";
    if (level === 1) return "三生万物";
    return "";
}

// 查找节点的兄弟节点和索引
function findSiblingsAndIndex(node, nodes) {
    if (!nodes) return [null, null];
    for (let i = 0; i < nodes.length; ++i) {
        const siblingNode = nodes[i];
        if (siblingNode.key === node.key) return [nodes, i];
        const [siblings, index] = findSiblingsAndIndex(node, siblingNode.children);
        if (siblings && index !== null) return [siblings, index];
    }
    return [null, null];
}

// 定义 refs
const expandedKeys = ref([]);
const checkedKeys = ref([]);
const data = ref(createData() || []);

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
    const [dragNodeSiblings, dragNodeIndex] = findSiblingsAndIndex(
        dragNode,
        data.value
    );
    if (dragNodeSiblings === null || dragNodeIndex === null) return;
    dragNodeSiblings.splice(dragNodeIndex, 1);

    if (dropPosition === "inside") {
        if (node.children) {
            node.children.unshift(dragNode);
        } else {
            node.children = [dragNode];
        }
    } else if (dropPosition === "before") {
        const [nodeSiblings, nodeIndex] = findSiblingsAndIndex(node, data.value);
        if (nodeSiblings === null || nodeIndex === null) return;
        nodeSiblings.splice(nodeIndex, 0, dragNode);
    } else if (dropPosition === "after") {
        const [nodeSiblings, nodeIndex] = findSiblingsAndIndex(node, data.value);
        if (nodeSiblings === null || nodeIndex === null) return;
        nodeSiblings.splice(nodeIndex + 1, 0, dragNode);
    }

    // 更新数据
    data.value = Array.from(data.value);
}
</script>
<style scoped lang='scss'>

</style>