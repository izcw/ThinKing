<template>
    <div>
        <div class="profilePicture">
            <el-avatar :size="60" :src="circleUrl" />
            <div class="name">
                <p>偏好名称</p>
                <el-input v-model="modifyNickname" style="width: 200px;" placeholder="请输入昵称">
                    <template #append v-if="modifyNickname">
                        <el-button plain>更改</el-button>
                    </template>
                </el-input>
            </div>
        </div>
        <div>
            <span>
                账号安全
            </span>
            <el-divider />
        </div>
        <div class="configuration">
            <div class="item">
                <div>
                    <p class="name">邮箱地址</p>
                    <p class="value">2405824084@qq.com</p>
                </div>
                <div>
                    <el-button plain>更改邮件地址</el-button>
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
import { ref } from 'vue';


let modifyNickname = ref()
</script>
<style scoped lang='scss'>
.profilePicture {
    display: flex;
    align-items: center;
    margin-bottom: 3rem;

    .name {
        margin-left: 1rem;

        p {
            font-size: 12px;
            margin-bottom: 4px;
        }
    }

}
</style>
