<template>
    <div class="UpgradePlan">
        <div class="suggest">
            <suggestBox />
        </div>
        <div>
            <span>
                历史订阅
            </span>
            <el-divider />
        </div>
        <el-table :data="store.userInfoData.noteSubscribesListInfos" style="width: 100%">
            <el-table-column prop="subscribeName" label="套餐名称" width="180" />
            <el-table-column prop="price" label="价格" />
            <el-table-column label="状态">
                <template #default="{ row }">
                    <el-tag type="primary" v-if="getExpiryStatus(row.create_time, row.unit) >= 0">还剩{{
                        getExpiryStatus(row.create_time, row.unit) }}天</el-tag>
                         <el-tag type="info" v-else>已过期{{ getExpiryStatus(row.create_time, row.unit) }}天</el-tag>
                </template>
            </el-table-column>
            <el-table-column prop="create_time" label="订阅时间" width="180" />
        </el-table>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import { calculateExpiryDays } from '@/utils/dateUtils';
import suggestBox from '@/views/subscribe/components/suggest.vue';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()


// 计算每个订单的过期状态
const getExpiryStatus = (createTime, unit) => {
    return calculateExpiryDays(createTime, unit);
};
</script>
<style scoped lang='scss'>
.UpgradePlan {
    width: 100%;
    height: 100%;
    overflow-y: auto;

    .suggest {}
}

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
