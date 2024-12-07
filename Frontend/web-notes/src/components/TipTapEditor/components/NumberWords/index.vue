<template>
    <div class="numberWords"
        :class="{ 'character-count': true, 'character-count--warning': editor.storage.characterCount.characters() === setting.limit }">
        {{ editor.storage.characterCount.characters() }} / {{ setting.limit }} 字数
        <br>
        {{ editor.storage.characterCount.words() }} 单词
    </div>
</template>
<script setup>
import { defineProps } from 'vue'

const props = defineProps({
    editor: {
        type: Object,
        required: true
    },
    setting: {
        type: Object,
        required: true
    }
})
</script>
<style scoped lang='scss'>
.numberWords {
    font-size: 12px;
    color: #666;
    line-height: 24px;
}
</style>
