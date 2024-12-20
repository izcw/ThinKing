<template>
    <div class="space text-select" ref="scrollContainer">

        <!-- 空间列表 -->
        <div class="item-space" v-for="item in store.userInfoData.noteSpaces" :key="item.spaceId"
            :class="{ 'active': item.spaceId == store.routerParamsId.spaceId }"
            :style="{ 'background-color': item.spaceId == store.routerParamsId.spaceId ? 'transparent' : ThemeSpaceFind(item.color) }"
            @click="toggleStatus(item)">
            <n-ellipsis style="max-width: 80px">
                {{ item.name }}
            </n-ellipsis>
        </div>

        <!-- 新建空间 -->
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

        <!-- 对话框 -->
        <el-dialog v-model="dialogTableVisible" width="600" style="min-height: 400px;" :show-close="false" align-center>
            <div style="padding:1rem;box-sizing: border-box;">

                <!-- 列表 -->
                <el-table :data="store.userInfoData.noteSpaces" style="width: 100%;" height="300">
                    <el-table-column prop="name" label="空间名称" />
                    <el-table-column prop="color" label="空间主题">
                        <template #default="scope">
                            <div style="width: 30px;height: 30px;border-radius: 50%;border:2px solid #eee;box-sizing: border-box;"
                                :style="{ 'background-color': ThemeSpaceFind(scope.row.color) }">
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="defaultSpace" label="默认空间">
                        <template #default="scope">
                            <el-switch v-model="scope.row.defaultSpace" :disabled="scope.row.defaultSpace == 0"
                                @change="ChangeDefaultSpace(scope.row)" :active-value="0" :inactive-value="1" />
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" width="100" label="操作">
                        <template #default="scope">
                            <el-popconfirm title="确定删除?" @confirm="DeleteSpace(scope.row)">
                                <template #reference>
                                    <el-button link type="danger" size="small">
                                        删除
                                    </el-button>
                                </template>
                            </el-popconfirm>

                            <el-button link type="primary" size="small" @click="modifySpace(scope.row)">修改</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <!-- 添加 -->
                <el-button style="width: 100%;margin:1rem 0 2rem 0;"
                    :disabled="store.userInfoData.noteSpaces.length >= store.userInfoData.currentSubscription.noteSubscribe.space"
                    @click="addspaceFun">添加</el-button>
                <el-alert
                    :title="store.userInfoData.currentSubscription.noteSubscribe.subscribeName + '空间最多' + store.userInfoData.noteSpaces.length + '/' + store.userInfoData.currentSubscription.noteSubscribe.space + '个'"
                    type="info" :closable="false" />
            </div>

            <!-- 添加或修改对话框 -->
            <el-dialog v-model="innerVisible" width="600" style="height: 400px;"
                :title="addAndUpdateStatus ? '修改' : '添加'" :show-close="false" align-center append-to-body>
                <div style="padding:1rem;box-sizing: border-box;">
                    <el-form ref="ruleFormRef" :model="form" :rules="rules" label-width="auto" style="max-width: 600px">
                        <el-form-item label="空间名称" prop="name">
                            <el-input v-model="form.name" placeholder="请输入空间名称..." />
                        </el-form-item>
                        <el-form-item label="选择色彩">
                            <el-radio-group v-model="form.color">
                                <el-radio size="large" v-for="(item, index) in spaceTheme" :key="index"
                                    style="border:1px solid #f7f7f7;box-sizing: border-box;" :value="item.id"
                                    :style="{ 'background-color': item.spaceTab }" class="space-radio"></el-radio>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item>
                            <el-button @click="innerVisible = false">取消</el-button>
                            <el-button type="primary" v-if="addAndUpdateStatus"
                                @click="updateSpaceSubmit">保存</el-button>
                            <el-button type="primary" v-else @click="onSubmit">确定</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-dialog>
        </el-dialog>

    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, reactive, computed } from 'vue';
import { useRouter } from 'vue-router'
import { addSpace, deleteSpace, defaultSpace, updateSpace } from '@/api/space/index.js'
import { getSpaceTheme } from '@/api/common/Theme/index.js'
import { AddCircle16Regular } from '@vicons/fluent';
import { useUserStore } from '@/stores/modules/user'
import { ElMessage } from 'element-plus'
const store = useUserStore()

