<template>
  <ele-card header="热门搜索">
    <v-chart
      ref="hotSearchChartRef"
      :option="hotSearchChartOption"
      style="height: 338px"
    />
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { use } from 'echarts/core';
  import { CanvasRenderer } from 'echarts/renderers';
  import { LineChart, BarChart } from 'echarts/charts';
  import { GridComponent, TooltipComponent } from 'echarts/components';
  import VChart from 'vue-echarts';
  import 'echarts-wordcloud';
  import { EleMessage } from 'ele-admin-plus/es';
  import { getWordCloudList } from '@/api/dashboard/analysis';
  import { useEcharts } from '@/utils/use-echarts';

  use([CanvasRenderer, LineChart, BarChart, GridComponent, TooltipComponent]);

  //
  const hotSearchChartRef = ref(null);

  useEcharts([hotSearchChartRef]);

  // 词云图表配置
  const hotSearchChartOption = reactive({});

  /* 获取词云数据 */
  const getWordCloudData = () => {
    getWordCloudList()
      .then((data) => {
        Object.assign(hotSearchChartOption, {
          tooltip: {
            show: true,
            confine: true,
            borderWidth: 1
          },
          series: [
            {
              type: 'wordCloud',
              width: '100%',
              height: '100%',
              sizeRange: [12, 24],
              gridSize: 6,
              textStyle: {
                color: () => {
                  const colors = [
                    '#025DF4',
                    '#DB6BCF',
                    '#2498D1',
                    '#BBBDE6',
                    '#4045B2',
                    '#21A97A',
                    '#FF745A',
                    '#007E99',
                    '#FFA8A8',
                    '#2391FF',
                    '#FFC328',
                    '#A0DC2C',
                    '#946DFF',
                    '#626681',
                    '#EB4185',
                    '#CD8150',
                    '#36BCCB',
                    '#327039',
                    '#803488',
                    '#83BC99'
                  ];
                  return colors[
                    Math.floor(
                      Math.random() * (0 - colors.length) + colors.length
                    )
                  ];
                }
              },
              emphasis: {
                textStyle: {
                  shadowBlur: 8,
                  shadowColor: 'rgba(0, 0, 0, .15)'
                }
              },
              data: data
            }
          ]
        });
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  // getWordCloudData();
</script>
