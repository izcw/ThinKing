<template>
    <div class="collect GMargin">
        <n-grid cols="3 300:4 400:5 500:6 600:7" :y-gap="8" style="justify-items: center;">
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <n-icon size="20">
                        <Home48Regular />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <n-icon size="20">
                        <Search28Filled />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <n-icon size="20">
                        <BellRegular />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <!-- <img src="@/assets/logo.png" alt=""> -->
                    🐸
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <!-- <img src="@/assets/logo.png" alt=""> -->
                    🐥
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <img src="@/assets/logo.png" alt="">
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <img src="@/assets/logo.png" alt="">
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <img src="@/assets/logo.png" alt="">
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
            <n-grid-item style="width: 100%;">
                <div class="Tools-item item">
                    <img src="@/assets/logo.png" alt="">
                    <n-icon size="10" color="#F6C050cc" style="position: absolute;top: 4px;left: 4px;">
                        <Star />
                    </n-icon>
                </div>
            </n-grid-item>
        </n-grid>
    </div>
</template>
<script setup>
import { Home48Regular, Search28Filled } from '@vicons/fluent'
import { BellRegular, Star } from '@vicons/fa'
</script>
<style scoped lang='scss'>
.collect {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 1.5rem;
}

.item {
    position: relative;
    width: calc(100% - 10px);
    height: 40px;
    background-color: #EFEFED;
    margin: 0 auto;

    img {
        width: 15px;
        height: 15px;
    }
}

.item:hover,
.item:active {
    background-color: #EBEBEB;
}
</style>
