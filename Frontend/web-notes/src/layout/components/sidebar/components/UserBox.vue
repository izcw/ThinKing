<template>
    <div class="header-wrapper GMargin">
        <div class="logo-box">
            <div class="logo">
                <img src="/src/assets/logo.png" alt="">
                <span>Yoko</span>
            </div>
            <n-tooltip placement="bottom" trigger="hover">
                <template #trigger>
                    <div class="Tools-item">
                        <n-icon size="20">
                            <ChevronDoubleLeft16Filled />
                        </n-icon>
                    </div>
                </template>
                <span>收起闭侧边栏 Ctrl+\</span>
            </n-tooltip>
        </div>
    </div>
</template>
<script setup>
import { ChevronDoubleLeft16Filled } from '@vicons/fluent'
</script>
<style scoped lang='scss'>
.header-wrapper {
    padding-top: 10px;
    margin-bottom: 1.5rem;
}

.logo-box {
    display: flex;
    align-items: center;
    justify-content: space-between;

    .logo {
        display: flex;
        align-items: center;

        img {
            width: 30px;
        }

        span {
            margin-left: 10px;
            font-size: 14px;
            color: #333;
        }
    }
}
</style>