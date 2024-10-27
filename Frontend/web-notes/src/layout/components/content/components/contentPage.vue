<template>
    <div class="contentPage GMargin"  contenteditable="true" spellcheck="true">
        <RouterView />
    </div>
</template>
<script setup>
import { RouterLink, RouterView } from 'vue-router'
// 点点
</script>
<style scoped lang='scss'>
.contentPage {
    width: 100%;
    margin-bottom: 100px
    // background-color: aqua;
}
</style>
