import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useEditorPageStore = defineStore('useEditorPageStore', () => {
    // 笔记设置
    const setting = ref({
        limit: 100000, // 允许的最大字符数
        history: 20, // 允许最大的撤销数量
    });

    const isEditable = ref(false); // 是否只读

    // 编辑器实例
    const editor = ref({});

    // 笔记内容
    const content = ref({});

    // 目录
    const catalog = ref([]);
    // 目录转换的树形结构
    const treeData = ref([]);

    return {
        setting,
        editor,
        content,
        catalog,
        treeData,
        isEditable
    };
});