import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useEditorPageStore = defineStore('useEditorPageStore', () => {
    // 笔记设置
    const setting = ref({
        limit: 100000, // 允许的最大字符数
        history: 20, // 允许最大的撤销数量
    });

    // 编辑器实例
    const editor = ref({});

    // 笔记内容
    const content = ref(`<h1>第一章</h1><p>pinia有一点值得注意的是，类似于notion，obsdian复杂的笔记软件，使用难道高，学习成本大。flomo，iNote，备忘录📝软件，仅适合记录灵感，不适用于复杂的场景。传统的笔记例如有道云笔记，印象笔记，适合一些长期使用且不需要复杂功能的人群，因为它的笔记管理比较传统老套，以上所述涵盖三种类型，新型笔记双向链接、block。快速笔记灵感笔记。长期笔记，传统记法。</p><h3>实话实说</h3><h1>第二章</h1><h2>2.1</h2><h1>第三章</h1><h2>3.1</h2><h5>3.1.1.1.1.1</h5>`);

    // 目录
    const catalog = ref([]);
    // 目录转换的树形结构
    const treeData = ref([]);

    return {
        setting,
        editor,
        content,
        catalog,
        treeData
    };
});