<!-- 文件目录面包屑 -->
<template>
  <div class="demo-breadcrumb">
    <div class="demo-breadcrumb-body">
      <ele-text
        v-if="directorys.length"
        type="primary"
        class="demo-breadcrumb-back"
        @click="goBack"
      >
        返回上一级
      </ele-text>
      <div class="demo-breadcrumb-list">
        <ele-text
          :type="!!directorys.length ? 'primary' : void 0"
          class="demo-breadcrumb-item"
        >
          <div
            :class="{ 'demo-breadcrumb-link': !!directorys.length }"
            @click="goRoot"
          >
            全部文件
          </div>
          <ele-text
            v-if="directorys.length"
            :icon="ArrowRight"
            type="placeholder"
            style="display: flex"
          />
        </ele-text>
        <ele-text
          v-for="(item, i) in directorys"
          :key="item.id"
          class="demo-breadcrumb-item"
          :type="i !== directorys.length - 1 ? 'primary' : 'default'"
        >
          <div
            :class="{ 'demo-breadcrumb-link': i !== directorys.length - 1 }"
            @click="goDirectory(i)"
          >
            {{ item.name }}
          </div>
          <ele-text
            v-if="i !== directorys.length - 1"
            :icon="ArrowRight"
            type="placeholder"
            style="display: flex"
          />
        </ele-text>
      </div>
    </div>
    <div class="hidden-xs-only">已全部加载，共 {{ total }} 个</div>
  </div>
</template>

<script setup>
  import { ArrowRight } from '@element-plus/icons-vue';

  const props = defineProps({
    // 文件夹数据
    directorys: Array,
    // 总文件数
    total: Number
  });

  const emit = defineEmits(['update:directorys']);

  /* 回到上级 */
  const goBack = () => {
    emit(
      'update:directorys',
      props.directorys.slice(0, props.directorys.length - 1)
    );
  };

  /* 回到根目录 */
  const goRoot = () => {
    if (props.directorys.length) {
      emit('update:directorys', []);
    }
  };

  /* 回到指定目录 */
  const goDirectory = (index) => {
    if (index !== props.directorys.length - 1) {
      emit('update:directorys', props.directorys.slice(0, index + 1));
    }
  };
</script>

<style lang="scss" scoped>
  .demo-breadcrumb {
    display: flex;
    align-items: center;
    line-height: 1;

    .demo-breadcrumb-body {
      flex: 1;
      display: flex;
      align-items: center;
    }

    .demo-breadcrumb-back {
      padding-right: 12px;
      border-right: 1px solid hsla(0, 0%, 60%, 0.6);

      & + .demo-breadcrumb-list {
        padding-left: 12px;
      }
    }
  }

  .demo-breadcrumb-list {
    flex: 1;
    display: flex;
    align-items: center;

    .demo-breadcrumb-item {
      display: flex;
      align-items: center;
    }
  }

  .demo-breadcrumb-back:hover,
  .demo-breadcrumb-link:hover {
    opacity: 0.8;
    cursor: pointer;
  }
</style>
