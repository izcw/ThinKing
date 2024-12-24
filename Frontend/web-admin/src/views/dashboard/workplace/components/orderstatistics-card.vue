<template>
  <ele-card :header="title" :body-style="{ height: '370px' }">
    <template #extra>
      <more-icon @command="onCommand" />
    </template>
    <div class="workplace-goal">
      <div id="order-echarts-main" style="width: 100%; height: 100%;"></div>
    </div>
  </ele-card>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import MoreIcon from './more-icon.vue';
import { PageSubscribeOrderALL } from '@/api/note/order/index';

// 定义响应式数据
let orderData = ref([]);

// 获取订单数据
PageSubscribeOrderALL()
  .then((data) => {
    console.log("获取订单数据", data);
    orderData.value = data;
    updateChartData(); // 数据更新后调用图表更新
  })
  .catch((e) => {
    console.log("错误", e);
  });

// 接收 props
defineProps({
  title: String
});

// 定义事件
const emit = defineEmits(['command']);
const onCommand = (command) => {
  emit('command', command);
};

// ECharts 配置导入
import * as echarts from 'echarts/core';
import { TooltipComponent, GridComponent } from 'echarts/components';
import { BarChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';

// 注册 ECharts 组件
echarts.use([
  TooltipComponent,
  GridComponent,
  BarChart,
  CanvasRenderer
]);

let myChart = null;

// 用于存储图表数据
let chartData = {
  xAxisData: [],
  seriesData: []
};

// 数据处理函数：按月份聚合支付金额，并且只显示今年的数据
const updateChartData = () => {
  const monthlyData = {};
  const currentYear = new Date().getFullYear(); // 获取当前年份

  // 统计每个月的支付总额，确保只统计今年的订单
  orderData.value.forEach((order) => {
    const orderDate = new Date(order.create_time);
    const orderYear = orderDate.getFullYear();
    const orderMonth = orderDate.getMonth(); // 获取月份

    // 只处理今年的数据
    if (orderYear === currentYear) {
      const monthStr = `${orderMonth + 1}月`; // 月份（1-12）

      if (!monthlyData[monthStr]) {
        monthlyData[monthStr] = 0;
      }
      monthlyData[monthStr] += order.price; // 累加该月的支付金额
    }
  });

  // 按月份顺序填充数据，确保是1月到12月的顺序
  chartData.xAxisData = [];
  chartData.seriesData = [];

  for (let month = 0; month < 12; month++) {
    const monthStr = `${month + 1}月`;
    chartData.xAxisData.push(monthStr);
    chartData.seriesData.push(monthlyData[monthStr] || 0); // 如果该月没有数据，则填0
  }

  // 调用渲染图表函数
  renderChart();
};

// 渲染 ECharts 图表
const renderChart = () => {
  const option = {
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow'
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: [
      {
        type: 'category',
        data: chartData.xAxisData, // 使用月份数据
        axisTick: {
          alignWithLabel: true
        }
      }
    ],
    yAxis: [
      {
        type: 'value'
      }
    ],
    series: [
      {
        name: '金额',
        type: 'bar',
        barWidth: '60%',
        data: chartData.seriesData // 使用支付金额数据
      }
    ]
  };

  // 如果图表实例存在，更新图表
  if (myChart) {
    myChart.setOption(option);
  }
};

// ECharts 容器初始化
onMounted(() => {
  const chartDom = document.getElementById('order-echarts-main');
  if (chartDom) {
    myChart = echarts.init(chartDom); // 初始化图表
    // 添加窗口大小变化监听器，确保图表自适应
    window.addEventListener('resize', resizeChart);
  } else {
    console.error('ECharts DOM 元素未找到');
  }
});

// 销毁 ECharts 实例和移除事件监听
onBeforeUnmount(() => {
  if (myChart) {
    myChart.dispose();
  }
  window.removeEventListener('resize', resizeChart);
});

// 自适应调整图表大小
const resizeChart = () => {
  if (myChart) {
    myChart.resize();
  }
};
</script>

<style lang="scss" scoped>
.workplace-goal {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;

  #order-echarts-main {
    width: 100%;
    height: 100%;
  }
}
</style>
