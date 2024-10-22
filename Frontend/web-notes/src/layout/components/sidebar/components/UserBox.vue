<template>
    <div class="header-wrapper">
        <div class="logo-box">
            <div class="logo">
                <img src="/src/assets/logo.png" alt="">
                <span>Yoko</span>
            </div>
            <n-tooltip placement="bottom" trigger="hover">
                <template #trigger>
                    <div class="Tools-item">
                        <n-icon size="20">
                            <AngleDoubleLeft />
                        </n-icon>
                    </div>
                </template>
                <span>收起闭侧边栏 Ctrl+\</span>
            </n-tooltip>
        </div>
    </div>
</template>
<script setup>
import { Icon } from '@vicons/utils'
import { Carrot, AngleDoubleLeft } from '@vicons/fa'
</script>
<style scoped lang='scss'>
.header-wrapper {
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