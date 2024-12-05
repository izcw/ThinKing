<template>
    <div class="blankPage">
        <CollapseMenuBox />
        <div class="container">
            <div class="banner">
                <h1>模版中心</h1>
            </div>

            <el-input v-model="SearchValue" size="large" style="margin-bottom: 1rem;" placeholder="请搜索模版名称" />
            <div class="template">
                <div class="catalog">
                    <div class="item" v-for="(item, index) in menuList" :key="index"
                        :class="{ active: selectItem == index }" @click="SearchTemplate(item, index)">
                        {{ item.label }}
                    </div>
                </div>
                <div class="content">
                    <el-row :gutter="20">
                        <el-col :span="8" :xs="24" :sm="24" :md="12" :lg="8">
                            <div class="item">
                                <div class="PreviewBox">
                                    <img src="@/assets/images/template-item1.png" alt="">
                                    <el-button color="#626aef" size="small" :dark="isDark">使用</el-button>
                                </div>
                                <h3>旅行计划</h3>
                                <p><el-text type="info" size="small"
                                        line-clamp="2">使用此旅行计划模板可最大限度地提高会议效率使用此旅行计划模板可最大限度地提高会议效率使用此旅行计划模板可最大限度地提高会议效率</el-text>
                                </p>
                            </div>
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue'
import CollapseMenuBox from '@/components/CollapseMenu.vue';

let selectItem = ref(0)

const menuList = ref([
    { label: '全部', icon: '图标' },
    { label: '计划', icon: '图标' },
    { label: '升级方案', icon: '图标' },
    { label: '学习', icon: '图标' },
    { label: '打卡', icon: '图标' }
]);


// 搜索模版
let SearchValue = ref()
let SearchTemplate = (item, index) => {
    selectItem.value = index
}
</script>
<style scoped lang='scss'>
.container {
    padding: 0 150px;
    box-sizing: border-box;
    height: 100%;
    margin: 0 auto;


    .banner {
        width: 100%;
        height: 300px;
        background-color: #d7c3e8;
        background-image: url("/src/assets/images/template-banner2.png");
        background-position: center;
        background-repeat: no-repeat;
        background-size: auto 100%;
        margin-bottom: 60px;
        border-radius: 10px;

        display: flex;
        align-items: center;

        h1 {
            padding-left: 30px;
            font-size: 34px;
            color: #fff;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
        }
    }

    .template {
        display: flex;

        .catalog {
            width: 300px;
            height: 100%;

            .item {
                cursor: pointer;
                padding: 4px 1rem;
                box-sizing: border-box;
                margin-bottom: 4px;
                border-radius: 4px;
            }

            .item:hover,
            .item:active,
            .item.active {
                background-color: #EFEFEE;
            }
        }

        .content {
            margin-left: 1rem;
            width: 100%;
            height: 100%;

            .item {
                width: 100%;
                height: 300px;
                margin-bottom: 30px;
                cursor: pointer;

                .PreviewBox {
                    width: 100%;
                    height: 180px;
                    position: relative;

                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        object-position: center;
                        border: 1px solid #EFEFEE;
                        box-sizing: border-box;
                    }

                    .el-button {
                        position: absolute;
                        bottom: 1rem;
                        right: 1rem;
                        opacity: 0;
                        transition: all 0.3s ease;
                    }

                }
                &:hover,&:active{
                    .el-button {
                        opacity: 1;
                    }
                }

                h3{
                    margin-top: 6px;
                }

            }
        }


    }
}

@media (max-width: 768px) {
    .template {
        flex-direction: column;

        .catalog {
            width: 100% !important;
            margin-bottom: 1rem;
        }

        .content {
            margin-left: 0 !important;
        }
    }
}
</style>
