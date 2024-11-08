<template>
    <div class="header-wrapper GMargin">
        <div class="logo-box">
            <div class="logo">
                <router-link to="/login">
                    <img :src="API_BASE_URL+'/images/avatar-default.png'" alt="">
                    <span>Yoko</span>
                </router-link>
            </div>
            <n-tooltip placement="bottom" trigger="hover">
                <template #trigger>
                    <div class="Tools-item" @click="toggleSidebarStatus">
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
import { inject } from 'vue';
import { RouterLink, RouterView } from 'vue-router'
import { ChevronDoubleLeft16Filled } from '@vicons/fluent'
import {API_BASE_URL} from "@/config/setting"

// 展开关闭侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus'); // 注入父组件的状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};
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