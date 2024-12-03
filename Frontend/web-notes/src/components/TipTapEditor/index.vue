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
        <div v-if="store.content.length == null || store.content == '<p></p>'" class="EmptyPrompt">
            <el-button v-if="editor">
                表格
            </el-button>
            <el-button v-if="editor">
                列表
            </el-button>
        </div>

        <!-- 字符数 -->
        <div v-else>
            <NumberWordsBox v-if="editor" :editor="editor" :setting="store.setting" />
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
import { Editor } from '@tiptap/core'
import Document from '@tiptap/extension-document'
import Paragraph from '@tiptap/extension-paragraph'
import Text from '@tiptap/extension-text'
import Heading from '@tiptap/extension-heading' // 标题
import CharacterCount from '@tiptap/extension-character-count' // 字符数
import { Color } from '@tiptap/extension-color' // 字体颜色
import TextStyle from '@tiptap/extension-text-style'
import Dropcursor from '@tiptap/extension-dropcursor' // 拖动显示的条
import Placeholder from '@tiptap/extension-placeholder' // 占位符提示
// import History from '@tiptap/extension-history' // 撤销和重做
import Commands from './components/SlashCommands/commands' // 斜线命令
import CommandsSuggestion from './components/SlashCommands/suggestion.js'
import Mention from '@tiptap/extension-mention' // 提及
import MentionListSuggestion from './components/MentionList/suggestion'
import { getHierarchicalIndexes, TableOfContents } from '@tiptap-pro/extension-table-of-contents' // 目录
import Highlight from '@tiptap/extension-highlight' // 强调高亮标记
import Bold from '@tiptap/extension-bold' // 加粗
import Italic from '@tiptap/extension-italic' // 斜体
import Strike from '@tiptap/extension-strike' // 删除线
import Underline from '@tiptap/extension-underline' // 下划线
import Code from '@tiptap/extension-code' // 标记为代码
import Link from '@tiptap/extension-link' // 链接
import Subscript from '@tiptap/extension-subscript' // 下标
import Superscript from '@tiptap/extension-superscript' // 上标
// 离线支持
import { createYDoc, initYjsStore, fetchServerData, updateServerData } from '@/utils/yjsSync'

// 将Editor对象放入状态管理
import { useEditorPageStore } from '@/stores/EditorPage'
const store = useEditorPageStore()


//为Y文档的本地存储设置IndexedDB
// 在组件加载时同步数据
// onMounted(async () => {
//     // 尝试从服务器获取数据并初始化
//     const serverData = await fetchServerData()
//     if (serverData) {
//         store.content = serverData.content
//     }

//     // 启动数据同步
//     provider.connect()
// })

// // 在组件卸载时关闭 Yjs 连接
// onBeforeUnmount(() => {
//     provider.disconnect()
// })


const editor = useEditor({
    content: store.content,
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
        Bold,
        Italic,
        Strike,
        Underline,
        Code,
        Link.configure({
            openOnClick: true,
            defaultProtocol: 'https',
        }),
        Subscript,
        Superscript,
        Color,
        TextStyle,
        Highlight.configure({
            multicolor: true,
            multicolor: true,
        }),
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
            limit: store.setting.limit,
        }),
        // History.configure({
        //     depth: store.setting.History,
        // }),
        Commands.configure({
            suggestion: CommandsSuggestion
        }),
        Mention.configure({
            suggestion: MentionListSuggestion,
        }),
        TableOfContents.configure({
            getIndex: getHierarchicalIndexes,
            onUpdate: content => {
                store.catalog = content
            }
        })
    ],
    onUpdate: ({ editor }) => {
        store.content = editor.getHTML();
    },
})

onMounted(() => {
    store.editor = editor
})

onBeforeUnmount(() => {
    if (editor) {
        editor.destroy
        console.log("卸载编辑器成功");
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