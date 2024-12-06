import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const usePageStore = defineStore('pagestore', () => {
    let pageData = ref(null)

    return { pageData }
})
