<template>
    <div class="current">
        <p>当前方案</p>
        <n-alert :show-icon="false" type="default" style="width: 100%;">
            <template #header>
                {{ store.userInfoData.currentSubscription.noteSubscribe.subscribeName }}
                <n-tag size="small" v-if="store.userInfoData.currentSubscription.noteSubscribeOrder != null">
                    还剩{{ calculateExpiryDays(store.userInfoData.currentSubscription.noteSubscribeOrder.create_time,
                        store.userInfoData.currentSubscription.noteSubscribe.unit) }}天
                </n-tag>
            </template>

            <n-alert :bordered="false" type="default">
                <template #icon>
                    <n-icon size="18">
                        <Speaker148Regular />
                    </n-icon>
                </template>
                <n-marquee>
                    <div style="margin-right: 64px;">
                        <p>{{ store.userInfoData.currentSubscription.noteSubscribe.comments }}</p>
                    </div>
                </n-marquee>
            </n-alert>
        </n-alert>
    </div>
</template>
<script setup>
import { calculateExpiryDays } from '@/utils/dateUtils';
import { Speaker148Regular } from '@vicons/fluent';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

</script>
<style scoped lang='scss'>
.current {
    width: 100%;
    font-size: 14px;
    color: #666;
}
</style>
