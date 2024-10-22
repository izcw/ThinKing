<template>
    <div class="space text-select GMargin">
        <div class="space-item active">
            <img class="ban-drag" src="@/assets/book1.png" alt="">
            <p>Yoko</p>
        </div>
        <div class="space-item">
            <img class="ban-drag" src="@/assets/book2.png" alt="">
            <p>Yoko</p>
        </div>
        <div class="space-item">
            <img class="ban-drag" src="@/assets/book3.png" alt="">
            <n-ellipsis style="max-width: 100%">
                <span>JavaScript</span>
            </n-ellipsis>
        </div>

    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.space {
    width: 100%;
    display: flex;
    position: absolute;
    bottom: 0;
    background-color: #fff;
    padding-top: 10px;
    padding-bottom: 10px;

    .space-item {
        width: 40px;
        height: 60px;
        // background-color: #666;
        box-sizing: border-box;
        display: flex;
        align-items: flex-end;
        justify-content: center;
        cursor: pointer;
        margin-right: 10px;
        position: relative;

        p,span {
            font-size: 12px;
            color: #666;
        }

        img {
            position: absolute;
            bottom: 20px;
            left: 0;
            right: 0;
            margin: 0 auto;
            width: 30px;
            height: 35px;
            transform: scale(0.8);
            filter: grayscale(70%);
            opacity: 0.7;
        }
    }

    .space-item:hover img,
    .space-item:active img {
        animation: SpaceImgAnimation 0.3s forwards;
    }

    .space-item.active img {
        animation: SpaceImgAnimation forwards;
    }
}


@keyframes SpaceImgAnimation {
    0% {
        // height: 30px;
    }

    100% {
        // height: 35px;
        filter: grayscale(0%);
        opacity: 1;
    }

}
</style>
