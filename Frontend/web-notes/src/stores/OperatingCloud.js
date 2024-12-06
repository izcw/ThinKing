import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import { useRoute } from 'vue-router'

// 将操作同步

export const useOperatingcloudStore = defineStore('operatingcloud', () => {
    const route = useRoute();
    const noteId = route.params.noteId;

    let ThemeSpace = ref([
        {
            id: 1,
            name: "default",
            spaceTab: "#efefef",
            light: "#f7f7f7",
            dark: ""
        },
        {
            id: 2,
            name: "yellow",
            spaceTab: "#fff6df",
            light: "#fdfaf2",
            dark: ""
        },
        {
            id: 3,
            name: "purple",
            spaceTab: "#f9eeff",
            light: "#fdf9ff",
            dark: ""
        },
        {
            id: 4,
            name: "pink",
            spaceTab: "#ffefef",
            light: "#fffafd",
            dark: ""
        },
        {
            id: 5,
            name: "blue",
            spaceTab: "#edf4ff",
            light: "#f5f9ff",
            dark: ""
        },
        {
            id: 6,
            name: "green",
            spaceTab: "#e9fff1",
            light: "#f6fffe",
            dark: ""
        }
    ])

    let cloudData = ref({
        space: '',
        ThemeSpace: ThemeSpace.value[0],
        noteId: ''
    })

    return { cloudData, ThemeSpace }
})
