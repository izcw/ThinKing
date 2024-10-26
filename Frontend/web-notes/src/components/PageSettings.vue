<template>
    <div class="PageSettings text-select">
        <div class="Settings-item">
            <p class="settingsTitle">字体</p>
            <div class="contentBox fontBox">
                <div class="item" v-for="(item, index) in data.font" :key="index" :class="{ 'active': item.select }">
                    <div class="PreviewText">
                        Ag汉
                    </div>
                    {{ item.name }}
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">字体大小</p>
            <div class="contentBox fontSizeBox">
                <div class="item" v-for="(item, index) in data.fontsize" :key="index">
                    {{ item }}px
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面布局</p>
            <div class="contentBox">

            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面权限</p>
            <div class="contentBox">
                <div class="item select">
                    <p>只读</p> <n-switch size="small" />
                </div>
                <div class="item select">
                    <p>加密</p> <n-switch size="small" />
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">其它</p>
            <div class="contentBox">
                <div class="item select">
                    <p>导入</p>
                </div>
                <div class="item select">
                    <p>导出&nbsp;/&nbsp;下载</p>
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面信息</p>
            <div class="contentBox info">
                <div class="item">
                    创建时间：2024/10/26 22:21:05
                </div>
                <div class="item">
                    创建者：Yoko
                </div>
                <div class="item">
                    最后编辑于：2024/10/26 22:21:05
                </div>
                <div class="item">
                    编辑者：Yoko
                </div>
                <div class="item">
                    页面引用：2
                </div>
                <div class="item">
                    字数：400
                </div>
                <div class="item">
                    块数统计：20
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';


let data = ref({
    font: [
        {
            name: '默认',
            font: 'moren',
            select: true
        },
        {
            name: '衬线体',
            font: 'cehng',
            select: false
        },
        {
            name: '等宽体',
            font: 'deng',
            select: false
        }
    ],
    fontsize: [12, 14, 16, 18, 20]
})
</script>
<style scoped lang='scss'>
.PageSettings {
    .Settings-item {
        margin-bottom: 2rem;


        .settingsTitle {
            font-size: 14px;
            padding: 4px 0;
            margin: 4px 0;
            color: #999;
        }

        .contentBox {
            width: 100%;
        }

        .select {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-radius: 4px;
            cursor: pointer;
            padding: 4px;
            margin-bottom: 10px;
        }
        .select:hover,.select:active{
            background-color: #F7F7FA;
        }

        // 字体
        .fontBox {
            display: flex;
            justify-content: space-between;

            .item {
                width: 60px;
                height: 60px;
                padding: 4px;
                box-sizing: border-box;
                // border: 1px solid #DCDCDC;
                border-radius: 4px;
                color: #999;
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                cursor: pointer;

                .PreviewText {
                    font-size: 18px;
                    color: #333;
                }


            }

            .item.active .PreviewText {
                color: #18A0FB;
            }

            .item:hover {
                background-color: #F7F7FA;
            }
        }

        // 字体大小
        .fontSizeBox {
            display: flex;
            justify-content: space-between;

            .item {
                padding: 2px 4px;
                box-sizing: border-box;
                font-size: 14px;
                color: #999;
                border: 1px solid #DCDCDC;
                border-radius: 4px;
                cursor: pointer;
            }
        }

        // 页面信息
        .info{
            font-size: 12px;
            color: #999;
        }
    }
}
</style>
