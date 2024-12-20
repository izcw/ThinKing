<template>
    <div class="contentPage">
        <div class="pageIcon">
            <el-popover placement="right" :width="378" trigger="click">
                <template #reference>
                    <span class="icon" v-if="StorePage.pageData.icon">{{ StorePage.pageData.icon }}</span>
                    <n-icon class="icon" v-else color="#666">
                        <FileTextOutlined />
                    </n-icon>
                </template>
                <div class="IconStore">
                    <div class="item" v-for="(item,index) in iconData" :key="index" @click="changeIcon(item.icon)">
                        {{ item.icon }}
                    </div>
                </div>
            </el-popover>
        </div>
        <el-input v-model.trim="title" :resize="'none'" @input="updateTitle" style="width: 100%" autosize
            type="textarea" placeholder="未命名页面" />
        <TipTapEditor />
    </div>
</template>
<script setup>
import { ref, watch } from 'vue';
import TipTapEditor from '@/components/TipTapEditor/index.vue'
import { FileTextOutlined } from '@vicons/antd'
import { update } from '@/api/note/index.js'
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()


let title = ref(StorePage.pageData.title)
// watch(title, (newValue, oldValue) => {
//     console.log('标题发生变化了');
//     console.log('新值:', newValue);
// });


// 更新title
let updateTitle = () => {
    console.log("jiao");
    update({ pageId: StorePage.pageData.pageId, title: title.value }).then((data) => {
        console.log("修改成功", data);
        StorePage.pageData = data
        store.getSpaceData(StorePage.pageData.spaceId)
    }).catch((e) => {
        console.error('修改失败', e);
    });
}


// 更换图标
let changeIcon = (val) =>{
    update({ pageId: StorePage.pageData.pageId, icon: val }).then((data) => {
        console.log("修改成功", data);
        StorePage.pageData = data
        store.getSpaceData(StorePage.pageData.spaceId)
    }).catch((e) => {
        console.error('修改失败', e);
    });
}

let iconData = ref([
    {
        name:"露齿而笑的脸",
        icon:"😀"
    },
    {
        name:"大眼睛、露齿而笑的脸",
        icon:"😃"
    },
    {
        name:"眼带笑意、露齿而笑的脸",
        icon:"😄"
    },
    {
        name:"眼带笑意、笑容绽开的脸",
        icon:"😁"
    },
    {
        name:"狗脸",
        icon:"🐶"
    },
    {
        name:"猫脸",
        icon:"🐱"
    },
    {
        name:"鼠脸",
        icon:"🐭"
    },
    {
        name:"仓鼠脸",
        icon:"🐹"
    },
    {
        name:"青苹果",
        icon:"🍏"
    },
    {
        name:"红苹果",
        icon:"🍎"
    },
    {
        name:"梨",
        icon:"🍐"
    },
    {
        name:"柑桔",
        icon:"🍊"
    },
    {
        name:"足球",
        icon:"⚽️"
    },
    {
        name:"篮球",
        icon:"🏀"
    },
    {
        name:"美式橄榄球",
        icon:"🏈"
    },
    {
        name:"棒球",
        icon:"⚾️"
    },
    {
        name:"汽车",
        icon:"🚗"
    },
    {
        name:"出租车",
        icon:"🚕"
    },
    {
        name:"越野车",
        icon:"🚙"
    },
    {
        name:"公交车",
        icon:"🚌"
    },
    {
        name:"手表",
        icon:"⌚️"
    },
    {
        name:"移动电话/手机",
        icon:"📱"
    },
    {
        name:"笔记本电脑",
        icon:"💻"
    },
    {
        name:"电脑",
        icon:"🖥️"
    },
    {
        name:"粉色的心",
        icon:"🩷"
    },
    {
        name:"红色的心",
        icon:"❤️"
    },
    {
        name:"橙色的心",
        icon:"🧡"
    },
    {
        name:"蓝色的心",
        icon:"💙"
    }
])
</script>
<style lang='scss'>
.contentPage {
    width: 100%;
    height: 100%;
    margin-top: 1rem;
    margin-bottom: 100px;
    position: relative;

    // 页面图标
    .pageIcon {
        position: absolute;
        top: -65px;
        left: 0;
        font-size: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        .pageIcon {
            top: -45px;
            width: 55px;
            height: 55px;
            font-size: 45px;
        }
    }

    // 标题
    .el-textarea__inner {
        color: #333;
        font-size: 36px !important;
        font-weight: 600 !important;
        box-shadow: none !important;
        padding: 0 !important;
        margin: 0 !important;
        padding-bottom: 1rem !important;
        margin-top: 50px !important;
        margin-bottom: 1rem !important;
        border-bottom: 1px solid #eee;

        &::-webkit-input-placeholder {
            color: #E1E1E0;
        }
    }
}

// 更换图标
.IconStore {
    display: flex;
    flex-wrap: wrap;

    .item {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        font-size: 26px;
        padding: 4px;
        margin: 4px;
        box-sizing: border-box;
        cursor: pointer;
    }
    .item:hover,.item:active{
        background-color: #f3f3f3;
    }
}
</style>
