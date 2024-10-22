<template>
    <div class="leftTools">
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item">
                    <n-icon size="16">
                        <ArrowLeft28Filled />
                    </n-icon>
                </div>
            </template>
            <span>返回 Ctrl+[</span>
        </n-tooltip>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="Tools-item">
                    <n-icon size="16">
                        <ArrowRight28Filled />
                    </n-icon>
                </div>
            </template>
            <span>前进 Ctrl+]</span>
        </n-tooltip>
        <!-- 前进后退 -->

        <div class="Breadcrumb text-select">
            <n-breadcrumb>
                <n-breadcrumb-item>
                    <n-icon size="16">
                        <StarRegular />
                    </n-icon>
                    <n-ellipsis style="max-width: 140px;margin-left: 4px">
                        打发十分拓展性sdfds 、用户体验和编辑灵活性上仍存在一定不足，难以满足用户个性化需求
                    </n-ellipsis>
                </n-breadcrumb-item>
                <n-breadcrumb-item>
                    <n-icon size="16">
                        <StarRegular />
                    </n-icon>
                    <n-ellipsis style="max-width: 140px;margin-left: 4px">
                        打发十分拓展性
                    </n-ellipsis>
                </n-breadcrumb-item>
                <n-breadcrumb-item>
                    <n-icon size="16">
                        <StarRegular />
                    </n-icon>
                    <n-ellipsis style="max-width: 140px;margin-left: 4px">
                        打发十分拓展性sdfds 、用户体验和编辑灵活性上仍存在一定不足，难以满足用户个性化需求
                    </n-ellipsis>
                </n-breadcrumb-item>
            </n-breadcrumb>
        </div><!-- 面包屑 -->

    </div>

</template>
<script setup>
import { StarRegular } from '@vicons/fa'
import { ArrowLeft28Filled, ArrowRight28Filled } from '@vicons/fluent'
</script>
<style scoped lang='scss'>
.leftTools {
    display: flex;
    align-items: center;

    .Breadcrumb {
        margin-left: 12px;
    }
}
</style>
