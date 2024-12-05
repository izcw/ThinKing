<template>
    <div class="space text-select" ref="scrollContainer">
        <div class="item-space" v-for="item in store.userInfoData.noteSpaces" :key="item.spaceId"
            :class="{ 'active': item.spaceId == storeCloud.cloudData.space }"
            :style="{ 'background-color': item.spaceId == storeCloud.cloudData.space ? 'transparent' : getThemeSpace(item.color).spaceTab }"
            @click="toggleStatus(item)">
            <!-- 添加点击事件 -->
            <n-ellipsis style="max-width: 80px">
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
                <el-table :data="store.userInfoData.noteSpaces" style="width: 100%;">
                    <el-table-column prop="name" label="空间" />
                    <el-table-column prop="color" label="色彩">
                        <template #default="scope">
                            <div style="width: 30px;height: 30px;border-radius: 50%;border:2px solid #eee;box-sizing: border-box;"
                                :style="{ 'background-color': getThemeSpace(scope.row.color).spaceTab }">
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="defaultSpace" label="默认空间">
                        <template #default="scope">
                            <el-switch v-model="scope.row.defaultSpace" :active-value="0" :inactive-value="1" />
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" width="100" label="操作">
                        <template #default="scope">
                            <el-popconfirm title="确定删除?" @confirm="DeleteSpace(scope.row)">
                                <template #reference>
                                    <el-button link type="danger" size="small" >
                                        删除
                                    </el-button>
                                </template>
                            </el-popconfirm>

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
                                <el-radio size="large" v-for="(item, index) in storeCloud.ThemeSpace" :key="index"
                                    style="border:1px solid #f7f7f7;box-sizing: border-box;" :value="item.id"
                                    :style="{ 'background-color': item.spaceTab }" class="space-radio"></el-radio>
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
import { useOperatingcloudStore } from '@/stores/OperatingCloud'
import { useUserStore } from '@/stores/modules/user'
import { ElMessage } from 'element-plus'
const storeCloud = useOperatingcloudStore()
const store = useUserStore()

const router = useRouter()

let dialogTableVisible = ref(false) // 管理空间对话框
const innerVisible = ref(false) // 新建空间对话框
import { reactive } from 'vue'





// 添加表单
const form = reactive({
    name: '',
    color: 1,
    status: true,
})

const onSubmit = () => {
    console.log('submit!')
}

// 获取主题色
let getThemeSpace = (val) => {
    return storeCloud.ThemeSpace.find((item) => item.id == val)
}


// 切换状态的函数
const toggleStatus = (item) => {
    console.log(item);
    storeCloud.cloudData.space = item.spaceId
    router.push('/space' + item.spaceId)
};



// 删除空间爱你
let DeleteSpace = (item) => {
    console.log(item);

    if (item.defaultSpace == 0) {
        console.log("默认空间不可删除");
        ElMessage({
            message: '默认空间不可删除',
            type: 'warning',
        })
    }
}



// 横向滚动
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
        font-size: 12px;
        padding: 10px 1rem;
        cursor: pointer;
        border-right: 1px solid #DCDCDC;
        border-top: 1px solid #DCDCDC;
        border-bottom: 1px solid #DCDCDC;
        opacity: 0.9;
        background-color: #fff;
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
