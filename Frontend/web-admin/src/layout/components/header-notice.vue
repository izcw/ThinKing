<!-- 顶栏消息通知 -->
<template>
  <ele-popover
    :width="336"
    trigger="click"
    transition="el-zoom-in-top"
    :content-style="{ padding: 0 }"
    :body-style="{ overflow: 'hidden' }"
    :popper-style="{ maxWidth: 'calc(100% - 32px)' }"
    :popper-options="{
      modifiers: [{ name: 'offset', options: { offset: [0, 5] } }]
    }"
  >
    <template #reference>
      <div style="display: flex; align-items: center; height: 100%">
        <el-badge
          :value="unreadNum"
          :hidden="!unreadNum"
          style="line-height: 1; padding: 4px 0"
        >
          <el-icon style="transform: scale(1.29) translateY(1px)">
            <bell />
          </el-icon>
        </el-badge>
      </div>
    </template>
    <ele-tabs
      ref="tabRef"
      :center="true"
      v-model="active"
      :items="[
        { name: 'notice', label: '通知' },
        { name: 'letter', label: '私信' },
        { name: 'todo', label: '待办' }
      ]"
      class="notice-tabs"
    >
      <template #label="{ item, label }">
        <span>{{ label }}</span>
        <span v-if="item.name === 'notice' && notice.length">
          ({{ notice.length }})
        </span>
        <span v-if="item.name === 'letter' && letter.length">
          ({{ letter.length }})
        </span>
        <span v-if="item.name === 'todo' && todo.length">
          ({{ todo.length }})
        </span>
      </template>
      <template #notice>
        <div class="list-wrapper">
          <div v-for="item in notice" :key="item.id" class="list-item">
            <div class="list-item-icon" :style="{ background: item.color }">
              <el-icon>
                <calendar v-if="item.icon === 'report'" />
                <coordinate v-else-if="item.icon === 'leave'" />
                <video-camera v-else-if="item.icon === 'meeting'" />
                <checked v-else-if="item.icon === 'interview'" />
                <bell v-else-if="item.icon === 'salary'" />
              </el-icon>
            </div>
            <div class="list-item-body">
              <ele-ellipsis>{{ item.title }}</ele-ellipsis>
              <ele-ellipsis type="placeholder" class="list-item-text">
                {{ item.time }}
              </ele-ellipsis>
            </div>
          </div>
        </div>
        <div v-if="notice.length" class="bottom-tools">
          <div class="bottom-tool" @click="clearNotice">清空通知</div>
          <el-divider direction="vertical" style="margin: 0; width: 0" />
          <router-link to="/user/message?type=notice" class="bottom-tool">
            查看更多
          </router-link>
        </div>
        <el-empty v-else description="已查看所有通知" :image-size="68" />
      </template>
      <template #letter>
        <div class="list-wrapper">
          <div v-for="item in letter" :key="item.id" class="list-item">
            <el-avatar :size="32" :src="item.avatar" />
            <div class="list-item-body">
              <ele-ellipsis>{{ item.title }}</ele-ellipsis>
              <ele-ellipsis type="placeholder" class="list-item-text">
                {{ item.content }}
              </ele-ellipsis>
              <ele-ellipsis type="placeholder" class="list-item-text">
                {{ item.time }}
              </ele-ellipsis>
            </div>
          </div>
        </div>
        <div v-if="letter.length" class="bottom-tools">
          <div class="bottom-tool" @click="clearLetter">清空私信</div>
          <el-divider direction="vertical" style="margin: 0; width: 0" />
          <router-link to="/user/message?type=letter" class="bottom-tool">
            查看更多
          </router-link>
        </div>
        <el-empty v-else description="已读完所有私信" :image-size="68" />
      </template>
      <template #todo>
        <div class="list-wrapper">
          <div v-for="item in todo" :key="item.id" class="list-item">
            <div class="list-item-body">
              <ele-ellipsis>{{ item.title }}</ele-ellipsis>
              <ele-ellipsis type="placeholder" class="list-item-text">
                {{ item.description }}
              </ele-ellipsis>
            </div>
            <el-tag
              v-if="item.status === 0"
              type="info"
              size="small"
              :disable-transitions="true"
            >
              未开始
            </el-tag>
            <el-tag
              v-else-if="item.status === 1"
              type="danger"
              size="small"
              :disable-transitions="true"
            >
              即将到期
            </el-tag>
            <el-tag
              v-else-if="item.status === 2"
              size="small"
              :disable-transitions="true"
            >
              进行中
            </el-tag>
          </div>
        </div>
        <div v-if="todo.length" class="bottom-tools">
          <div class="bottom-tool" @click="clearTodo">清空待办</div>
          <el-divider direction="vertical" style="margin: 0; width: 0" />
          <router-link to="/user/message?type=todo" class="bottom-tool">
            查看更多
          </router-link>
        </div>
        <el-empty v-else description="已完成所有任务" :image-size="68" />
      </template>
    </ele-tabs>
  </ele-popover>
