<template>
  <ele-page :multi-card="false">
    <top-search />
    <el-row :gutter="16">
      <el-col
        v-for="item in data"
        :key="item.id"
        :lg="6"
        :md="8"
        :sm="12"
        :xs="24"
      >
        <ele-card :body-style="{ padding: 0 }" style="margin-top: 16px">
          <div style="padding: 24px">
            <div style="display: flex; align-items: center">
              <el-avatar :size="40" :src="item.cover" style="flex-shrink: 0" />
              <ele-text size="md" style="flex: 1; padding-left: 12px">
                {{ item.title }}
              </ele-text>
            </div>
            <ele-ellipsis style="margin-top: 16px">
              网址: {{ item.url }}
            </ele-ellipsis>
            <ele-ellipsis style="margin-top: 6px">
              最后更新时间: {{ item.time }}
            </ele-ellipsis>
          </div>
          <el-divider style="margin: 0; opacity: 0.6" />
          <div class="list-item-footer">
            <ele-tooltip placement="top" content="下载" :offset="-8">
              <ele-text
                :icon="Download"
                type="placeholder"
                class="list-item-tool"
              />
            </ele-tooltip>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-tooltip placement="top" content="编辑" :offset="-8">
              <ele-text
                :icon="EditPen"
                type="placeholder"
                class="list-item-tool"
              />
            </ele-tooltip>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-tooltip placement="top" content="分享" :offset="-8">
              <ele-text
                :icon="Share"
                type="placeholder"
                class="list-item-tool"
              />
            </ele-tooltip>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-dropdown
              :items="[
                { title: '1st menu item', command: '1st' },
                { title: '2nd menu item', command: '2nd' },
                { title: '3rd menu item', command: '3rd' }
              ]"
              class="list-item-tool"
              style="padding: 0"
              :popper-options="{
                modifiers: [{ name: 'offset', options: { offset: [0, -4] } }]
              }"
            >
              <ele-text
                :icon="MoreFilled"
                type="placeholder"
                class="list-item-tool-trigger"
              />
            </ele-dropdown>
          </div>
        </ele-card>
      </el-col>
    </el-row>
    <ele-pagination
      :total="count"
      v-model:page-size="limit"
      v-model:current-page="page"
      layout="prev, pager, next"
      style="margin-top: 18px; justify-content: center"
    />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import {
    Download,
    EditPen,
    Share,
    MoreFilled
  } from '@element-plus/icons-vue';
  import TopSearch from '../project/components/top-search.vue';

  // 数据
  const data = ref([]);

  // 第几页
  const page = ref(1);

  // 每页多少条
  const limit = ref(8);

  // 总数量
  const count = ref(0);

  /* 查询数据 */
  const query = () => {
    count.value = 40;
    data.value = [
      {
        id: 1,
        title: 'ElementUI',
        url: 'https://element.eleme.cn',
        time: '2 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
      },
      {
        id: 2,
        title: 'Vue.js',
        url: 'https://cn.vuejs.org',
        time: '4 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/b6a811873e704db49db994053a5019b2.jpg'
      },
      {
        id: 3,
        title: 'Vuex',
        url: 'https://vuex.vuejs.org',
        time: '12 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
      },
      {
        id: 4,
        title: 'Vue Router',
        url: 'https://vuex.vuejs.org',
        time: '14 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg'
      },
      {
        id: 5,
        title: 'Sass',
        url: 'https://www.sass.hk',
        time: '10 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
      },
      {
        id: 6,
        title: 'Axios',
        url: 'http://www.axios-js.com',
        time: '16 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/faa0202700ee455b90fe77d8bef98bc0.jpg'
      },
      {
        id: 7,
        title: 'Webpack',
        url: 'https://www.webpackjs.com',
        time: '6 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/d3519518b00d42d3936b2ab5ce3a4cc3.jpg'
      },
      {
        id: 8,
        title: 'Node.js',
        url: 'https://nodejs.org/',
        time: '8 小时前',
        cover:
          'https://cdn.eleadmin.com/20200609/fe9196dd091e438fba115205c1003ee7.jpg'
      }
    ];
  };

  query();
</script>

<script>
  export default {
    name: 'ListCardApplication'
  };
</script>

<style lang="scss" scoped>
  .list-item-footer {
    display: flex;
    align-items: center;

    .list-item-tool {
      flex: 1;
      display: flex;
      justify-content: center;
      transition: color 0.2s;
      box-sizing: border-box;
      font-size: 16px;
      padding: 16px 0;
      cursor: pointer;

      .list-item-tool-trigger {
        width: 100%;
        padding: 16px 0;
        box-sizing: border-box;
        display: flex;
        justify-content: center;
        outline: none;
      }

      &:hover {
        color: var(--el-color-primary);

        .list-item-tool-trigger {
          color: var(--el-color-primary);
        }
      }
    }
  }
</style>
