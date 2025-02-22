<template>
    <div class="ThinKing-Editor-Box" @keydown="handleKeydown" tabindex="0">
        <!-- <div>
            <el-button v-if="editor" @click="editor.chain().focus().undo().run()" :disabled="!editor.can().undo()">
                撤销
            </el-button>
            <el-button v-if="editor" @click="editor.chain().focus().redo().run()" :disabled="!editor.can().redo()">
                前进
            </el-button>
        </div> -->
        <!-- 编辑器 -->
        <editor-content :editor="editor" :class="{
            'ContentEmpty': StorePage.isContentEmpty, 'font-serif': StorePage.pageData.font == 'serif', 'font-monospace': StorePage.pageData.font == 'monospace',
            'font-size-12': StorePage.pageData.size == '12',
            'font-size-14': StorePage.pageData.size == '14',
            'font-size-16': StorePage.pageData.size == '16',
            'font-size-18': StorePage.pageData.size == '18'
        }" />

        <!-- 浮动菜单 -->
        <bubbleMenuBox v-if="editor" :editor="editor" />

        <!-- 为空时显示 -->
        <div v-show="StorePage.isContentEmpty" class="EmptyPrompt">
            <el-button v-if="editor" @click="editor.chain().focus().toggleHeading({ level: 1 }).run()" size="small">
                标题H1
            </el-button>
            <el-button v-if="editor"
                @click="editor.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run()"
                size="small">
                表格
            </el-button>
            <el-button v-if="editor" @click=editor.chain().focus().toggleTaskList().run() size="small">
                清单列表
            </el-button>
        </div>

        <!-- 字符数 -->
        <div v-show="!StorePage.isContentEmpty" class="Editor-footer">
            <NumberWordsBox v-if="editor" :editor="editor" :setting="store.setting" />
        </div>
    </div>
</template>

<script setup>
import { ref, onBeforeUnmount, onMounted } from 'vue'
import { update } from '@/api/note/index.js'
import './components/css/style.scss'
import { ElButton } from 'element-plus'
import 'element-plus/dist/index.css'
import { ElMessage } from 'element-plus';
import bubbleMenuBox from './components/bubbleMenu/index.vue'
import NumberWordsBox from './components/NumberWords/index.vue'
import { useEditor, EditorContent, BubbleMenu, VueNodeViewRenderer } from '@tiptap/vue-3'
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
import History from '@tiptap/extension-history' // 撤销和重做
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
// 节点
import Blockquote from '@tiptap/extension-blockquote' // 引用
import ListItem from '@tiptap/extension-list-item' // 符号列表
import OrderedList from '@tiptap/extension-ordered-list' // 有序列表
import BulletList from '@tiptap/extension-bullet-list'
import CodeBlock from '@tiptap/extension-code-block'// 代码
import CodeBlockLowlight from '@tiptap/extension-code-block-lowlight' // 代码高亮
import { all, createLowlight } from 'lowlight'
import CodeBlockComponent from './components/CodeBlockComponent/index.vue'
const lowlight = createLowlight(all)

import HardBreak from '@tiptap/extension-hard-break' // 空格
import HorizontalRule from '@tiptap/extension-horizontal-rule' // 水平线

import Image from '@tiptap/extension-image' // 图片

// 表格
import Gapcursor from '@tiptap/extension-gapcursor'
import Table from '@tiptap/extension-table'
import TableCell from '@tiptap/extension-table-cell'
import TableHeader from '@tiptap/extension-table-header'
import TableRow from '@tiptap/extension-table-row'

// 任务项
import TaskItem from '@tiptap/extension-task-item'
import TaskList from '@tiptap/extension-task-list'


// 离线支持
// import { createYDoc, initYjsStore, fetchServerData, updateServerData } from '@/utils/yjsSync'

// 将Editor对象放入状态管理
import { useEditorPageStore } from '@/stores/EditorPage'
const store = useEditorPageStore()

import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()


//为Y文档的本地存储设置IndexedDB
// 在组件加载时同步数据
// onMounted(async () => {
//     // 尝试从服务器获取数据并初始化
//     const serverData = await fetchServerData()
//     if (serverData) {
//         StorePage.pageData = serverData.content
//     }

