<template>
    <div class="homePage">
        <div class="container herder-top">
            <herderBox />
        </div>
        <div class="container" style="margin-top: 72px;">
            <box1Box />
        </div>
        <div class="container">
            <footerBox />
        </div>
    </div>
</template>
<script setup>
import herderBox from "./components/herder.vue";
import box1Box from "./components/box1.vue";
import footerBox from "./components/footer.vue";
</script>
<style scoped lang='scss'>
.homePage {
    width: 100%;
    height: 100%;
    padding: 0 1.5rem;
    box-sizing: border-box;
}

.container {
    width: 1200px;
    margin: 0 auto;
}

.herder-top {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    margin: auto;
    z-index: 9999;
}
</style>
