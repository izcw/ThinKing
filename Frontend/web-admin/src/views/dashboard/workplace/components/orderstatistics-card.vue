<!-- 模板数量 -->
<template>
  <ele-card :header="title" :body-style="{ height: '370px' }">
    <template #extra>
      <more-icon @command="onCommand" />
    </template>
    <div class="workplace-goal">
      <div id="order-echarts-main" style="width: 100%;height:100%;"></div><!-- 内容 -->
    </div>
  </ele-card>
</template>

<script setup>
import { onMounted, onBeforeUnmount } from 'vue';
import MoreIcon from './more-icon.vue';

defineProps({
  title: String
});

const emit = defineEmits(['command']);

const onCommand = (command) => {
  emit('command', command);
};


// ECharts 配置
import * as echarts from 'echarts/core';
import { TooltipComponent, LegendComponent, TitleComponent, ToolboxComponent, GridComponent, VisualMapComponent } from 'echarts/components';
import { PieChart, LineChart ,BarChart} from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
  TooltipComponent,
  LegendComponent,
  TitleComponent,
  ToolboxComponent,
  GridComponent,
  VisualMapComponent,
  LineChart,
  CanvasRenderer,
  LabelLayout,
  BarChart
]);

let myChart = null;

onMounted(() => {
  const chartDom = document.getElementById('order-echarts-main');
  if (chartDom) {
    myChart = echarts.init(chartDom);

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
          data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
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
          name: '支付笔数',
          type: 'bar',
          barWidth: '60%',
          data: [10, 52, 200, 334, 390, 330, 220]
        }
      ]
    };

    myChart.setOption(option);

    // 添加窗口大小变化监听器
    window.addEventListener('resize', resizeChart);
  } else {
    console.error('ECharts DOM 元素未找到');
  }
});

onBeforeUnmount(() => {
  // 移除监听器
  window.removeEventListener('resize', resizeChart);

  // 销毁 ECharts 实例
  if (myChart) {
    myChart.dispose();
  }
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

  .workplace-goal-body {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 180px;
    margin: -48px 0 0 -90px;
    text-align: center;
  }
}
</style>
