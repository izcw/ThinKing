<!-- 斜线命令 -->
<template>
  <div class="dropdown-menu">
    <template v-if="items.length">
      <n-tabs type="line" trigger="hover" style="min-width: 240px; min-height: 320px;">
        <n-tab-pane name="tabP1" tab="基本">
          <n-infinite-scroll style="height: 240px" :distance="10" @load="handleLoad">
            <n-button :class="{ 'is-selected': index === selectedIndex }" v-for="(item, index) in items" :key="index"
              @click="selectItem(index)">
              {{ item.title }}
            </n-button>
            <n-button :class="{ 'is-selected': index === selectedIndex }" v-for="(item, index) in items" :key="index"
              @click="selectItem(index)">
              {{ item.title }}
            </n-button> <n-button :class="{ 'is-selected': index === selectedIndex }" v-for="(item, index) in items" :key="index"
              @click="selectItem(index)">
              {{ item.title }}
            </n-button>
          </n-infinite-scroll>
        </n-tab-pane>
        <n-tab-pane name="tabP2" tab="AI">
          ai
        </n-tab-pane>
        <n-tab-pane name="tabP3" tab="表格">
          表格
        </n-tab-pane>
        <n-tab-pane name="tabP4" tab="转换成">
          转换成
        </n-tab-pane>
        <n-tab-pane name="tabP5" tab="媒体">
          媒体
        </n-tab-pane>
      </n-tabs>
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

<style scoped lang="scss">
/* Dropdown menu */
.dropdown-menu {
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 2px 10px #ccc;
  padding: 6px 1rem;
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
      background-color: blueviolet;
    }

    &.is-selected {
      background-color: blueviolet;
    }
  }
}
</style>