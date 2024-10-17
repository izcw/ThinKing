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
        <ele-card
          shadow="hover"
          :body-style="{ padding: 0 }"
          style="margin-top: 16px; overflow: hidden; cursor: pointer"
        >
          <img :src="item.cover" style="width: 100%" />
          <div style="padding: 14px 24px 24px 24px">
            <ele-text size="md">{{ item.title }}</ele-text>
            <ele-ellipsis
              :max-line="2"
              type="placeholder"
              style="margin: 8px 0 16px 0"
            >
              {{ item.content }}
            </ele-ellipsis>
            <div style="display: flex; align-items: center">
              <ele-text type="placeholder" style="flex: 1">
                {{ item.time }}
              </ele-text>
              <ele-avatar-group
                size="small"
                :data="item.users"
                style="flex-shrink: 0"
              />
            </div>
          </div>
        </ele-card>
      </el-col>
    </el-row>
    <ele-pagination
      :total="count"
      v-model:page-size="limit"
      v-model:current-page="page"
      layout="prev, pager, next"
      prev-text="上一页"
      next-text="下一页"
      style="margin-top: 18px; justify-content: center"
    />
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import TopSearch from './components/top-search.vue';

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
        content:
          'Element, 一套为开发者、设计师和产品经理准备的基于 Vue 2.0 的组件库, 提供了配套设计资源, 帮助你的网站快速成型。',
        time: '2 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/RZ8FQmZfHkcffMlTBCJllBFjEhEsObVo.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 2,
        title: 'Vue.js',
        content:
          'Vue 是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是, Vue 被设计为可以自底向上逐层应用。',
        time: '4 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/WLXm7gp1EbLDtvVQgkeQeyq5OtDm00Jd.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 3,
        title: 'Vuex',
        content:
          'Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态, 并以相应的规则保证状态以一种可预测的方式发生变化。',
        time: '12 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/4Z0QR2L0J1XStxBh99jVJ8qLfsGsOgjU.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 4,
        title: 'Vue Router',
        content:
          'Vue Router 是 Vue.js 官方的路由管理器。它和 Vue.js 的核心深度集成, 让构建单页面应用变得易如反掌。',
        time: '14 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/ttkIjNPlVDuv4lUTvRX8GIlM2QqSe0jg.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 5,
        title: 'Sass',
        content: 'Sass 是世界上最成熟、稳定、强大的专业级 CSS 扩展语言。',
        time: '10 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/fAenQ8nvRjL7x0i0jEfuDBZHvJfHf3v6.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 6,
        title: 'Axios',
        content:
          'Axios 是一个基于 promise 的 HTTP 库, 可以用在浏览器和 node.js 中。',
        time: '16 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/LrCTN2j94lo9N7wEql7cBr1Ux4rHMvmZ.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 7,
        title: 'Webpack',
        content:
          'webpack 是一个模块打包器。webpack 的主要目标是将 JavaScript 文件打包在一起, 打包后的文件用于在浏览器中使用。',
        time: '6 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/yeKvhT20lMU0f1T3Y743UlGEOLLnZSnp.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      },
      {
        id: 8,
        title: 'Node.js',
        content:
          'Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境。Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型, 使其轻量又高效。',
        time: '8 小时前',
        cover:
          'https://cdn.eleadmin.com/20200610/CyrCNmTJfv7D6GFAg39bjT3eRkkRm5dI.jpg',
        users: [
          {
            label: 'SunSmile',
            value:
              'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
          },
          {
            label: '酷酷的大叔',
            value:
              'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
          },
          {
            label: 'Jasmine',
            value:
              'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
          }
        ]
      }
    ];
  };

  query();
</script>

<script>
  export default {
    name: 'ListCardProject'
  };
</script>
