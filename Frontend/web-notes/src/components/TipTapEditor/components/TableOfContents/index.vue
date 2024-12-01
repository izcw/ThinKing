<template>
    <template v-if="items.length === 0">
        <ToCEmptyState />
    </template>
    <template v-else>
        <ToCItem v-for="(item, i) in items" :key="item.id" :item="item" :index="i + 1" @item-click="onItemClick" />
    </template>
</template>

<script setup>
import { TextSelection } from '@tiptap/pm/state'
import ToCEmptyState from './ToCEmptyState.vue'
import ToCItem from './ToCItem.vue'
import { ref, onMounted } from 'vue'

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

const onItemClick = (e, id) => {
    if (props.editor) {
        const element = props.editor.view.dom.querySelector(`[data-toc-id="${id}"`)

        if (element) {
            // 保存原背景色
            const originalBgColor = element.style.backgroundColor;
            console.log(originalBgColor);
            

            // 设置背景色为亮色
            element.style.backgroundColor = '#E7F5FF';

            // 一秒后恢复原背景色
            setTimeout(() => {
                element.style.backgroundColor = originalBgColor;
            }, 2000);  // 延长为2秒

        }

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
        setTimeout(() => {
            window.scrollTo({
                top: element.getBoundingClientRect().top + window.scrollY,
                behavior: 'smooth',
            })
        }, 100);  // 确保光标定位先于滚动操作

    }
}
</script>