<template>
    <div class="blankPage">
        <div class="container">
            <div class="banner">

            </div>

            <div class="template">
                <div class="catalog">
df
                </div>
                <div class="content">
                    <el-row  :gutter="20">
                        <el-col :span="8">
                           <div class="item">
                            <img src="@/assets/images/template-item1.png" alt="">
                            <h2>会议记录</h2>
                            <p><el-text line-clamp="2">使用此会议记录模板可最大限度地提高会议效率使用此会议记录模板可最大限度地提高会议效率使用此会议记录模板可最大限度地提高会议效率</el-text></p>
                           </div>
                        </el-col>
                        <el-col :span="8">
                           <div class="item">
                            <img src="@/assets/images/template-item1.png" alt="">
                            <h2>会议记录</h2>
                            <p><el-text line-clamp="2">使用此会议记录模板可最大限度地提高会议效率使用此会议记录模板可最大限度地提高会议效率使用此会议记录模板可最大限度地提高会议效率</el-text></p>
                           </div>
                        </el-col>
                        <el-col :span="8">
                           <div class="item">
                            <img src="@/assets/images/template-item1.png" alt="">
                            <h2>会议记录</h2>
                            <p><el-text line-clamp="2">哈哈哈</el-text></p>
                           </div>
                        </el-col>
                        <el-col :span="8">
                           <div class="item">
                            <img src="@/assets/images/template-item1.png" alt="">
                            <h2>会议记录</h2>
                            <p><el-text line-clamp="2">议记录模板可最大限度地提高会议效率</el-text></p>
                           </div>
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.container {
    width: 1200px;
    height: 100%;
    margin: 0 auto;

    .banner {
        width: 100%;
        height: 350px;
        background-image: url("/src/assets/images/template-banner.png");
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin-bottom: 60px;
        border-radius: 10px;
    }

    .template{
        display: flex;

        .catalog{
            width: 400px;
            height: 100%;
            background-color: antiquewhite;
        }

        .content{
            margin-left: 1rem;
            width: 100%;
            height: 100%;

            .item{
                width: 100%;
                height: 300px;
                margin-bottom: 30px;
                cursor: pointer;

                img{
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                    object-position: center;
                    border: 1px solid #DCDCDC;
                    box-sizing: border-box;
                }
            }
        }
    }
}
</style>
