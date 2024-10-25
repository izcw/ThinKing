<template>
    <div
      class="container"
      @dragover.prevent
    >
      <div
        v-for="(item, index) in items"
        :key="item.id"
        class="item"
        draggable="true"
        @dragstart="onDragStart(index, $event)"
        @dragend="onDragEnd"
        @drop="onDrop(index)"
      >
        {{ item.name }}
      </div>
      <div
        v-if="isDragging"
        class="preview"
        :style="{ top: `${previewY}px`, left: `${previewX}px` }"
      ></div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const items = ref([
    { id: 1, name: 'Item 1' },
    { id: 2, name: 'Item 2' },
    { id: 3, name: 'Item 3' },
    { id: 4, name: 'Item 4' },
    { id: 5, name: 'Item 5' },
    { id: 6, name: 'Item 6' },
    { id: 7, name: 'Item 7' },
    { id: 8, name: 'Item 8' },
    { id: 9, name: 'Item 9' },
  ]);
  
  let draggedIndex = null;
  let isDragging = false;
  let previewY = 0;
  let previewX = 0;
  
  const onDragStart = (index, event) => {
    draggedIndex = index;
    isDragging = true;
  
    // 设置预览框位置
    updatePreviewPosition(event.clientY, event.clientX);
    document.addEventListener('mousemove', updatePreviewPosition);
  };
  
  const onDragEnd = () => {
    isDragging = false;
    draggedIndex = null;
    document.removeEventListener('mousemove', updatePreviewPosition);
  };
  
  const onDrop = (index) => {
    if (index !== draggedIndex) {
      const draggedItem = items.value[draggedIndex];
      items.value.splice(draggedIndex, 1);
      items.value.splice(index, 0, draggedItem);
    }
    console.log("更新后的数据:", items.value); // 打印改变后的数据
  };
  
  // 更新预览框位置的函数
  const updatePreviewPosition = (clientY, clientX) => {
    // 获取容器的边界
    const container = document.querySelector('.container');
    const rect = container.getBoundingClientRect();
  
    // 计算预览框的位置
    previewY = clientY - rect.top; // 预览框的Y位置
    previewX = clientX - rect.left; // 预览框的X位置
  };
  </script>
  
  <style scoped lang='scss'>
  .container {
    display: flex;
    flex-wrap: wrap;
    position: relative; /* 使容器成为定位上下文 */
  }
  
  .item {
    padding: 10px;
    margin: 5px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    cursor: move;
    transition: background-color 0.2s ease; /* 添加过渡动画 */
  }
  
  .preview {
    position: absolute;
    width: 100px; /* 预览框的宽度 */
    height: 40px; /* 预览框的高度 */
    border: 2px dashed #ff5722; /* 虚线边框 */
    background-color: rgba(255, 255, 255, 0.7); /* 半透明背景 */
    z-index: 1000; /* 确保预览框在上方 */
    pointer-events: none; /* 不影响拖拽 */
    transition: top 0.2s ease, left 0.2s ease; /* 添加位置变化动画 */
  }
  </style>
  