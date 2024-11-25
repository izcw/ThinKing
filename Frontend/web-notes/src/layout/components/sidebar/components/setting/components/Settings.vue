<template>
    <div>
        <div class="configuration">
            <div class="item">
                <div>
                    <p class="name">启动时</p>
                    <p class="value">2405824084@qq.com</p>
                </div>
                <div>
                    <el-dropdown trigger="click">
                        <span class="el-dropdown-link">
                            继续之前的操作<el-icon class="el-icon--right"><arrow-down /></el-icon>
                        </span>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item :icon="Plus">Action 1</el-dropdown-item>
                                <el-dropdown-item :icon="CirclePlusFilled">
                                    Action 2
                                </el-dropdown-item>
                                <el-dropdown-item :icon="CirclePlus">Action 3</el-dropdown-item>
                                <el-dropdown-item :icon="Check">Action 4</el-dropdown-item>
                                <el-dropdown-item :icon="CircleCheck">Action 5</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
                </div>
            </div>
            <div class="item">
                <div>
                    <p class="name">密码</p>
                    <p class="value">******</p>
                </div>
                <div>
                    <el-button plain>更改密码</el-button>
                </div>
            </div>
            <div class="item">
                <div>
                    <p class="name">锁屏PIN码</p>
                    <p class="value">******</p>
                </div>
                <div>
                    <el-button plain>修改PIN码</el-button>
                </div>
            </div>
            <div class="item">
                <div>
                    <p class="name">密码</p>
                    <p class="value">更改密码可以登录账号</p>
                </div>
                <div>
                    <el-switch v-model="value1" />
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'></style>