const router = useRouter()

let dialogTableVisible = ref(false) // 管理空间对话框
const innerVisible = ref(false) // 新建空间对话框


// 表单验证规则
const ruleFormRef = ref(null);
const rules = reactive({
    name: [
        { required: true, message: '请输入空间名称', trigger: 'blur' },
        { min: 1, max: 10, message: '请输入1到10位的名称', trigger: 'blur' },
    ],
    color: [
        { required: true, message: '请选择空间色彩', trigger: 'change' },
    ]
});


// 添加表单
const form = reactive({
    name: '',
    color: 1,
    sortNumber: 9,
})

// 空间主题色
let spaceTheme = ref()

let ThemeSpaceFind = (val) => {
    if (spaceTheme.value) {
        return spaceTheme.value.find((item) => item.id == val).spaceTab
    }
}

// 获取空间颜色
onMounted(() => {
    getSpaceTheme().then((data) => {
        spaceTheme.value = data
    }).catch((e) => {
        console.error(e);
    });
})


// 切换状态的函数
const toggleStatus = (item) => {
    console.log(item);
    router.push('/space/' + item.spaceId)
};

let addAndUpdateStatus = ref(false)

// 点击添加
let addspaceFun = () => {
    addAndUpdateStatus.value = false
    innerVisible.value = true;
    form.spaceId = null;
    form.name = '';
    form.color = 1;
    form.sortNumber = 9;
}

// 添加空间
const onSubmit = () => {
    // 触发表单验证
    ruleFormRef.value.validate((valid) => {
        if (valid) {
            // 如果验证通过，执行添加空间的操作
            addSpace(form).then((data) => {
                console.log("添加成功", data);
                ElMessage({
                    message: '空间添加成功',
                    type: 'success',
                });
                // 关闭对话框
                innerVisible.value = false;
                store.fetchUserInfo();

            }).catch((e) => {
                console.error('添加失败', e);
                ElMessage({
                    message: '添加失败，请重试',
                    type: 'error',
                });
            });
        } else {
            // 如果验证失败
            console.log('表单验证失败');
        }
    });
}


// 删除空间
let DeleteSpace = (val) => {
    console.log(val);
    if (val.defaultSpace == 0) {
        console.log("默认空间不可删除");
        ElMessage({
            message: '默认空间不可删除',
            type: 'warning',
        })
        return
    }

    deleteSpace({ spaceId: val.spaceId }).then((data) => {
        if (data.code === 200) {
            ElMessage({
                message: data.message,
                type: 'success',
            });
            if (store.routerParamsId.spaceId == val.spaceId) {
                store.getDefaultSpaceFun()
            }

            store.fetchUserInfo();
        } else {
            ElMessage({
                message: data.message,
                type: 'warning',
            });
        }

    }).catch((e) => {
        console.error(e);
    });
}


// 改变默认的空间
let ChangeDefaultSpace = (val) => {
    console.log("change default space", val);

    defaultSpace({ spaceId: val.spaceId }).then((msg) => {
        console.log("修改成功", msg);
        ElMessage({
            message: msg,
            type: 'success',
        });
        store.fetchUserInfo();
    }).catch((e) => {
        console.error(e);
    });
}


// 点击修改
let modifySpace = (val) => {
    console.log("change default space", val);
    innerVisible.value = true;
    addAndUpdateStatus.value = true
    form.spaceId = val.spaceId;
    // 将当前项的值赋值给表单
    for (const key in form) {
        if (val.hasOwnProperty(key)) {
            form[key] = val[key];
        }
    }

}

// 修改空间
let updateSpaceSubmit = () => {
    updateSpace(form).then((msg) => {
        console.log("修改成功", msg);
        ElMessage({
            message: msg,
            type: 'success',
        });
        // 关闭对话框
        innerVisible.value = false;
        store.fetchUserInfo();
    }).catch((e) => {
        console.error(e);
    });
}



// 横向滚动
const scrollContainer = ref(null);
// 鼠标横向滚动
const handleWheel = (event) => {
    // 如果对话框打开则不设置横向滚动
    if (dialogTableVisible.value) {
        return;
    }

    // 否则，正常处理横向滚动
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
