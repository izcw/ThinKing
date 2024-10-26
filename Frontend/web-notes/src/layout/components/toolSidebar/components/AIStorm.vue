<template>
    <div class="AIStorm">
        <div class="ChatHistory">
            <div class="Session-item" v-for="item in data" :key="item.id">
                <div class="chat problem">
                    <img class="profilePic" src="@/assets/book.png" alt="">
                    <div class="chatcontent">
                        {{ item.user }}
                    </div>
                </div>
                <div class="chat answer">
                    <img class="profilePic" src="@/assets/logo.png" alt="">
                    <div class="chatcontent">
                        {{ item.answer }}
                    </div>
                </div>
            </div>

            <div class="recommend">
                <p>你好呀！今天我能为你做些什么？</p>
                <p>建议</p>
                <n-tag round>
                    <template #icon>
                        <n-icon :component="Search28Filled" />
                    </template>
                    总结此页面
                </n-tag>
                <n-tag round>
                    <template #icon>
                        <n-icon :component="Home48Regular" />
                    </template>
                    翻译
                </n-tag>
                <n-tag round>
                    <template #icon>
                        <n-icon :component="Search28Filled" />
                    </template>
                    润色一下
                </n-tag>
            </div><!-- 建议 -->

        </div> <!-- 对话历史 -->
        <div class="InputBox">
            <div class="tools">
                <div class="addAi">
                    新建
                </div>
                <div class="uploadFiles">
                    上传文件
                </div>
            </div>
            <div class="chat">
                <n-input placeholder="自动调整尺寸" type="textarea" size="small" :autosize="{
                    minRows: 5,
                    maxRows: 5,
                }" />
            </div>
        </div><!-- 输入 -->
    </div>
</template>
<script setup>
import { ref } from 'vue'
import { Home48Regular, Search28Filled } from '@vicons/fluent'
let data = ref([
    {
        id: 1,
        user: '请帮我优化文章你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的语法。这段代码结构清晰，功',
        answer: '你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的\\n语法。这段代码结构清晰，功能实现也很完整。为了实现点击切换的功能，可以考虑在每个空间项上添加一个点击事件处理函数，以切换其状态\n我会在你提供的代码基础上进行修改，增加点击切换空间的功能。\n修改后的代码'
    },
    {
        id: 2,
        user: '请帮我优化文章你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的语法。这段代码结构清晰，功',
        answer: '你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的\\n语法。这段代码结构清晰，功能实现也很完整。为了实现点击切换的功能，可以考虑在每个空间项上添加一个点击事件处理函数，以切换其状态\n我会在你提供的代码基础上进行修改，增加点击切换空间的功能。\n修改后的代码'
    },
    {
        id: 3,
        user: '请帮我优化文章你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的语法。这段代码结构清晰，功',
        answer: '你的代码实现了一个可以横向滚动的空间列表，使用了 Vue 3 的\\n语法。这段代码结构清晰，功能实现也很完整。为了实现点击切换的功能，可以考虑在每个空间项上添加一个点击事件处理函数，以切换其状态\n我会在你提供的代码基础上进行修改，增加点击切换空间的功能。\n修改后的代码'
    }
])
</script>
<style scoped lang='scss'>
.AIStorm {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .ChatHistory {
        width: 100%;
        height: 100%;
        overflow-y: auto;
        padding-bottom: 2rem;

        .Session-item {
            width: 100%;
            padding-bottom: 2rem;

            .chat {
                padding: 1rem;

                .profilePic {
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    overflow: hidden;
                    border: 1px solid #DCDCDC;
                }
            }

            .problem {
                display: flex;
                justify-content: flex-start;
                align-items: flex-start;
                flex-direction: row-reverse;

                .chatcontent {
                    background-color: #4277ff;
                    color: #fff;
                }
            }

            .answer {
                display: flex;
                align-items: flex-start;

                .chatcontent {
                    background-color: #F4F4F4;
                }
            }

            .chatcontent {
                width: 75%;
                border-radius: 2px;
                box-sizing: border-box;
                padding: 10px;
                margin: 0 10px;
            }
        }

        .recommend {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 100%;
            padding: 1rem;
            box-sizing: border-box;
            color: #666;

            p {
                font-size: 14px;
                margin-bottom: 10px
            }

            .n-tag {
                margin-bottom: 10px
            }
        }
    }

    .InputBox {
        border-top: 1px solid #DCDCDC;
        padding: 15px 0;

        .tools {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem
        }

        .chat {
            width: 100%;
        }
    }
}



.AIStorm:hover .ChatHistory::-webkit-scrollbar-thumb,
.AIStorm:active .ChatHistory::-webkit-scrollbar-thumb {
    background: #DCDCDC;
}

// 滚动条样式
.ChatHistory::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

.ChatHistory::-webkit-scrollbar-thumb {
    background: transparent;
    border-radius: 6px;
}

.ChatHistory::-webkit-scrollbar-track {
    background-color: transparent
}
</style>
