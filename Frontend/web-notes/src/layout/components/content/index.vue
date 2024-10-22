<template>
    <div class="contentBox" ref="contentBoxRef"> <!-- 添加 ref -->
        <div class="cover"></div><!-- 封面 -->
        <div class="pagebox" :style="{ width: centiBoole ? '100%' : 850 + 'px' }">
            <contentPageBox />
        </div><!-- 页面 -->
    </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import contentPageBox from './components/contentPage.vue';


let centiBoole = ref(false)
const contentBoxRef = ref(null); // 用于获取 .contentBox 元素的引用
onMounted(() => {
    const observer = new ResizeObserver((entries) => {
        for (const entry of entries) {
            // console.log('宽度变化:', entry.contentRect.width);
            centiBoole.value = entry.contentRect.width < 880 ? true : false;
        }
    });

    if (contentBoxRef.value) {
        console.log(contentBoxRef.value);

        observer.observe(contentBoxRef.value); // 观察 .contentBox 元素
    }

    onBeforeUnmount(() => {
        observer.disconnect(); // 组件卸载时停止观察
    });
});
</script>

<style scoped lang='scss'>
.contentBox {
    width: 100%;
    height: 100%;
    overflow-y: scroll;
}

// 滚动条样式
.contentBox::-webkit-scrollbar {
    /* 高度和宽度分别对应横竖滚动条的尺寸 */
    width: 10px;
    /* 竖向滚动条的宽度 */
    height: 10px;
    /* 横向滚动条的高度 */
}

// https://segmentfault.com/q/1010000043110324
// 滚动条两端的按钮
.contentBox::-webkit-scrollbar-button {
    // display: block;
    background-size: 8px;
    background-repeat: no-repeat;
}

/* Up箭头按钮 */
.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement {
    height: 12px;
    width: 12px;
    background-position: center 4px;
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(211,209,203)'><polygon points='50,00 0,50 100,50'/></svg>");
}

.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement:hover,
.contentBox::-webkit-scrollbar-button:single-button:vertical:decrement:active {
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(112, 112, 112)'><polygon points='50,00 0,50 100,50'/></svg>");
}

/* Down箭头按钮 */
.contentBox::-webkit-scrollbar-button:single-button:vertical:increment {
    height: 12px;
    width: 12px;
    background-position: center 4px;
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(211,209,203)'><polygon points='0,0 100,0 50,50'/></svg>");
}

.contentBox::-webkit-scrollbar-button:single-button:vertical:increment:hover,
.contentBox::-webkit-scrollbar-button:single-button:vertical:increment:active {
    background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='rgb(112, 112, 112)'><polygon points='0,0 100,0 50,50'/></svg>");
}


/* 滚动条里面的小方块 */
.contentBox::-webkit-scrollbar-thumb {
    background: #D3D1CB;
}

/* 滚动条里面的轨道 */
.contentBox::-webkit-scrollbar-track {
    // background-color: #F7F7F5;
}


.cover {
    width: 100%;
    height: 300px;
    background-image: url(/src/assets/noteback.jpg);
    background-position: top;
    background-size: cover;
    background-repeat: no-repeat;
}

.pagebox {
    margin: 0 auto;
}
</style>
