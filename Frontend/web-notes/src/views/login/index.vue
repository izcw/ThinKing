<template>
    <div class="login">
        <div class="header">
            <router-link to="/home">
                <div class="logo">
                    <img src="@images/logo.png" alt="">
                    ThinKing
                </div>
            </router-link>
            <div>
                <router-link to="/home">进入官网</router-link>
            </div>
        </div>
        <div class="login-box">
            <main>
                <router-view></router-view>
            </main>
        </div>
        <div class="footer">
            点击登录&nbsp;代表您同意&nbsp;<a href="">用户协议</a>&nbsp;和<a href="">隐私政策</a>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import loginFormBox from "./components/loginForm.vue"
import registerFormBox from "./components/registerForm.vue"

</script>
<style scoped lang='scss'>
.login {
    width: 100%;
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .header {
        padding: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 16px;

        a {
            color: #333;
            padding: 4px 8px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: bold;
            // font-family: 'SmileySans得意黑';

            img {
                width: 42px;
                height: 42px;
                margin-right: 6px;
            }
        }


    }

    .login-box {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;

        main {
            width: 300px;
            min-width: 300px;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;

            h2 {
                font-size: 26px;
            }
            
        }
    }

    .footer {
        padding: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: center;

        font-size: 12px;
        color: #666;

        a {
            color: #666;
            text-decoration: underline;
        }
    }
}
</style>
