<!-- 模板数量 -->
<template>
  <ele-card :header="title" :body-style="{ height: '370px' }">
    <template #extra>
      <more-icon @command="onCommand" />
    </template>
    <div class="workplace-goal">
      <div id="echarts-main" style="width: 100%;height:100%;"></div><!-- 内容 -->
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
import { TooltipComponent, LegendComponent } from 'echarts/components';
import { PieChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
  TooltipComponent,
  LegendComponent,
  PieChart,
  CanvasRenderer,
  LabelLayout
]);

let myChart = null;

onMounted(() => {
  const chartDom = document.getElementById('echarts-main');
  if (chartDom) {
    myChart = echarts.init(chartDom);

    const option = {
      tooltip: {
        trigger: 'item'
      },
      legend: {
        top: '5%',
        left: 'center'
      },
      series: [
        {
          name: '模板数量',
          type: 'pie',
          radius: ['40%', '70%'],
          center: ['50%', '70%'],
          startAngle: 180,
          endAngle: 360,
          data: [
            { value: 10, name: '官方模板' },
            { value: 120, name: '用户模板' }
          ]
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
