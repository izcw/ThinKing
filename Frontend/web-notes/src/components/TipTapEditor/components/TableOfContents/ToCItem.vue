<template>
    <div :class="dynamicClasses">
        <a :href="'#' + item.id" @click.prevent="onItemClick" :data-item-index="item.itemIndex" :style="{ '--level': item.level }">
            {{ item.textContent }}
        </a>
    </div>
</template>

<script setup>
import { defineProps, defineEmits, computed } from 'vue'

// 定义props
const props = defineProps({
    item: {
        type: Object,
        required: true,
    },
    index: {
        type: Number,
        required: true,
    },
})


// 类
const dynamicClasses = computed(() => {
    return {
        'is-active': props.item.isActive && !props.item.isScrolledOver,
        'is-scrolled-over': props.item.isScrolledOver,
        [`level-${props.item.level}`]: true  // 使用方括号包裹表达式来拼接类名，符合对象语法要求
    };
});

// 定义emits
const emits = defineEmits(['item-click'])

// 定义点击事件处理函数
const onItemClick = (event) => {
    emits('item-click', event, props.item.id)
}
</script>


<style scoped lang='scss'></style>