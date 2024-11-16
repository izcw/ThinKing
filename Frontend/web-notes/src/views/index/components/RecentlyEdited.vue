<template>
    <div class="RecentlyEdited card text-select">
        <p><el-text class="mx-1" type="primary">最近编辑</el-text></p>
        <div class="time-base-mark"></div>
        <div class="content">
            <div class="item">
                <div class="time">2024/11/16</div>
                <div class="recentPage">
                    <div class="title">Hello</div>
                    <p>
                        <el-text line-clamp="4">
                            圣诞节开发噶世界第一上帝就发故事大纲是圣诞节开发噶世界第一上帝就发故事大纲是对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好
                        </el-text>
                    </p>
                </div>
            </div>
            <div class="item">
                <div class="time">2024/11/16</div>
                <div class="recentPage">
                    <div class="title">论文灵感</div>
                    <p>
                        <el-text line-clamp="4">
                            圣诞节开发噶世界第一上帝就发故事大纲是圣诞节开发噶世界第一上帝就发故事大纲是对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好
                        </el-text>
                    </p>
                </div>
            </div>
            <div class="item">
                <div class="time">2024/11/16</div>
                <div class="recentPage">
                    <div class="title">Java基础学习</div>
                    <p>
                        <el-text line-clamp="4">
                            圣诞节开发噶世界第一上帝就发故事大纲是圣诞节开发噶世界第一上帝就发故事大纲是对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好
                        </el-text>
                    </p>
                </div>
            </div>
            <div class="item">
                <div class="time">2024/11/16</div>
                <div class="recentPage">
                    <div class="title">English</div>
                    <p>
                        <el-text line-clamp="4">
                            圣诞节开发噶世界第一上帝就发故事大纲是圣诞节开发噶世界第一上帝就发故事大纲是对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好对方就会感受到尽快发给收到甲方公司的接口是大家看法和公司上的飞机公司的健康就好
                        </el-text>
                    </p>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.RecentlyEdited {
    width: 100%;
    height: 500px;
    padding-right: 0;
    overflow: hidden;
    position: relative;


    .content {
        position: absolute;
        left: 0;
        bottom: -30px;
        width: 100%;

        .item {
            padding-left: 1rem;
            box-sizing: border-box;
            height: 110px;
            position: relative;
            cursor: pointer;

            .recentPage {
                position: absolute;
                bottom: -10px;
                right: -10px;

                width: 230px;
                height: calc(100% + 30px);
                background-color: #fff;
                border: 1px solid #e3e2e4;
                border-radius: 8px 8px 0 0;
                box-shadow: 0 1px 6px #0000000d;
                padding: 1rem 1.5rem;
                box-sizing: border-box;

                p span {
                    font-size: 12px;
                    line-height: 20px;
                }

                .title {
                    font-size: 18px;
                    font-weight: bold;
                    padding-bottom: 6px;
                }
            }

            .time {
                position: relative;
                padding-left: 2.5rem;
                transition: all 0.2s ease;
                color: #999;
                font-size: 12px;
            }

            .time::after {
                position: absolute;
                left: 0;
                top: 10px;
                display: block;
                content: "";
                width: 30px;
                height: 1px;
                background-color: #BEC2CA;
            }



        }

        .item:hover .recentPage,
        .item:active .recentPage {
            animation: smooth 0.3s forwards;
        }

        .item:hover .time,
        .item:active .time {
            font-size: 14px;
        }

        @keyframes smooth {
            from {
                bottom: -10px;
                right: -10px;
            }

            to {
                bottom: 0;
                right: 0;
            }
        }
    }


    .time-base-mark {
        width: 16px;
        height: calc(100% - 30px);
        background-size: 16px 10px;
        background-image: linear-gradient(rgba(0, 0, 0, .1) 1px, transparent 0);
        position: absolute;
        bottom: 0;
        left: 20px;
        -webkit-mask-image: linear-gradient(180deg, transparent, #000 14%, #000);
        pointer-events: none;
    }
}
</style>
