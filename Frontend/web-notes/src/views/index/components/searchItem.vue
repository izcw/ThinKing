<template>
    <div class="searchItem text-select">
        <p v-if="data"><el-text class="mx-1" type="primary">搜索</el-text></p>
        <img class="logo" src="@/assets/images/logo.png" alt="">
    </div>
</template>
<script setup>
import {ref} from 'vue'
let data = ref()
</script>
<style scoped lang='scss'>
.searchItem {
    width: 100%;
    min-height: 450px;
    margin-bottom: 2rem;
    position: relative;

    .logo{
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        margin: auto;
        width: 100px;
        height: 100px;
        opacity: 0.1;
        filter: grayscale(100%);
    }
}
</style>

