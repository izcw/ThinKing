<template>
    <div class="calendar card text-select">
        <p><el-text class="mx-1" type="primary">日历</el-text></p>
        <div class="content">
            <div class="item">日</div>
            <div class="item">1</div>
            <div class="item">2</div>
            <div class="item">3</div>
            <div class="item">4</div>
            <div class="item">5</div>
            <div class="item">6</div>
            <div class="item">六</div>
        </div>
        <div class="smallnote">
            <el-input v-model="textarea" style="width: 100%" type="textarea" placeholder="今日灵感" />
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue'
const textarea = ref('')
</script>
<style scoped lang='scss'>
.calendar {
    width: 100%;

    .content {
        margin-top: 1rem;
        display: flex;
        justify-content: space-between;
        align-items: center;

        .item {
            width: 100%;
            height: 30px;
            border: 1px solid #ebeef5;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
    }

    .smallnote {
        width: 100%;
        height: 150px;
        margin-top: 1rem;
        box-sizing: border-box;
        border: 1px solid #ebeef5;

        .el-textarea {
            width: 100%;
            height: 100%;

            textarea {
                width: 100%;
                height: 100%;
            }
        }
    }
}
</style>
