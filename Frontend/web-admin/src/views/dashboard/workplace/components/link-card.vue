<!-- 快捷方式 -->
<template>
  <el-row :gutter="16" ref="wrapRef">
    <el-col v-for="item in data" :key="item.url" :md="3" :sm="6" :xs="12">
      <ele-card shadow="hover" :body-style="{ padding: 0 }">
        <router-link :to="item.url" class="app-link">
          <el-icon class="app-link-icon" :style="{ color: item.color }">
            <component :is="item.icon" />
          </el-icon>
          <div class="app-link-title">{{ item.title }}</div>
        </router-link>
      </ele-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import SortableJs from 'sortablejs';
const CACHE_KEY = 'workplace-links';

// 默认顺序
const DEFAULT = [
  {
    icon: 'user',
    title: '用户管理',
    url: '/customer/user'
  },
  {
    icon: 'Aim',
    title: '用户统计分析',
    url: '/customer/analysis',
    color: '#ff85c0'
  },
  {
    icon: 'handbag',
    title: '订单管理',
    url: '/order/orderlist',
    color: '#b37feb'
  },
  {
    icon: 'PieChart',
    title: '订单统计',
    url: '/order/statistics',
    color: '#95de64'
  },
  {
    icon: 'MostlyCloudy',
    title: '数据备份',
    url: '/data/databackup',
    color: '#ff9c6e'
  },

  {
    icon: 'Ticket',
    title: '套餐管理',
    url: '/subscribe/membership',
    color: '#5cdbd3'
  },
    {
    icon: 'Orange',
    title: '模版管理',
    url: '/templateplugin/template',
    color: '#ffd666'
  },
  {
    icon: 'operation',
    title: '配置',
    url: '/user/profile',
    color: '#ffc069'
  }
];

// 获取缓存的顺序
const cache = (() => {
  const str = localStorage.getItem(CACHE_KEY);
  try {
    return str ? JSON.parse(str) : null;
  } catch (e) {
    return null;
  }
})();

// 数据
const data = ref([...(cache ?? DEFAULT)]);

// 根节点
const wrapRef = ref(null);

// 排序实例
let sortableIns = null;

/* 重置布局 */
const reset = () => {
  data.value = [...DEFAULT];
  cacheData();
};

/* 缓存布局 */
const cacheData = () => {
  localStorage.setItem(CACHE_KEY, JSON.stringify(data.value));
};

onMounted(() => {
  if ('ontouchstart' in document.documentElement) {
    return;
  }
  sortableIns = new SortableJs(wrapRef.value?.$el, {
    animation: 300,
    onUpdate: ({ oldIndex, newIndex }) => {
      if (typeof oldIndex === 'number' && typeof newIndex === 'number') {
        const temp = [...data.value];
        temp.splice(newIndex, 0, temp.splice(oldIndex, 1)[0]);
        data.value = temp;
        cacheData();
      }
    },
    setData: () => { }
  });
});

onBeforeUnmount(() => {
  if (sortableIns) {
    sortableIns.destroy();
  }
});

defineExpose({ reset });
</script>

<script>
import {
  User,
  DataLine,
  Handbag,
  Tickets,
  Wallet,
  Message,
  PriceTag,
  Operation,
  Orange,
  Ticket,
  Coin,
  PieChart,
  MostlyCloudy,
  Aim
} from '@element-plus/icons-vue';

export default {
  components: {
    User,
    DataLine,
    Handbag,
    Tickets,
    Wallet,
    Message,
    PriceTag,
    Operation,
    Orange,
    Ticket,
    Coin,
    PieChart,
    MostlyCloudy,
    Aim
  }
};
</script>

<style lang="scss" scoped>
.app-link {
  padding: 12px;
  display: block;
  text-align: center;
  text-decoration: none;
  color: inherit;

  .app-link-icon {
    font-size: 30px;
    color: #69c0ff;
    margin: 6px 0 10px 0;
  }
}

.el-col.sortable-ghost {
  opacity: 0;
}
</style>
