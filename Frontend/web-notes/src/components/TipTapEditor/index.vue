<template>
    <div class="ThinKing-Editor-Box">
        <a href="#dffa9fc4-36d1-4871-b9c6-9ac45f8fffc2">目</a>
        <!-- 目录 -->
        <div class="sidebar">
            <div class="sidebar-options">
                <div class="label-large">目录</div>
                <div class="table-of-contents">
                    <template v-if="editor">
                        <ToC :editor="editor" :items="pageData.catalog" />
                    </template>
                </div>
            </div>
        </div>
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
        <div v-if="pageData.content.length == null || pageData.content == '<p></p>'" class="EmptyPrompt">
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
        <h1 id="dffa9fc4-36d1-4871-b9c6-9ac45f8fffc2">第三方</h1>
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
import { getHierarchicalIndexes, TableOfContents } from '@tiptap-pro/extension-table-of-contents' // 目录
import ToC from './components/TableOfContents/index.vue'
import Highlight from '@tiptap/extension-highlight' // 强调高亮标记
import Bold from '@tiptap/extension-bold' // 加粗
import Italic from '@tiptap/extension-italic' // 斜体
import Strike from '@tiptap/extension-strike' // 删除线
import Underline from '@tiptap/extension-underline' // 下划线
import Code from '@tiptap/extension-code' // 标记为代码
import Link from '@tiptap/extension-link' // 链接
import Subscript from '@tiptap/extension-subscript' // 下标
import Superscript from '@tiptap/extension-superscript' // 上标


// 配置
let setting = ref(
    {
        limit: 100000, // 允许的最大字符数
        History: 20, // 允许最大的撤销数量
    }
)

// 页面数据、目录
let pageData = ref({
    content: `<h2>第一章</h2><p>有一点值得注意的是，类似于notion，obsdian复杂的笔记软件，使用难道高，学习成本大。flomo，iNote，备忘录📝软件，仅适合记录灵感，不适用于复杂的场景。传统的笔记例如有道云笔记，印象笔记，适合一些长期使用且不需要复杂功能的人群，因为它的笔记管理比较传统老套，以上所述涵盖三种类型，新型笔记双向链接、block。快速笔记灵感笔记。长期笔记，传统记法。</p><h3>实话实说</h3>`,
    catalog: []
})

const editor = useEditor({
    content: pageData.value.content,
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
        TableOfContents.configure({
            getIndex: getHierarchicalIndexes,
            onUpdate: content => {
                pageData.value.catalog = content
            }
        })
    ],
    onUpdate: ({ editor }) => {
        console.log("更新了");

        pageData.value.content = editor.getHTML();
        // console.log(editor.getHTML());
    },
})

// onBeforeUnmount(() => {
//     try {
//         if (editor) {
//             // 通过其他方式进行清理
//             editor.setOptions({ content: '' });
//             editor.isDestroyed = true;
//             console.log("编辑器已被清理");
//         }
//     } catch (error) {
//         console.error("清理编辑器时发生错误:", error);
//     }
// });
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