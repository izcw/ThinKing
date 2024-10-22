<!--
* @FileDescription: 分割面板
-->
<template>
    <div class="PanelSplitter">
        <div class="container" :class="{ 'reversed': contentPanel !== 'left' }">
            <div class="panel panel-left"
                :style="{ width: leftPanelSize + 'px', display: leftPanelSize == 0 ? 'none' : 'block' }">
                <slot name="1"></slot>
            </div>
            <div class="divider" @mousedown.stop="startDrag"></div>
            <div class="panel panel-right">
                <slot name="2"></slot>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, defineProps, onMounted } from 'vue';

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
    }
});

const leftPanelSize = ref(props.defaultSize);
let dragging = false;
let startX = 0;
let startLeftSize = 0;

const maxPanelSizeValue = computed(() => {
    return props.maxPanelSize !== null ? props.maxPanelSize : Infinity;
});

const calculateNewLeftSize = (deltaX) => {
    let newSize = startLeftSize + (props.contentPanel === 'left' ? deltaX : -deltaX);
    return Math.max(props.minPanelSize, Math.min(maxPanelSizeValue.value, newSize));
};

const startDrag = (event) => {
    dragging = true;
    startX = event.clientX;

    startLeftSize = leftPanelSize.value;
    document.body.style.userSelect = 'none';
    document.body.style.cursor = 'col-resize';

    // 阻止冒泡事件
    event.stopPropagation();

    document.addEventListener('mousemove', onDrag);
    document.addEventListener('mouseup', stopDrag);
};

const onDrag = (event) => {
    if (!dragging) return;
    const deltaX = event.clientX - startX;
    leftPanelSize.value = calculateNewLeftSize(deltaX);
};

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
        container.style.transition = 'none';
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
}

.panel {
    box-sizing: border-box;
}

.panel-left {}

.panel-right {
    flex-grow: 1;
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
    /* 处理反向显示 */
}
</style>
