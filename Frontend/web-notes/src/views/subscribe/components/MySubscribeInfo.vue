<template>
    <div class="current">
        <p>当前方案</p>
        <div class="current-box">
            <el-alert class="my" :title="store.userInfoData.currentSubscription.subscribeName" type="info" :closable="false" />
            <p class="comment">
                {{ store.userInfoData.currentSubscription.comments }}
            </p>
        </div>
    </div>
</template>
<script setup>
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
</script>
<style scoped lang='scss'>
.current {
    width: 100%;
    font-size: 14px;
    color: #666;

    .current-box {
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        align-items: center;

        .my {
            margin:0.5rem 0 1rem 0;
        }

        .comment {
            width: 100%;
            font-size: 12px;
            color: #999;
            display: -webkit-box;
            overflow: hidden;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 1;
        }
    }



}
</style>
