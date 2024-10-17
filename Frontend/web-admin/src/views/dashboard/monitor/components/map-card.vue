<template>
  <ele-card header="用户分布">
    <el-row>
      <el-col :sm="18" :xs="24">
        <v-chart
          ref="userMapChartRef"
          :option="userCountMapOption"
          style="height: 468px"
        />
      </el-col>
      <el-col :sm="6" :xs="24">
        <div
          v-for="item in userCountDataRank"
          :key="item.name"
          class="user-item"
        >
          <div>{{ item.name }}</div>
          <div class="user-item-body">
            <el-progress
              :stroke-width="8"
              :show-text="false"
              :percentage="item.percent"
            />
          </div>
          <div>{{ item.value }}</div>
        </div>
      </el-col>
    </el-row>
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { use, registerMap } from 'echarts/core';
  import { CanvasRenderer } from 'echarts/renderers';
  import { MapChart } from 'echarts/charts';
  import {
    VisualMapComponent,
    GeoComponent,
    TooltipComponent
  } from 'echarts/components';
  import VChart from 'vue-echarts';
  import { getChinaMapData, getUserCountList } from '@/api/dashboard/monitor';
  import { useEcharts } from '@/utils/use-echarts';

  use([
    CanvasRenderer,
    MapChart,
    VisualMapComponent,
    GeoComponent,
    TooltipComponent
  ]);

  //
  const userMapChartRef = ref(null);

  useEcharts([userMapChartRef]);

  // 用户分布前 10 名
  const userCountDataRank = ref([]);

  // 用户分布地图配置
  const userCountMapOption = reactive({});

  /* 获取中国地图数据并注册地图 */
  const registerChinaMap = () => {
    getChinaMapData()
      .then((data) => {
        registerMap('china', data);
        getUserCountData();
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  /* 获取用户分布数据 */
  const getUserCountData = () => {
    getUserCountList()
      .then((data) => {
        const temp = data.sort((a, b) => b.value - a.value);
        const min = temp[temp.length - 1].value || 0;
        const max = temp[0].value || 1;
        //
        const list = temp.length > 10 ? temp.slice(0, 15) : temp;
        userCountDataRank.value = list.map((d) => {
          return {
            name: d.name,
            value: d.value,
            percent: (d.value / max) * 100
          };
        });
        //
        Object.assign(userCountMapOption, {
          tooltip: {
            trigger: 'item',
            borderWidth: 1
          },
          visualMap: {
            min: min,
            max: max,
            text: ['高', '低'],
            calculable: true,
            bottom: 10
          },
          series: [
            {
              name: '用户数',
              label: {
                show: true
              },
              type: 'map',
              map: 'china',
              data: data
            }
          ]
        });
      })
      .catch((e) => {
        EleMessage.error(e.message);
      });
  };

  registerChinaMap();
</script>

<style lang="scss" scoped>
  .user-item {
    display: flex;
    align-items: center;
    margin-bottom: 8px;

    .user-item-body {
      flex: 1;
      padding: 0 10px 0 12px;
    }

    :deep(.el-progress-bar__outer) {
      background-color: transparent;
    }
  }
</style>
