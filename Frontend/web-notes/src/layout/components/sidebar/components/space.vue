<template>
    <div class="space text-select" ref="scrollContainer">
        <div class="item-space" v-for="item in store.userInfoData.noteSpaces" :key="item.spaceId"
            :class="{ 'active': item.defaultSpace == 0 }"
            :style="{ 'background-color': item.defaultSpace == 0 ? 'transparent' : item.color }"
            @click="toggleStatus(item)">
            <!-- 添加点击事件 -->
            <n-ellipsis style="max-width: 100px">
                {{ item.name }}
            </n-ellipsis>
        </div>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="item-space AddSpace" @click="dialogTableVisible = true">
                    <n-icon size="20">
                        <AddCircle16Regular />
                    </n-icon>
                </div>
            </template>
            <span>新建空间</span>
        </n-tooltip>

        <el-dialog v-model="dialogTableVisible" width="600" style="min-height: 400px;" :show-close="false" align-center>
            <div style="padding:1rem;box-sizing: border-box;">
                <el-table :data="data" style="width: 100%;">
                    <el-table-column prop="name" label="空间" />
                    <el-table-column prop="color" label="色彩">
                        <template #default="scope">
                            <div style="width: 25px;height: 25px;border-radius: 50%"
                                :style="{ 'background-color': scope.row.color }">
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="color" label="默认空间">
                        <template #default="scope">
                            <el-switch v-model="value1" />
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" width="100" label="操作">
                        <template #default>
                            <el-button link type="danger" size="small" @click="handleClick">
                                删除
                            </el-button>
                            <el-button link type="primary" size="small">修改</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-button style="width: 100%;margin:1rem 0 2rem 0;" @click="innerVisible = true">添加</el-button>
                <el-alert title="免费空间最多3个" type="info" :closable="false" />
            </div>
            <el-dialog v-model="innerVisible" width="600" style="height: 400px;" title="添加" :show-close="false"
                align-center append-to-body>
                <div style="padding:1rem;box-sizing: border-box;">
                    <el-form :model="form" label-width="auto" style="max-width: 600px">
                        <el-form-item label="空间名称">
                            <el-input v-model="form.name" placeholder="请输入空间名称..." />
                        </el-form-item>
                        <el-form-item label="选择色彩">
                            <el-radio-group v-model="form.color">
                                <el-radio size="large" border v-for="(item, index) in colorSpace" :key="index"
                                    :value="item.name" :style="{ 'background-color': item.colora }"
                                    class="space-radio">{{
                                        item.color1 }}</el-radio>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item>
                            <el-button>取消</el-button>
                            <el-button type="primary" @click="onSubmit">确定</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-dialog><!-- 添加对话框 -->
        </el-dialog><!-- 管理空间对话框 -->

    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRouter } from 'vue-router'
import { AddCircle16Regular } from '@vicons/fluent';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

const router = useRouter()

let dialogTableVisible = ref(false) // 管理空间对话框
const innerVisible = ref(false) // 新建空间对话框
import { reactive } from 'vue'

let colorSpace = ref([
    {
        name: "orange",
        colora: "#FCECE4",
        colorb: "#FCECE4",
        colorc: "#FCECE4",
        colord: "#FCECE4",
        colore: "#FCECE4"
    },
    {
        name: "yellow",
        colora: "#FEFBF0",
        colorb: "#FEFBF0",
        colorc: "#FEFBF0",
        colord: "#FEFBF0",
        colore: "#FEFBF0"
    },
    {
        name: "blue",
        colora: "#EBF7FC",
        colorb: "#EBF7FC",
        colorc: "#EBF7FC",
        colord: "#EBF7FC",
        colore: "#EBF7FC"
    },
    {
        name: "purple",
        colora: "#EEEBFB",
        colorb: "#EEEBFB",
        colorc: "#EEEBFB",
        colord: "#EEEBFB",
        colore: "#EEEBFB"
    }
])

// 添加表单
const form = reactive({
    name: '',
    color: '',
    status: true,
})

const onSubmit = () => {
    console.log('submit!')
}


let data = ref([
    { id: 1, name: "主空间", color: "#FCECE4", status: false },
    { id: 2, name: "生活笔记", color: "#FEFBF0", status: true },
    { id: 3, name: "编程学习", color: "#EBF7FC", status: false },
    { id: 4, name: "加密", color: "#EEEBFB", status: false }
]);


// 切换状态的函数
const toggleStatus = (item) => {
    // 先将所有空间项的状态设置为 false
    store.userInfoData.noteSpaces.forEach((i) => {
        i.defaultSpace = 1;
        // 设置被点击的空间项的状态为 true
    });

    store.userInfoData.noteSpaces.filter((i) => {
        if (item.spaceId == i.spaceId) {
            i.defaultSpace = 0;
        }
    })

    router.push('/space' + item.spaceId)
};

const scrollContainer = ref(null);
// 鼠标横向滚动
const handleWheel = (event) => {
    event.preventDefault(); // 阻止默认的滚动行为
    scrollContainer.value.scrollLeft += event.deltaY; // 根据滚动方向调整横向滚动
};

// 鼠标横向滚动--添加事件监听
onMounted(() => {
    scrollContainer.value.addEventListener('wheel', handleWheel, { passive: false });
});

// 鼠标横向滚动--移除事件监听
onBeforeUnmount(() => {
    scrollContainer.value.removeEventListener('wheel', handleWheel);
});
</script>

<style scoped lang='scss'>
.space {
    width: 100%;
    display: flex;
    position: absolute;
    bottom: 0;
    overflow-x: auto;

    .item-space {
        color: #666;
        font-size: 13px;
        padding: 8px 1rem;
        cursor: pointer;
        border-right: 1px solid #DCDCDC;
        border-top: 1px solid #DCDCDC;
        border-bottom: 1px solid #DCDCDC;
        opacity: 0.9;
    }

    .item-space:hover,
    .item-space:active {
        opacity: 1;
    }

    .item-space.active {
        opacity: 1;
        color: #333;
        background-color: transparent;
        border-top: none;
    }

    .item-space.active::after {
        content: "";
        display: block;
        width: 100%;
        height: 2px;
        border-radius: 2px;
        background-color: #999;
    }

    .AddSpace {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #F7F7F5;
        border: none;
        margin-right: 50px;
    }
}

// 滚动条样式
.space::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

.space::-webkit-scrollbar-thumb {
    background: #DCDCDC;
    border-radius: 6px;
}

.space::-webkit-scrollbar-track {
    background-color: #fff;
}
</style>
