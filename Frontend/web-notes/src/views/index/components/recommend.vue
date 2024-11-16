<template>
    <div class="recommend text-select">
        <p><el-text class="mx-1" type="primary">推荐</el-text></p>
        <div class="content">
            <div class="item">
                <p class="time">7天前</p>
                <p class="title"><el-text truncated>人士需要浮士德精神</el-text></p>
            </div>
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.recommend {
    width: 100%;
    height: 300px;

    .content {

        .item {
            margin: 1rem 0;
            width: 100%;
            height: 250px;
            background-image: url("@/assets/images/recommend-item1.png");
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;

            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 2rem;
            box-sizing: border-box;

            .time {
                font-size: 14px;
                color: #fff;
            }

            .title span{
                padding: 1rem 0;
                font-size: 26px;
                color: #fff;
            }
        }
    }
}
</style>
