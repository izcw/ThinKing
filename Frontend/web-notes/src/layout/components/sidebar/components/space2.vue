<template>
    <div class="space text-select" ref="scrollContainer">
        <div class="item-space" v-for="item in data" :key="item.id" :class="{ 'active': item.status }"
            :style="{ 'background-color': item.status ? 'transparent' : item.color }" @click="toggleStatus(item)">
            <!-- 添加点击事件 -->
            <n-ellipsis style="max-width: 100px">
                {{ item.name }}
            </n-ellipsis>
        </div>
        <n-tooltip placement="bottom" trigger="hover">
            <template #trigger>
                <div class="item-space AddSpace">
                    <n-icon size="20">
                        <AddCircle16Regular />
                    </n-icon>
                </div>
            </template>
            <span>新建空间</span>
        </n-tooltip>
    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { AddCircle16Regular } from '@vicons/fluent';

let data = ref([
    { id: 1, name: "主空间", color: "#FCECE4", status: false },
    { id: 2, name: "生活笔记", color: "#FEFBF0", status: true },
    { id: 3, name: "编程学习", color: "#EBF7FC", status: false },
    { id: 4, name: "加密", color: "#EEEBFB", status: false }
]);

const scrollContainer = ref(null);

// 切换状态的函数
const toggleStatus = (item) => {
    // 先将所有空间项的状态设置为 false
    data.value.forEach(i => i.status = false);
    // 设置被点击的空间项的状态为 true
    item.status = true;
};

// 鼠标横向滚动
const handleWheel = (event) => {
    event.preventDefault(); // 阻止默认的滚动行为
    scrollContainer.value.scrollLeft += event.deltaY; // 根据滚动方向调整横向滚动
};

// 鼠标横向滚动--添加事件监听
onMounted(() => {
    scrollContainer.value.addEventListener('wheel', handleWheel);
});

// 鼠标横向滚动--移除事件监听
onBeforeUnmount(() => {
    scrollContainer.value.removeEventListener('wheel', handleWheel);
});
</script>

<style scoped lang='scss'>
.space {
    width: 100%;
    display: flex;
    position: absolute;
    bottom: 0;
    overflow-x: auto;

    .item-space {
        color: #666;
        font-size: 13px;
        padding: 6px 1rem;
        cursor: pointer;
        border-right: 1px solid #DCDCDC;
        border-top: 1px solid #DCDCDC;
        border-bottom: 1px solid #DCDCDC;
        opacity: 0.9;
    }

    .item-space:hover,
    .item-space:active {
        opacity: 1;
    }

    .item-space.active {
        opacity: 1;
        color: #333;
        background-color: transparent;
        border-top: none;
    }

    .item-space.active::after {
        content: "";
        display: block;
        width: 100%;
        height: 2px;
        border-radius: 2px;
        background-color: #999;
    }

    .AddSpace {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #F7F7F5;
        border: none;
        margin-right: 50px;
    }
}

// 滚动条样式
.space::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

.space::-webkit-scrollbar-thumb {
    background: #DCDCDC;
    border-radius: 6px;
}

.space::-webkit-scrollbar-track {
    background-color: #fff;
}
</style>
