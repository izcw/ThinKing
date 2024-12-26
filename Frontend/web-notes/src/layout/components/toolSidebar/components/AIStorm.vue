<template>
    <div class="AIStorm">
        <div class="ChatHistory">
            <div class="Session-item" v-for="item in data" :key="item.id">
                <div class="chat problem">
                    <img class="profilePic" :src="FILE_PATH_API_URL + store.userInfoData.avatar" alt="Yoko">
                    <div class="chatcontent">
                        {{ item.user }}
                    </div>
                </div>
                <div class="chat answer">
                    <img class="profilePic" src="@images/logo.png" alt="">
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
                <n-input placeholder="万事问ai" type="textarea" size="small" :autosize="{
                    minRows: 5,
                    maxRows: 5,
                }" />
            </div>
        </div><!-- 输入 -->
    </div>
</template>
<script setup>
import { ref } from 'vue'
import { FILE_PATH_API_URL } from "@/config/setting"
import { Home48Regular, Search28Filled } from '@vicons/fluent'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

let data = ref([
    {
        id: 1,
        user: `请帮我总结文章`,
        answer: `ThinKing 是一款创新的在线笔记应用，旨在帮助用户以更高效、更有组织的方式记录和管理他们的想法、笔记和任务。它支持多种笔记类型，包括文本、图片、链接和代码片段，满足不同用户的需求。用户可以通过创建不同的空间和使用标签来分类和管理笔记，便于检索。ThinKing 提供了快速记录的环境，确保灵感和想法不会丢失。此外，应用还在不断开发中，将推出更多功能以增强用户体验。`
    },
    {
        id: 2,
        user: `请帮我翻译以下内容：Node Positions ( NodePos) describe the specific position of a node, its children, and its parent, providing easy navigation between them. Node Positions are heavily inspired by the DOM and are based on ProseMirror's ResolvedPos implementation.`,
        answer: `节点位置（Node Positions，缩写为 NodePos）描述了一个节点、其子节点以及其父节点的具体位置，便于在它们之间进行轻松导航。节点位置在很大程度上受到文档对象模型（DOM）的启发，并基于 ProseMirror 的已解析位置（ResolvedPos）实现方式。`
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
        padding-top: 15px;
        box-sizing: border-box;

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
