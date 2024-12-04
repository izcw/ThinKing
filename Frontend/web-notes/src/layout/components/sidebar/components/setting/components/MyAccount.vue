<template>
    <div>
        <div class="profilePicture">
            <el-avatar :size="60" :src="FILE_PATH_API_URL + store.userInfoData.avatar" />
            <div class="name">
                <p>偏好名称</p>
                <el-input v-model="modifyNickname" style="width: 200px;" placeholder="请输入昵称">
                    <template #append v-if="modifyNickname != store.userInfoData.nickname">
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
                    <p class="value">{{store.userInfoData.email}}</p>
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
                    <el-text type="info" size="small">默认为登录密码</el-text>
                </div>
                <div>
                    <el-button plain>修改PIN码</el-button>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import { FILE_PATH_API_URL } from "@/config/setting"
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

let modifyNickname = ref(store.userInfoData.nickname)
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