</template>

<script setup>
  import { ref, computed, nextTick } from 'vue';
  import {
    Bell,
    Calendar,
    Coordinate,
    VideoCamera,
    Checked
  } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { getUnreadNotice } from '@/api/example';

  //
  const tabRef = ref(null);

  // 选项卡选中
  const active = ref('notice');

  // 通知数据
  const notice = ref([]);

  // 私信数据
  const letter = ref([]);

  // 待办数据
  const todo = ref([]);

  // 未读数量
  const unreadNum = computed(() => {
    return notice.value.length + letter.value.length + todo.value.length;
  });

  /* 查询数据 */
  const query = () => {
    getUnreadNotice()
      .then((result) => {
        notice.value = result.notice;
        letter.value = result.letter;
        todo.value = result.todo;
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  /* 清空通知 */
  const clearNotice = () => {
    notice.value = [];
    updateActiveBar();
  };

  /* 清空通知 */
  const clearLetter = () => {
    letter.value = [];
    updateActiveBar();
  };

  /* 清空通知 */
  const clearTodo = () => {
    todo.value = [];
    updateActiveBar();
  };

  /* 更新标签页指示线 */
  const updateActiveBar = () => {
    nextTick(() => {
      tabRef.value?.updateActiveBar();
    });
  };

  query();
</script>

<style lang="scss" scoped>
  .list-wrapper {
    padding-top: 8px;
    box-sizing: border-box;
  }

  .list-item {
    display: flex;
    padding: 14px 24px;
    box-sizing: border-box;
    transition: background-color 0.2s;
    cursor: pointer;

    .list-item-body {
      flex: 1;
      overflow: hidden;

      .list-item-text {
        margin-top: 6px;
      }
    }

    .list-item-icon {
      width: 32px;
      height: 32px;
      color: #fff;
      font-size: 18px;
      border-radius: 50%;
      text-align: center;
      background-color: #60b2fc;
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    :deep(.el-avatar) {
      flex-shrink: 0;
    }

    .list-item-icon + .list-item-body,
    :deep(.el-avatar + .list-item-body) {
      padding-left: 12px;
    }

    &:hover {
      background-color: hsla(0, 0%, 60%, 0.08);
    }

    & + .list-item {
      border-top: 1px solid hsla(0, 0%, 60%, 0.2);
    }
  }

  // 操作按钮
  .bottom-tools {
    display: flex;
    align-items: center;
    border-top: 1px solid hsla(0, 0%, 60%, 0.2);

    .bottom-tool {
      flex: 1;
      line-height: 46px;
      text-align: center;
      text-decoration: none;
      transition: background-color 0.3s;
      cursor: pointer;
      color: inherit;

      &:hover {
        background: hsla(0, 0%, 60%, 0.08);
      }
    }
  }

  // 修改标签页样式
  .notice-tabs :deep(.el-tabs__header) {
    --ele-tab-height: 44px;
    --ele-tab-padding: 22px;
  }
</style>
