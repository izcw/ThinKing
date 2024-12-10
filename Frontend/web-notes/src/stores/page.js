import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const usePageStore = defineStore('pagestore', () => {
    let pageData = ref(null) // 笔记数据
    let pageDataParent = ref([]) // 当前页的父级

    // 检测数据是否为空
    const isContentEmpty = computed(() => {
        if (pageData.value && pageData.value.content && pageData.value.content.content) {
            console.log("LLL");
            if (pageData.value.content.content.length <= 1) {
                return pageData.value.content.content[0].content === undefined
            }
            return false;
        }
        return true; // 如果 parsedContent 不存在或内容为空数组，也视为“空”
    })

    return { pageData, pageDataParent, isContentEmpty }
})
