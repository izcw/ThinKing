<!--
* @FileDescription: 工具侧边栏
-->
<template>
    <div class="toolSidebar">
        <n-tabs type="segment" animated>
            <n-tab-pane name="chap1" tab="目录">
                <div>
                    <div>目录</div>
                    <div>第一章</div>
                    <div>第二章</div>
                    <br>
                    <hr>
                    <n-collapse default-expanded-names="1">
                        <n-collapse-item title="文件目录" name="1">
                            <div>图片</div>
                            <div>PDF</div>
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
            </n-tab-pane>
            <n-tab-pane name="chap2" tab="AI">
                AI
            </n-tab-pane>
            <n-tab-pane name="chap5" tab="批注">
                批注
            </n-tab-pane>
        </n-tabs>
    </div>


</template>
<script setup>

</script>
<style scoped lang='scss'>
.toolSidebar {
    width: 100%;
    height: 100%;
    padding: 0 15px;
    box-sizing: border-box;
}
</style>
