import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useSettingStore = defineStore('setting', () => {
  let TabsStatus = ref('tabP1') // 侧边工具栏的标签页; 默认为目录
  let switchTabsStatus = ref(false) // 点击悬浮球ai的状态
  
  return { TabsStatus,switchTabsStatus }
})
