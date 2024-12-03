import { VueRenderer } from '@tiptap/vue-3'
import tippy from 'tippy.js'

import CommandsList from './index.vue'

import { markRaw } from 'vue';
import { TextCaseTitle16Regular, TextHeader124Filled, TextHeader224Filled, TextHeader320Filled, Table24Regular, AppsList20Filled, TextNumberListLtr20Filled, AppsList20Regular, Code24Filled, EmojiSparkle24Regular, LineHorizontal120Filled, TextQuote20Filled, Mention20Filled } from '@vicons/fluent'
// 使用 markRaw 来标记组件
const TextCaseTitle16RegularIcon = markRaw(TextCaseTitle16Regular);
const TextHeader124FilledIcon = markRaw(TextHeader124Filled);
const TextHeader224FilledIcon = markRaw(TextHeader224Filled);
const TextHeader320FilledIcon = markRaw(TextHeader320Filled);
const Table24RegularIcon = markRaw(Table24Regular);
const AppsList20FilledIcon = markRaw(AppsList20Filled);
const TextNumberListLtr20FilledIcon = markRaw(TextNumberListLtr20Filled);
const AppsList20RegularIcon = markRaw(AppsList20Regular);
const Code24FilledIcon = markRaw(Code24Filled);
const EmojiSparkle24RegularIcon = markRaw(EmojiSparkle24Regular);
const LineHorizontal120FilledIcon = markRaw(LineHorizontal120Filled);
const TextQuote20FilledIcon = markRaw(TextQuote20Filled);
const Mention20FilledIcon = markRaw(Mention20Filled);

export default {
  items: ({ query }) => {
    return [
      {
        title: '文本',
        describe: '从纯文本开始编写',
        icon: TextCaseTitle16RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setNode('heading', { level: 1 })
            .run()
        },
      },
      {
        title: '标题1',
        describe: '大标题',
        icon: TextHeader124FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setNode('heading', { level: 1 })
            .run()
        },
      },
      {
        title: '标题2',
        describe: '大标题',
        icon: TextHeader224FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setNode('heading', { level: 2 })
            .run()
        },
      },
      {
        title: '标题3',
        describe: '小标题',
        icon: TextHeader320FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setNode('heading', { level: 3 })
            .run()
        },
      },
      {
        title: '表格',
        describe: '添加一个简易的内容表格',
        icon: Table24RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('bold')
            .run()
        },
      },
      {
        title: '代办清单',
        describe: '使用代办清单',
        icon: AppsList20RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '项目符号列表',
        describe: '创建一个简易的项目符号列表',
        icon: AppsList20FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '有序列表',
        describe: '创建一个带序号的列表',
        icon: TextNumberListLtr20FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '代码',
        describe: '高亮显示代码',
        icon: Code24FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '表情',
        describe: '插入到文本中的表情符号',
        icon: EmojiSparkle24RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '折叠列表',
        describe: '折叠列表可以选择性隐藏或显示内容内容',
        icon: TextCaseTitle16RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '引用',
        describe: '摘取引用',
        icon: TextQuote20FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '分隔性',
        describe: '在视觉上创建分隔',
        icon: LineHorizontal120FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '标注',
        describe: '将文字加强突出',
        icon: TextCaseTitle16RegularIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      },
      {
        title: '提及',
        describe: '使用事件',
        icon: Mention20FilledIcon,
        command: ({ editor, range }) => {
          editor
            .chain()
            .focus()
            .deleteRange(range)
            .setMark('italic')
            .run()
        },
      }
    ].filter(item => item.title.toLowerCase().startsWith(query.toLowerCase())).slice(0, 10)
  },

  render: () => {
    let component
    let popup

    return {
      onStart: props => {
        component = new VueRenderer(CommandsList, {
          // using vue 2:
          // parent: this,
          // propsData: props,
          props,
          editor: props.editor,
        })

        if (!props.clientRect) {
          return
        }

        popup = tippy('body', {
          getReferenceClientRect: props.clientRect,
          appendTo: () => document.body,
          content: component.element,
          showOnCreate: true,
          interactive: true,
          trigger: 'manual',
          placement: 'bottom-start',
        })
      },

      onUpdate(props) {
        component.updateProps(props)

        if (!props.clientRect) {
          return
        }

        popup[0].setProps({
          getReferenceClientRect: props.clientRect,
        })
      },

      onKeyDown(props) {
        if (props.event.key === 'Escape') {
          popup[0].hide()

          return true
        }

        return component.ref?.onKeyDown(props)
      },

      onExit() {
        popup[0].destroy()
        component.destroy()
      },
    }
  },
}