//     // 启动数据同步
//     provider.connect()
// })

// // 在组件卸载时关闭 Yjs 连接
// onBeforeUnmount(() => {
//     provider.disconnect()
// })

const editor = useEditor({
    content: StorePage.pageData.content,
    autofocus: false, // 自动焦点
    editable: StorePage.pageData.readonly == '0' ? true : false, // 可编辑
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
        Image.configure({
            allowBase64: true, // 允许将图像解析为base64字符串<img src="data:image/jpg;base64...">
        }),
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
        History.configure({
            depth: store.setting.History,
        }),
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
        }),
        Blockquote,
        BulletList,
        OrderedList,
        ListItem,
        CodeBlock,
        CodeBlockLowlight
            .extend({
                addNodeView() {
                    return VueNodeViewRenderer(CodeBlockComponent)
                },
            })
            .configure({ lowlight }),
        HardBreak,
        HorizontalRule,
        Gapcursor,
        Table.configure({
            resizable: true,
        }),
        TableRow,
        TableHeader,
        TableCell,
        TaskList,
        TaskItem.configure({
            nested: true,
        })
    ],
    onUpdate: ({ editor }) => {
        updateContent(editor.getJSON());
        // console.log("更新内容");
        // console.log(StorePage.pageData.content);
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



// Ctrl + S 事件处理函数（Windows/Linux: Ctrl, macOS: Cmd）
const handleKeydown = (event) => {
    // 判断 Ctrl + S 或 Cmd + S
    if ((event.ctrlKey || event.metaKey) && event.key === 's') {
        event.preventDefault(); // 阻止浏览器默认的保存行为
        console.log('Ctrl + S 或 Cmd + S 被按下');
        updateContent(editor.value.getJSON()); // 更新内容
        // ElMessage({
        //         message: '保存成功',
        //         type: 'success',
        //     });
    }
};

// 键盘松开事件处理函数
// const handleKeyup = (event) => {
//     // 判断 Ctrl + S 或 Cmd + S 松开
//     if ((event.ctrlKey || event.metaKey) && event.key === 's') {
//         event.preventDefault(); // 阻止默认的保存行为

//         // 执行保存逻辑
//         if (editor) {
//             updateContent(editor.value.getJSON()); // 更新内容
//             ElMessage({
//                 message: '保存成功',
//                 type: 'success',
//             });
//         }
//     }
// };

// 在组件挂载时添加事件监听
onMounted(() => {
    // 监听容器内的键盘事件
    const editorBox = document.querySelector('.ThinKing-Editor-Box');
    // editorBox.addEventListener('keyup', handleKeyup);
    editorBox.addEventListener('keydown', handleKeydown);
});

// 在组件卸载时移除事件监听
onBeforeUnmount(() => {
    const editorBox = document.querySelector('.ThinKing-Editor-Box');
    // editorBox.removeEventListener('keyup', handleKeyup);
    editorBox.removeEventListener('keydown', handleKeydown);
});


// 更新数据
let updateContent = (val) => {
    update({ pageId: StorePage.pageData.pageId, content: val }).then((data) => {
        console.log("修改成功", data);
        StorePage.pageData = data
    }).catch((e) => {
        console.error('修改失败', e);
    });
}
</script>

<style scoped lang='scss'>
.ThinKing-Editor-Box {
    width: 100%;
    height: 100%;
    padding: 0.5rem 0;
    box-sizing: border-box;
    position: relative;

    // 为空的提示
    .EmptyPrompt {
        display: flex;
        justify-content: center;
        position: absolute;
        left: 0;
        right: 0;
        bottom: 3rem;
        margin: auto;
        // width: 140px;


        position: absolute;
        bottom: 1rem;
        left: 0;
        right: 0;
        margin: auto;
    }

    .Editor-footer {
        margin-top: 1rem;
        border-top: 1px solid #eee;
        padding: 1rem 0;
        box-sizing: border-box;
    }
}
</style>