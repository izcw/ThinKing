<template>
    <div class="PanelSplitter">
        <div class="container" :class="{ 'reversed': contentPanel !== 'left' }">
            <div class="panel panel-left" :class="{ 'no-transition': dragging }" v-show="parentSidebarStatus"
                :style="{ width: leftPanelSize + 'px' }">
                <slot name="1"></slot>
            </div>
            <div class="divider" @mousedown.stop="startDrag" v-show="parentSidebarStatus"></div>
            <div class="panel panel-right" :style="{ flex: '1' }">
                <slot name="2"></slot>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, defineProps, onMounted, provide } from 'vue';

const props = defineProps({
    defaultSize: {
        type: [Number, null],
        default: 200,
    },
    minPanelSize: {
        type: Number,
        default: 0,
    },
    maxPanelSize: {
        type: [Number, null],
        default: null,
    },
    contentPanel: {
        type: String,
        default: 'left'
    },
    defaultSwitch: {
        type: Boolean,
        default: false
    }
});

let leftPanelSize = ref(props.defaultSize); // 左面板默认宽度
let dragging = false;
let startX = 0;
let startLeftSize = 0;

// 提供一个方法用于更新侧边栏状态
const parentSidebarStatus = ref(props.defaultSwitch);
const updateStatus = (status) => {
    parentSidebarStatus.value = status;
};
provide('parentSidebarStatus', parentSidebarStatus); // 提供状态
provide('updateParentSidebarStatus', updateStatus); // 提供更新状态的方法

const updateWidth = (width) => {
    leftPanelSize.value = width;
};
provide('updateParentSidebarWidth', updateWidth); // 提供更新状态的方法

const maxPanelSizeValue = computed(() => {
    return props.maxPanelSize !== null ? props.maxPanelSize : Infinity;
});

const calculateNewLeftSize = (deltaX) => {
    let newSize = startLeftSize + (props.contentPanel === 'left' ? deltaX : -deltaX);
    return Math.max(props.minPanelSize, Math.min(maxPanelSizeValue.value, newSize));
};

// 开始拖动
const startDrag = (event) => {
    dragging = true;
    startX = event.clientX;
    startLeftSize = leftPanelSize.value;

    document.body.style.userSelect = 'none';
    document.body.style.cursor = 'col-resize';

    event.stopPropagation();

    document.addEventListener('mousemove', onDrag);
    document.addEventListener('mouseup', stopDrag);
};

// 拖动中
const onDrag = (event) => {
    if (!dragging) return;
    const deltaX = event.clientX - startX;
    leftPanelSize.value = calculateNewLeftSize(deltaX);
};

// 拖动结束
const stopDrag = () => {
    dragging = false;
    document.body.style.userSelect = '';
    document.body.style.cursor = '';
    document.removeEventListener('mousemove', onDrag);
    document.removeEventListener('mouseup', stopDrag);
};

onMounted(() => {
    const container = document.querySelector('.container');
    if (container) {
        // container.style.transition = 'all 0.3s ease';
    }
});
</script>

<style scoped>
.PanelSplitter {
    width: 100%;
    height: 100%;
}

.container {
    display: flex;
    height: 100%;
    width: 100%;
}

.panel {
    box-sizing: border-box;
}

.panel-left {
    transition: all 0.3s ease;
    flex-shrink: 0;
    /* 确保 panel-left 不受挤压 */
}

.panel-left.no-transition {
    transition: none;
}

.panel-right {
    flex-grow: 1;
    /* 确保 panel-right 填充剩余空间 */
    transition: all 0.3s ease;
}

.divider {
    width: 3px;
    background-color: #f7f7f7;
    transition: all 0.1s ease;
    cursor: col-resize;
}

.divider:hover,
.divider:active {
    background-color: #ccc;
}

.reversed {
    flex-direction: row-reverse;
}
</style>
