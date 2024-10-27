<template>
    <div class="PageHeader">
        <leftToolsBox />
        <rightToolsBox v-if="!isTemplateRoute" />
    </div>
</template>

<script setup>
import { watch } from 'vue'
import { useRoute } from 'vue-router';
import { ref } from 'vue';
import leftToolsBox from './components/leftTools.vue';
import rightToolsBox from './components/rightTools.vue';

const route = useRoute();
const isTemplateRoute = ref(false);

// 监听路由变化
watch(() => route.path, (newPath) => {
    console.log(newPath);
    
    detectionRightTools(newPath)
});

// 初始检测
let detectionRightTools = (routepath) => {
    // isTemplateRoute.value = /\/template$/.test(routepath);
    isTemplateRoute.value = /^\/[^/]+\/template$/.test(routepath);
}
detectionRightTools(route.path)
</script>

<style scoped lang='scss'>
.PageHeader {
    padding: 0 6px;
    box-sizing: border-box;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
</style>
