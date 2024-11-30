<template>
    <bubble-menu :editor="editor" :tippy-options="{ duration: 50 }" v-if="editor">
        <div class="bubble-menu">
            <el-button size="small" @click="editor.chain().focus().toggleBold().run()"
                :class="{ 'is-active': editor.isActive('bold') }">
                B
            </el-button>
            <el-button size="small" @click="editor.chain().focus().toggleItalic().run()"
                :class="{ 'is-active': editor.isActive('italic') }">
                I
            </el-button>
            <el-button size="small" @click="editor.chain().focus().toggleStrike().run()"
                :class="{ 'is-active': editor.isActive('strike') }">
                <del>del</del>
            </el-button>
            <ColorPicker format="rgb" shape="circle" :roundHistory="true" :disableAlpha="true"
                @update:pureColor="handlePureColorChange" />
        </div>
    </bubble-menu>
</template>
<script setup>
import { ref, defineProps } from 'vue'
import { ElButton } from 'element-plus'
import { BubbleMenu } from '@tiptap/vue-3'


import { ColorPicker } from "vue3-colorpicker";
import "vue3-colorpicker/style.css";


const props = defineProps({
    editor: {
        type: Object,
        required: true
    }
})

// 点击颜色时
const handlePureColorChange = (pureColor) => {
    console.log("纯色变化:", pureColor); // 打印纯色变化
    props.editor.commands.setColor(pureColor)
}
</script>
<style scoped lang='scss'>
.bubble-menu {
    padding: 6px 12px;
    border-radius: 4px;
    background-color: #fff;
    box-shadow: 0 2px 10px #ccc;
}
</style>
