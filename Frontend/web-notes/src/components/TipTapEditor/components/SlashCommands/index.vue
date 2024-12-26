<!-- 斜线命令 -->
<template>
  <div class="dropdown-menu">
    <template v-if="items.length">
      <n-tabs type="line" trigger="click" style="min-width: 300px; min-height: 360px;">
        <n-tab-pane name="tabP1" tab="基本">
          <n-infinite-scroll style="height: 360px;" :distance="10">
            <div class="item" v-for="(item, index) in items" :key="index" text @click="selectItem(index)">
              <div class="icon">
                <n-icon size="24">
                  <component :is="item.icon" />
                </n-icon>
              </div>
              <div class="text">
                <p class="title">{{ item.title }}</p>
                <p class="describe">{{ item.describe }}</p>
              </div>
            </div>
          </n-infinite-scroll>
        </n-tab-pane>
        <n-tab-pane name="tabP4" tab="图片">
          <uploadImageBox />
        </n-tab-pane>
        <n-tab-pane name="tabP2" tab="AI">
          <div style="display: flex;width: 100%;height: 280px;align-items: flex-start;flex-direction: column;justify-content: space-between;">
            <div style="display: flex;flex-direction: column;">
              <el-tag type="info" style="margin-bottom: 4px">继续编写</el-tag>
              <el-tag type="info" style="margin-bottom: 4px">总结</el-tag>
              <el-tag type="info" style="margin-bottom: 4px">起草大纲</el-tag>
            </div>
            <div style="width: 100%;">
              <el-input v-model="textareaAI" style="width: 100%" :rows="2" type="textarea" placeholder="万事问ai" />
              <el-button type="primary" plain>发送</el-button>
            </div>
          </div>
        </n-tab-pane>
        <!-- <n-tab-pane name="tabP5" tab="嵌入媒体">
          嵌入媒体
        </n-tab-pane> -->
      </n-tabs>
    </template>
    <div class="item" v-else>
      No result
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import { ElButton, ElText } from 'element-plus'
import uploadImageBox from '@/components/uploadImage.vue'



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
watch(() => props.items, (newValue) => {
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


// AI
let textareaAI = ref()
</script>

<style scoped lang="scss">
/* Dropdown menu */
.dropdown-menu {
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 2px 10px #ccc;
  padding: 6px 1rem;
  position: relative;
  z-index: 99999999999;

  .item {
    width: 100%;
    height: auto;
    margin: 0;
    margin-bottom: 4px;
    padding: 4px 10px;
    box-sizing: border-box;
    display: flex;
    justify-content: flex-start;
    cursor: pointer;

    .icon {
      display: flex;
      align-items: center;
      justify-content: center;
      border: 1px solid #eee;
      padding: 4px;
      box-sizing: border-box;
      border-radius: 2px;
      width: 46px;
      min-width: 46px;
      height: 46px;
      margin-right: 10px;
    }


    .text {


      .title {
        font-size: 14px;
        color: #333;
        display: -webkit-box;
        overflow: hidden;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 1;
      }

      .describe {
        font-size: 12px;
        color: #666;
        display: -webkit-box;
        overflow: hidden;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 1;
      }
    }

    &:hover,
    &:hover.is-selected {
      background-color: #f5f7fa;
    }

    &.is-selected {
      background-color: #f5f7fa;
    }
  }
}
</style>