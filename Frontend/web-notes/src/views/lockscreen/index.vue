<template>
    <div class="lock-screen">
        <div class="background">
            <div class="lockbox">
                <div class="mask" :class="{ blurred: isInputFocused }"></div>
                <div class="centent">
                    <div class="Unlockbox">
                        <div class="timeBox" :style="{ 'opacity': isInputFocused == true ? 0.2 : 1 }">
                            17:07
                        </div>
                        <img src="@/assets/images/noteback.jpg" alt="">
                        <div>
                            <el-input v-model="lockPassword" style="width: 200px" size="large" type="password"
                                show-password placeholder="输入PIN码解锁" @focus="handleFocus(true)"
                                @blur="handleFocus(false)" @keyup.enter="handleEnter" autofocus />
                            <div class="other">
                                <p @click="gologin">其它账号</p>
                                <p @click="centerDialogVisible = true">忘记密码？</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="logo" :style="{ 'z-index': isInputFocused == true ? 1 : 200 }">
            <img src="@/assets/images/logo.png" alt="">
        </div>
    </div>

    <el-dialog v-model="centerDialogVisible" class="HideTitle" width="400" align-center :show-close="false">
        <div style="padding: 3rem;box-sizing: border-box">
            <el-form :model="form" label-width="auto" style="max-width: 600px">
                <el-form-item label="账号">
                    <el-input v-model="input" style="width: 100%" placeholder="请输入账号" />

                </el-form-item>
                <el-form-item label="验证码">
                    <el-input v-model="input" placeholder="请输入验证码">
                        <template #append>
                            <el-button>获取验证码</el-button>
                        </template>
                    </el-input>
                </el-form-item>
            </el-form>
        </div>
    </el-dialog>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
const router = useRouter();
const centerDialogVisible = ref(false)

let gologin = () => {
    router.push({ name: 'login' })
}

// PIN码
let lockPassword = ref("");
// 输入框是否聚焦
let isInputFocused = ref(false);

// 处理焦点状态
const handleFocus = (focused) => {
    isInputFocused.value = focused;
};

// 处理回车事件
const handleEnter = () => {
    console.log("回车了");
};
</script>

<style scoped lang="scss">
/* 锁屏容器 */
.lock-screen {
    position: relative;
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    background-color: #fff;

    /* 背景图片容器 */
    .background {
        position: absolute;
        width: 100%;
        height: 100%;
        background-image: url('@/assets/images/logo-lock.png');
        background-size: 150px 150px;
        background-repeat: repeat;
        background-position: 0 0;
        animation: seamlessScroll 5s linear infinite;
    }
}

/* 背景滚动动画 */
@keyframes seamlessScroll {
    0% {
        background-position: 0 0;
    }

    100% {
        background-position: -150px 150px;
    }
}

// 底部logo
.logo {
    position: fixed;
    width: 100%;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 200;
    margin: auto;
    display: flex;
    justify-content: center;

    img {
        margin: 30px 1rem;
        width: 50px;
        cursor: pointer;
    }
}

/* 遮罩层 */
.mask {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 20;
    transition: backdrop-filter 0.3s ease;

    /* 模糊效果 */
    &.blurred {
        backdrop-filter: blur(4px) !important;
    }
}

.centent {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 100;
    display: flex;
    align-items: center;
    justify-content: center;

    .timeBox {
        font-size: 46px;
        font-weight: bold;
        margin-bottom: 100px;
        color: #bbb;
        transition: all 0.3s ease;
    }

    .Unlockbox {
        display: flex;
        flex-direction: column;
        align-items: center;

        .other {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            font-size: 12px;
            color: #666;
            cursor: pointer;
        }

        img {
            width: 90px;
            height: 90px;
            background-color: #E9E8ED;
            border-radius: 50%;
            margin-bottom: 1.5rem;
        }
    }
}
</style>
