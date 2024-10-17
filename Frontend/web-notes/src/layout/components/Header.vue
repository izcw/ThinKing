<template>
    <div class="header-wrapper">
        <div class="logo-box">
            <div class="logo">
                <n-avatar round size="small" src="/src/assets/semi-logo.svg" />
                NexNote
            </div>
            <Icon class="fold">
                <AngleDoubleLeft />
            </Icon>
        </div>

        <div>

        </div>
    </div>
</template>
<script setup>
import { Icon } from '@vicons/utils'
import { Carrot, AngleDoubleLeft } from '@vicons/fa'
</script>
<style scoped lang='scss'>
.header-wrapper {
    margin-bottom: 2rem
}

.logo-box {
    display: flex;
    align-items: center;
    justify-content: space-between;

    .logo {
        display: flex;
        align-items: center;

        span {
            margin-right: 10px;
        }
    }

    .fold {
        font-size: 20px;
        color: #666;
        cursor: pointer;
        padding: 4px;
        border-radius: 4px;
    }

    .fold:hover {
        background-color: #EFEFED;
    }
}
</style>