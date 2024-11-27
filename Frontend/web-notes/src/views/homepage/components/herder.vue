<template>
    <header>
        <router-link to="/home">
            <div class="logo">
                <img src="@/assets/images/logo.png" alt="">
                <p>ThinKing</p>
            </div>
        </router-link>
        <div class="link">
            <div class="item">
                <router-link to="/">首页</router-link>
            </div>
            <div class="separate">|</div>
            <div class="item">
                <router-link to="/login">登录</router-link>
            </div>
            <div class="item">
                <router-link to="/register">注册</router-link>
            </div>
        </div>
    </header>
</template>
<script setup>

</script>
<style scoped lang='scss'>
header {
    width: 100%;
    padding:1rem 1.5rem;
    box-sizing: border-box;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #fff;
}

@media (max-width: 992px) {
    .link {
        display: none !important;
    }
}



.logo {
    display: flex;
    align-items: center;

    img {
        width: 40px;
    }

    p {
        font-size: 18px;
        font-weight: bold;
        margin-left: 10px;
        color: #000;
    }
}

.link {
    display: flex;
    align-items: center;

    .item {
        margin-left: 1.5rem;
    }

    .separate {
        margin-left: 1.5rem;
        color: #ccc;
    }

    a {
        color: #333;
        font-size: 16px;
    }
}

.link a:hover,.link a:active{
    color: #474ce3;
}
</style>
