<template>
    <div class="box">
        <div class="introduce">
            <div class="middle">
                <p class="title">简单记，深刻<span style="background-color: rgba(187, 214, 251,0.7);">思</span></p>
                <p class="Subtitle">让<span
                        style="background-color: rgba(248,216,73,0.7);padding: 0 4px; color:#000;">创意与思维</span>流畅连接，助你高效管理知识与灵感。
                </p>
                <router-link to="/login">
                    <div class="start">立即开始</div>
                </router-link>
            </div>
            <img src="@/assets/images/home1.png" alt="" class="bg">
        </div>

        <div class="show">
            <img src="@/assets/images/home2.png" alt="">
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.box {
    padding-top: 100px;
    display: flex;
    flex-direction: column;
    align-items: center;
    z-index: 10;

    .introduce {
        position: relative;
        width: 100%;
        height: 400px;

        .middle {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;

            .title {
                text-align: center;
                font-size: 50px;
                font-weight: bold;
                margin-bottom: 30px;
            }

            .Subtitle {
                text-align: center;
                font-size: 18px;
                color: #333;
            }
        }

        .bg {
            width: 600px;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
            z-index: -1;
        }

        @media (max-width: 992px) {
            .bg {
                width: 400px;
            }
        }

        .start {
            margin-top: 60px;
            width: 180px;
            text-align: center;
            padding: 10px 0;
            border-radius: 20px;
            background-color: #000;
            cursor: pointer;
            color: #fff;
        }

        .start:hover,
        .start:active {
            background-color: #474ce3;
        }
    }


    .show {
        width: 100%;
        height: auto;
        margin: 140px 0;
        // box-shadow: 0 0 5px #ccc;
        // background-image: url("@/assets/images/home2.png");
        // background-position: top;
        // background-repeat: no-repeat;
        // background-size: cover;
        overflow: hidden;

        img {
            width: 100%;
        }
    }

    // @media (max-width: 992px) {
    //     .show {
    //         height: auto;
    //     }
    // }
}
</style>
