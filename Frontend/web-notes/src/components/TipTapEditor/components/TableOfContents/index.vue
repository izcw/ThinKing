<template>
    <template v-if="items.length === 0">
        <ToCEmptyState />
    </template>
    <template v-else>
        <el-tree style="margin-bottom: 3rem;" :data="store.treeData" :props="defaultProps" @node-click="handleNodeClick"
            default-expand-all :expand-on-click-node="false">
            <template #default="{ node, data }">
                <el-text truncated>{{ node.label }}</el-text>
            </template>
        </el-tree>
    </template>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { TextSelection } from '@tiptap/pm/state'
import ToCEmptyState from './ToCEmptyState.vue'
import { useEditorPageStore } from '@/stores/EditorPage'
const store = useEditorPageStore()

const props = defineProps({
    items: {
        type: Array,
        default: () => [],
    },
    editor: {
        type: Object,
        required: true,
    },
})

// 监听 items 的变化
watch(() => props.items, (newItems) => {
    store.treeData = buildTree(newItems)
});

// 用于构建树形结构的函数
const buildTree = (arr) => {
    const result = []; // 存储最终的树形结构数据
    const stack = []; // 用于记录当前节点的栈

    arr.forEach((item) => {
        const node = {
            label: item.textContent,
            id: item.id,
            originalLevel: item.originalLevel, // 标题
            itemIndex: item.itemIndex, // 序号
            children: [],
        };

        // 如果栈为空，或者当前项的 level 小于等于栈顶元素的 level，则新建一个顶层节点
        while (stack.length > 0 && item.originalLevel <= stack[stack.length - 1].level) {
            stack.pop(); // 弹出栈顶元素，回到上一层级
        }

        // 如果栈不为空，说明当前节点是上一个节点的子节点
        if (stack.length > 0) {
            stack[stack.length - 1].node.children.push(node); // 访问 node 而非直接访问 children
        } else {
            result.push(node); // 如果栈为空，则为顶层节点
        }

        // 将当前节点加入栈，表示它的子节点会在下一个循环中处理
        stack.push({ level: item.originalLevel, node });
    });

    return result;
};


// el-tree 配置项
const defaultProps = {
    children: 'children',
    label: 'label',
}

// 点击目录
const handleNodeClick = (data) => {
    onItemClick(data.id)
}


const onItemClick = (id) => {
    if (props.editor) {
        const element = props.editor.view.dom.querySelector(`[data-toc-id="${id}"`)

        // if (element) {
        //     // 保存原背景色
        //     const originalBgColor = element.style.backgroundColor;

        //     // 设置背景色为亮色            
        //     element.style.backgroundColor = '#E7F5FF';

        //     // 1秒后恢复原背景色
        //     setTimeout(() => {
        //         element.style.backgroundColor = originalBgColor;
        //     }, 1000);
        // }

        // 设置光标位置
        const pos = props.editor.view.posAtDOM(element, element.childNodes.length)

        const tr = props.editor.view.state.tr
        tr.setSelection(new TextSelection(tr.doc.resolve(pos)))
        props.editor.view.dispatch(tr)
        props.editor.view.focus()


        // 操作浏览器历史记录
        if (history.pushState) { // eslint-disable-line
            history.pushState(null, null, `#${id}`) // eslint-disable-line
        }


        // 页面滚动操作
        // console.log(element.getBoundingClientRect().top + window.scrollY); // 要滚动的高度
        element.scrollIntoView({
            behavior: "smooth",
            inline: "nearest"
        });

    }
}

</script>