<template>
    <div class="catalogOutline">
        <div>
            目录
            <div>第一章</div>
            <div>第二章</div>
        </div>
        <n-collapse default-expanded-names="1">
            <n-collapse-item title="文件目录" name="1">
                <div class="">
                    图片
                    PDF
                </div>
            </n-collapse-item>
            <n-collapse-item title="日历" name="2">
                <div>1，2，3，4，5，6，7</div>
            </n-collapse-item>
            <n-collapse-item title="标签" name="3">
                <div>vue、java</div>
            </n-collapse-item>
            <n-collapse-item title="双向链接" name="4">
                <div>1——2——3</div>
            </n-collapse-item>
        </n-collapse>
    </div>
</template>
<script setup>

</script>
<style scoped lang='scss'>
.catalogOutline {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
</style>
