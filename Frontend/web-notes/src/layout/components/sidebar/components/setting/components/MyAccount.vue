<template>
    <div>
        <div class="profilePicture">
            <el-avatar :size="60" :src="circleUrl" />
            <div class="name">
                <p>偏好名称</p>
                <el-input v-model="input" style="width: 200px;" placeholder="请输入昵称" />
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
                    <p class="name">邮箱地址</p>
                    <p class="value">2405824084@qq.com</p>
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

.configuration {
    .item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;

        .name {
            font-size: 14px;
            color: #333;
        }

        .value {
            font-size: 12px;
            color: #999;
        }
    }
}
</style>
