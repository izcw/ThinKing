<template>
    <div class="homePage">
        <div class="herder-top">
            <herderBox />
        </div>
        <div class="container" style="margin-top: 72px;">
            <router-view></router-view>
        </div>
        <div class="container">
            <footerBox />
        </div>
    </div>
</template>
<script setup>
import herderBox from "./components/herder.vue";
import footerBox from "./components/footer.vue";
</script>
<style scoped lang='scss'>
.homePage {
    width: 100%;
    padding: 0 1.5rem;
    box-sizing: border-box;
}

.container {
    width: 1200px;
    margin: 0 auto;
}

.herder-top {
    width: 100%;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 999;
    background-color: #fff;
}
</style>
