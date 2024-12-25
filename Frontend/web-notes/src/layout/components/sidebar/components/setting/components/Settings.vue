<template>
    <div>
        <div class="configuration">
            <div class="item">
                <div>
                    <p class="name">启动时</p>
                    <p class="value">2405824084@qq.com</p>
                </div>
                <div>
                    <el-tooltip :hide-after="0" content="暂未实现!!" placement="top" effect="light">
                        <el-dropdown trigger="click" @command="handleCommand">
                            <span class="el-dropdown-link">
                                {{ DefaultPageOpening.name }}<el-icon class="el-icon--right"><arrow-down /></el-icon>
                            </span>
                            <template #dropdown>
                                <el-dropdown-menu>
                                    <el-dropdown-item v-for="(item, index) in openList" :key="index" :ommand="index">{{
                                        item.name }}</el-dropdown-item>
                                </el-dropdown-menu>
                            </template>
                        </el-dropdown>
                    </el-tooltip>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'

const handleCommand = (index) => {
    DefaultPageOpening.value = openList.value[index]
}

let openList = ref([
    {
        name: "继续之前的操作",
        url: '/space1'
    },
    {
        name: "首页",
        url: '/space1/32425'
    }
])

let DefaultPageOpening = ref(openList.value[0])

</script>
<style scoped lang='scss'></style>
