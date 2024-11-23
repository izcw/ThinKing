<template>
    <div class="header-wrapper GMargin">
        <div class="logo-box text-select">
            <div class="logo" ref="buttonRef" v-click-outside="onClickOutside">
                <img :src="API_BASE_URL + '/file_warehouse/images/avatar/default/avatar-default.png'" alt="Yoko">
                <span>Yoko</span>
            </div>

            <el-popover ref="popoverRef" :virtual-ref="buttonRef" trigger="click" :width="300" virtual-triggering>
                <div class="AccountBox">
                    <div class="logo">
                        <img :src="API_BASE_URL + '/file_warehouse/images/avatar/default/avatar-default.png'"
                            alt="Yoko">
                        <div class="info">
                            <p class="name">Yoko</p>
                            <p class="subscribe">免费版</p>
                        </div>
                    </div>
                    <el-divider />
                    <p @click="centerDialogVisible = true"><span>设置</span></p>
                    <p @click="LogOut"><span>退出登录</span></p>
                </div>
            </el-popover><!-- 弹出框 -->

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

        <el-dialog v-model="centerDialogVisible" width="1000" class="HideTitle" style="height:650px;" lign-center
            :show-close="false">
            <settingBox />
        </el-dialog><!-- 设置 -->
    </div>
</template>
<script setup>
import { ref, inject, onMounted, onBeforeUnmount } from 'vue';
import { RouterLink, RouterView } from 'vue-router'
import router from '@/router';
import { ChevronDoubleLeft16Filled } from '@vicons/fluent'
import { API_BASE_URL } from "@/config/setting"
import settingBox from "./setting/setting.vue"
import { removeToken } from '@/utils/token-util';

const centerDialogVisible = ref(false) // 设置对话框

// 弹出框
const buttonRef = ref()
const popoverRef = ref()
const onClickOutside = () => {
    unref(popoverRef).popperRef?.delayHide?.()
}


// 展开关闭侧边栏状态
const parentSidebarStatus = inject('parentSidebarStatus'); // 注入父组件的状态
const updateParentSidebarStatus = inject('updateParentSidebarStatus'); // 注入更新状态的方法
const toggleSidebarStatus = () => {
    updateParentSidebarStatus(!parentSidebarStatus.value);
};


// 退出登录
let LogOut = () => {
    removeToken()
    router.push('/login');
}
</script>
<style scoped lang='scss'>
.header-wrapper {
    padding-top: 10px;
    margin-bottom: 1.5rem;
}

.logo-box {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;

    .logo {
        width: 100%;
        padding: 4px 8px;
        box-sizing: border-box;
        border-radius: 4px;
        cursor: pointer;
        display: flex;
        align-items: center;

        img {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            border: 1px solid #eee;
        }

        span {
            margin-left: 10px;
            font-size: 14px;
            color: #333;
        }


    }

    .logo:hover,
    .logo:active {
        background-color: #E9E9E9;
    }
}

.AccountBox {
    p span {
        display: block;
        font-size: 14px;
        color: #999;
        width: 100%;
        padding: 4px 8px;
        box-sizing: border-box;
        border-radius: 4px;
        cursor: pointer;
    }

    p span:hover {
        background-color: #E9E9E9;
        color: #333;
    }

    .logo {
        display: flex;
        align-items: center;

        img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 1px solid #eee;
        }

        .info {
            margin-left: 10px;
            font-size: 14px;
            color: #333;

            .name {
                font-size: 16px;
            }

            .subscribe {
                color: #999;
            }
        }
    }
}
</style>