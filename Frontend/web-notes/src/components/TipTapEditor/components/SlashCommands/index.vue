<!-- 斜线命令 -->
<template>
    <div class="dropdown-menu">
      <template v-if="items.length">
        <button
          :class="{ 'is-selected': index === selectedIndex }"
          v-for="(item, index) in items"
          :key="index"
          @click="selectItem(index)"
        >
          {{ item.title }}
        </button>
      </template>
      <div class="item" v-else>
        No result
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, watch, onMounted } from 'vue';
  // 使用defineProps定义props
  const props = defineProps({
    items: {
      type: Array,
      required: true
    },
    command: {
      type: Function,
      required: true
    }
  });
  // 定义响应式数据selectedIndex
  const selectedIndex = ref(0);
  
  // 使用watch函数来监听items的变化
  watch(() => props.items, () => {
    selectedIndex.value = 0;
  });
  
  // 定义方法，和之前类似，但语法上有些许变化，比如使用.value访问响应式数据
  const onKeyDown = ({ event }) => {
    if (event.key === 'ArrowUp') {
      upHandler();
      return true;
    }
    if (event.key === 'ArrowDown') {
      downHandler();
      return true;
    }
    if (event.key === 'Enter') {
      enterHandler();
      return true;
    }
    return false;
  };
  
  const upHandler = () => {
    selectedIndex.value = ((selectedIndex.value + props.items.length) - 1) % props.items.length;
  };
  
  const downHandler = () => {
    selectedIndex.value = (selectedIndex.value + 1) % props.items.length;
  };
  
  const enterHandler = () => {
    selectItem(selectedIndex.value);
  };
  
  const selectItem = (index) => {
    const item = props.items[index];
    if (item) {
      props.command(item);
    }
  };
  </script>
  
  <style lang="scss">
  /* Dropdown menu */
  .dropdown-menu {
    background: var(--white);
    border: 1px solid var(--gray-1);
    border-radius: 0.7rem;
    box-shadow: var(--shadow);
    display: flex;
    flex-direction: column;
    gap: 0.1rem;
    overflow: auto;
    padding: 0.4rem;
    position: relative;
  
    button {
      align-items: center;
      background-color: transparent;
      display: flex;
      gap: 0.25rem;
      text-align: left;
      width: 100%;
  
      &:hover,
      &:hover.is-selected {
        background-color: var(--gray-3);
      }
  
      &.is-selected {
        background-color: var(--gray-2);
      }
    }
  }
  </style>