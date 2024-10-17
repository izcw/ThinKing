<template>
  <ele-page :multi-card="false">
    <ele-card :body-style="{ padding: 0 }">
      <div :class="['message-wrapper', { 'is-mobile': mobile }]">
        <div class="message-side">
          <ele-menus
            :items="menus"
            :default-active="active"
            :mode="mobile ? 'horizontal' : 'vertical'"
          />
        </div>
        <div class="message-body">
          <transition name="slide-right" mode="out-in">
            <message-notice v-if="active == 'notice'" @reload="queryBadge" />
            <message-todo v-else-if="active == 'todo'" @reload="queryBadge" />
            <message-letter v-else @reload="queryBadge" />
          </transition>
        </div>
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, reactive, computed, watch, unref } from 'vue';
  import { useRouter } from 'vue-router';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useMobile } from '@/utils/use-mobile';
  import MessageNotice from './components/message-notice.vue';
  import MessageLetter from './components/message-letter.vue';
  import MessageTodo from './components/message-todo.vue';
  import { getUnReadNum } from '@/api/example';

  const { currentRoute } = useRouter();
  const { mobile } = useMobile();

  // 导航选中
  const active = ref('notice');

  // 未读数量
  const unReadNum = reactive({
    notice: 0,
    letter: 0,
    todo: 0
  });

  // 菜单数据
  const menus = computed(() => {
    return [
      {
        index: 'notice',
        path: '/user/message?type=notice',
        title: '系统通知',
        badge: { value: unReadNum.notice }
      },
      {
        index: 'letter',
        path: '/user/message?type=letter',
        title: '用户私信',
        badge: { value: unReadNum.letter }
      },
      {
        index: 'todo',
        path: '/user/message?type=todo',
        title: '待办事项',
        badge: { value: unReadNum.todo }
      }
    ];
  });

  watch(
    currentRoute,
    (route) => {
      const { path, query } = unref(route);
      if (path === '/user/message') {
        const defaultType = 'notice';
        if (!query.type) {
          active.value = defaultType;
        } else if (typeof query.type === 'string') {
          active.value = query.type;
        } else if (query.type.length && query.type[0]) {
          active.value = query.type[0];
        } else {
          active.value = defaultType;
        }
      }
    },
    { immediate: true }
  );

  /* 查询未读数量 */
  const queryBadge = () => {
    getUnReadNum()
      .then((result) => {
        Object.assign(unReadNum, result);
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  queryBadge();
</script>

<script>
  export default {
    name: 'UserMessage'
  };
</script>

<style lang="scss" scoped>
  .message-wrapper {
    display: flex;
    min-height: 582px;

    .message-side {
      width: 150px;
      flex-shrink: 0;
      display: flex;

      :deep(.el-menu) {
        width: 100%;
        padding-top: 12px;
      }
    }

    .message-body {
      flex: 1;
      padding: 8px 20px 16px 16px;
      box-sizing: border-box;
      overflow: hidden;
    }

    &.is-mobile {
      display: block;
      min-height: 637px;

      .message-side {
        width: auto;
        display: block;

        :deep(.el-menu) {
          justify-content: center;
          padding-top: 8px;
          padding-left: 0;
          padding-right: 0;
          --ele-menu-horizontal-height: 38px;
          --ele-menu-horizontal-item-padding: 8px;
        }
      }

      .message-body {
        padding: 16px;
      }
    }
  }
</style>
