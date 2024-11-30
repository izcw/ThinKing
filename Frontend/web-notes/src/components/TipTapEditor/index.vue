<template>
    <div class="ThinKing-Editor-Box">
        <!-- <div>
            <el-button v-if="editor" @click="editor.chain().focus().undo().run()" :disabled="!editor.can().undo()">
                撤销
            </el-button>
            <el-button v-if="editor" @click="editor.chain().focus().redo().run()" :disabled="!editor.can().redo()">
                前进
            </el-button>
        </div> -->
        <!-- 编辑器 -->
        <editor-content :editor="editor" />

        <!-- 浮动菜单 -->
        <bubbleMenuBox v-if="editor" :editor="editor" />

        <!-- 为空时显示 -->
        <div v-if="contentData.length == null || contentData == '<p></p>'" class="EmptyPrompt">
            <el-button v-if="editor">
                表格
            </el-button>
            <el-button v-if="editor">
                列表
            </el-button>
        </div>

        <!-- 字符数 -->
        <div v-else>
            <NumberWordsBox v-if="editor" :editor="editor" :setting="setting" />
        </div>
    </div>
</template>

<script setup>
import { ref, onBeforeUnmount, onMounted } from 'vue'
import './components/css/style.scss'
import { ElButton } from 'element-plus'
import 'element-plus/dist/index.css'
import bubbleMenuBox from './components/bubbleMenu/index.vue'
import NumberWordsBox from './components/NumberWords/index.vue'
import { useEditor, EditorContent, BubbleMenu } from '@tiptap/vue-3'
import Document from '@tiptap/extension-document'
import Paragraph from '@tiptap/extension-paragraph'
import Text from '@tiptap/extension-text'
import Heading from '@tiptap/extension-heading' // 标题
import CharacterCount from '@tiptap/extension-character-count' // 字符数
import { Color } from '@tiptap/extension-color' // 字体颜色
import TextStyle from '@tiptap/extension-text-style'
import Dropcursor from '@tiptap/extension-dropcursor' // 拖动显示的条
import Placeholder from '@tiptap/extension-placeholder' // 占位符提示
import History from '@tiptap/extension-history' // 撤销和重做
import Commands from './components/SlashCommands/commands' // 斜线命令
import suggestion from './components/SlashCommands/suggestion.js'
import Mention from '@tiptap/extension-mention' // 提及
import MentionListSuggestion from './components/MentionList/suggestion'


// 配置
let setting = ref(
    {
        limit: 100000, // 允许的最大字符数
        History: 20, // 允许最大的撤销数量
    }
)

let contentData = ref('<p>有一点值得注意的是，类似于notion，obsdian复杂的笔记软件，使用难道高，学习成本大。flomo，iNote，备忘录📝软件，仅适合记录灵感，不适用于复杂的场景。传统的笔记例如有道云笔记，印象笔记，适合一些长期使用且不需要复杂功能的人群，因为它的笔记管理比较传统老套，以上所述涵盖三种类型，新型笔记双向链接、block。快速笔记灵感笔记。长期笔记，传统记法。</p>')
const editor = useEditor({
    content: contentData.value,
    autofocus: false, // 自动焦点
    editable: true, // 可编辑
    injectCSS: true, // 禁用默认css
    editorProps: {
        attributes: {
            class: 'ThinKing-Editor',
        },
    },
    extensions: [ // 扩展
        Document,
        Paragraph,
        Text,
        Color,
        TextStyle,
        BubbleMenu, // 浮动菜单
        Placeholder.configure({
            placeholder: "创作任何内容，或者按'/'输入命令...",
        }),
        Dropcursor.configure({
            width: 2,
            class: 'ThinKing-Dropcursor',
            color: '#464CEC',
        }),
        Heading.configure({
            HTMLAttributes: {
                class: 'ThinKing-Heading',
            },
            levels: [1, 2, 3, 4, 5, 6],
        }),
        CharacterCount.configure({
            limit: setting.value.limit,
        }),
        History.configure({
            depth: setting.value.History,
        }),
        Commands.configure({
            suggestion,
        }),
        Mention.configure({
            suggestion: MentionListSuggestion,
        }),
    ],
    onUpdate: ({ editor }) => {
        console.log("更新了");

        contentData.value = editor.getHTML();
        console.log(editor.getHTML());
    },
})

onBeforeUnmount(() => {
    try {
        if (editor) {
            // 通过其他方式进行清理
            editor.setOptions({ content: '' });
            editor.isDestroyed = true;
            console.log("编辑器已被清理");
        }
    } catch (error) {
        console.error("清理编辑器时发生错误:", error);
    }
});

</script>

<style scoped lang='scss'>
.ThinKing-Editor-Box {
    padding: 0.5rem 0;

    // 为空的提示
    .EmptyPrompt {
        display: flex;
        justify-content: center;
        position: absolute;
        left: 0;
        right: 0;
        bottom: 3rem;
        margin: auto;
    }
}
</style>