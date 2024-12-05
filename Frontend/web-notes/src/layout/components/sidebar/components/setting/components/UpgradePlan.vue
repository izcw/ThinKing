<template>
    <div class="UpgradePlan">
        <div style="margin-bottom: 3rem;">
            <MySubscribeInfoBox />
        </div>
        <div class="suggest" v-if="store.userInfoData.subscribeId > 1">
            <suggestBox />
        </div>
        <div>
            <span>
                历史订阅
            </span>
            <el-divider />
        </div>
        <el-table :data="subscribeorder" style="width: 100%">
            <el-table-column prop="noteSubscribe.subscribeName" label="套餐名称" width="180" />
            <el-table-column prop="noteSubscribe.price" label="价格" />
            <el-table-column label="状态">
                <template #default="{ row }">
                    <el-tag type="primary"
                        v-if="getExpiryStatus(row.noteSubscribeOrder.create_time, row.noteSubscribe.unit) >= 0">还剩{{
                            getExpiryStatus(row.noteSubscribeOrder.create_time, row.noteSubscribe.unit) }}天</el-tag>
                    <el-tag type="info" v-else>已过期{{ getExpiryStatus(row.noteSubscribeOrder.create_time,
                        row.noteSubscribe.unit) }}天</el-tag>
                </template>
            </el-table-column>
            <el-table-column prop="noteSubscribeOrder.create_time" label="订阅时间" width="180" />
        </el-table>
    </div>
</template>
<script setup>
import { ref, reactive } from 'vue';
import { calculateExpiryDays } from '@/utils/dateUtils';
import suggestBox from '@/views/subscribe/components/suggest.vue';
import MySubscribeInfoBox from '@/views/subscribe/components/MySubscribeInfo.vue';
import { PageSubscribeOrder } from '@/api/subscribe/order'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

// 计算每个订单的过期状态
const getExpiryStatus = (createTime, unit) => {
    return calculateExpiryDays(createTime, unit);
};


let subscribeorder = ref()

const query = reactive({
    page: 1,
    limit: 10,
    sort: "create_time",
    order: "desc",
    subscribeOrderId: "",
    userId: store.userInfoData.userId,
    subscribeId: ""
})

PageSubscribeOrder(query).then((val) => {
    console.log(val);
    subscribeorder.value = val;
    return
}).catch((e) => {
    console.error('登录失败', e);
});
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
