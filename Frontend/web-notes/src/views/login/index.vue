<template>
    <div class="login">
        <div class="header">
            <div>
                NexNote
            </div>
            <div>
                下载
                进入官网
                帮助中心
            </div>
        </div>
        <div class="login-box">
            <main>
                <h2>登录/注册 NexNote</h2>
                <input type="text" name="" id="">
                <router-link to="/Yoko"><button>登录</button></router-link> 
                <div class="thirdParty">
                    qq,微信
                </div>
            </main>
        </div>
        <div class="footer">
            隐私政策
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.login {
    width: 100%;
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .header {
        padding: 1rem;
        background-color: antiquewhite;
    }

    .login-box {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;

        main {
            width: 300px;
            height: 300px;
            background-color: aqua;
        }
    }

    .footer {
        padding: 1rem;
        background-color: antiquewhite;
    }
}
</style>
