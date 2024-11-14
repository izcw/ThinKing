<template>
  <ele-card :header-style="{ padding: '0 24px' }" :body-style="{ padding: 0 }">
    <template #header>
      <ele-tabs
        type="plain"
        size="large"
        v-model="saleSearch.type"
        :items="[
          { name: 'saleroom', label: '销售额' },
          { name: 'visits', label: '访问量' }
        ]"
        @tabChange="onSaleTypeChange"
      />
    </template>
    <template #extra>
      <div class="hidden-xs-only" style="display: flex; align-items: center">
        <el-radio-group v-model="saleSearch.dateType">
          <el-radio-button label="1">今天</el-radio-button>
          <el-radio-button label="2">本周</el-radio-button>
          <el-radio-button label="3">本月</el-radio-button>
          <el-radio-button label="4">本年</el-radio-button>
        </el-radio-group>
        <div class="hidden-md-and-down" style="width: 320px; margin-left: 12px">
          <el-date-picker
            unlink-panels
            type="datetimerange"
            v-model="saleSearch.datetime"
            range-separator="-"
            format="YYYY-MM-DD HH:mm"
            value-format="YYYY-MM-DD HH:mm"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            class="ele-fluid"
          />
        </div>
      </div>
    </template>
    <div class="sale-body">
      <el-row :gutter="16">
        <el-col :md="17" :sm="15" :xs="24">
          <div class="sale-body-title">
            {{ saleSearch.type === 'saleroom' ? '销售量趋势' : '访问量趋势' }}
          </div>
          <v-chart
            ref="saleChartRef"
            :option="saleChartOption"
            style="height: 320px"
          />
        </el-col>
        <el-col :md="7" :sm="9" :xs="24">
          <div v-if="saleSearch.type === 'saleroom'" style="padding: 0 0 8px 0">
            <div class="sale-body-title">门店销售额排名</div>
            <div
              v-for="(item, index) in saleroomRankData"
              :key="index"
              class="sale-rank-item"
            >
              <el-tag
                type="info"
                size="small"
                :disable-transitions="true"
                :effect="index < 3 ? 'dark' : 'light'"
                :color="index < 3 ? '#314659' : void 0"
                style="border: none; border-radius: 50%"
              >
                {{ index + 1 }}
              </el-tag>
              <ele-ellipsis class="sale-rank-item-text">
                {{ item.name }}
              </ele-ellipsis>
              <ele-text type="placeholder">{{ item.value }}</ele-text>
            </div>
          </div>
          <div v-else style="padding: 0 0 8px 0">
            <div class="sale-body-title">门店访问量排名</div>
            <div
              v-for="(item, index) in visitsRankData"
              :key="index"
              class="sale-rank-item"
            >
              <el-tag
                type="info"
                size="small"
                :disable-transitions="true"
                :effect="index < 3 ? 'dark' : 'light'"
                :color="index < 3 ? '#314659' : void 0"
                style="border: none; border-radius: 50%"
              >
                {{ index + 1 }}
              </el-tag>
              <ele-ellipsis class="sale-rank-item-text">
                {{ item.name }}
              </ele-ellipsis>
              <ele-text type="placeholder">{{ item.value }}</ele-text>
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { EleMessage } from 'ele-admin-plus';
  import { use } from 'echarts/core';
  import { CanvasRenderer } from 'echarts/renderers';
  import { BarChart } from 'echarts/charts';
  import { GridComponent, TooltipComponent } from 'echarts/components';
  import VChart from 'vue-echarts';
  import { getSaleroomList } from '@/api/dashboard/analysis';
  import { useEcharts } from '@/utils/use-echarts';

  use([CanvasRenderer, BarChart, GridComponent, TooltipComponent]);

  //
  const saleChartRef = ref(null);

  useEcharts([saleChartRef]);

  // 销售额柱状图配置
  const saleChartOption = reactive({});

  // 门店销售排名数据
  const saleroomRankData = ref([
    { name: '工专路 1 号店', value: '333,001' },
    { name: '工专路 2 号店', value: '333,002' },
    { name: '工专路 3 号店', value: '333,003' },
    { name: '工专路 4 号店', value: '333,004' },
    { name: '工专路 5 号店', value: '333,005' },
    { name: '工专路 6 号店', value: '333,006' },
    { name: '工专路 7 号店', value: '333,007' }
  ]);

  // 门店访问排名数据
  const visitsRankData = ref([
    { name: '工专路 1 号店', value: '222,001' },
    { name: '工专路 2 号店', value: '222,002' },
    { name: '工专路 3 号店', value: '222,002' },
    { name: '工专路 4 号店', value: '222,004' },
    { name: '工专路 5 号店', value: '222,005' },
    { name: '工专路 6 号店', value: '222,006' },
    { name: '工专路 7 号店', value: '222,007' }
  ]);

  // 销售量趋势数据
  const saleroomData1 = ref([]);

  // 访问量趋势数据
  const saleroomData2 = ref([]);

  // 销售量搜索参数
  const saleSearch = reactive({
    type: 'saleroom',
    dateType: '1',
    datetime: ['2022-01-01 10:44', '2022-01-03 13:00']
  });

  /* 获取销售量数据 */
  const getSaleroomData = () => {
    // getSaleroomList()
    //   .then((data) => {
    //     saleroomData1.value = data.list1;
    //     saleroomData2.value = data.list2;
    //     onSaleTypeChange();
    //   })
    //   .catch((e) => {
    //     EleMessage.error(e.message);
    //   });
  };

  /* 销售量tab选择改变事件 */
  const onSaleTypeChange = () => {
    if (saleSearch.type === 'saleroom') {
      Object.assign(saleChartOption, {
        tooltip: {
          trigger: 'axis'
        },
        xAxis: [
          {
            type: 'category',
            data: saleroomData1.value.map((d) => d.month)
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: [
          {
            type: 'bar',
            data: saleroomData1.value.map((d) => d.value)
          }
        ]
      });
    } else {
      Object.assign(saleChartOption, {
        tooltip: {
          trigger: 'axis'
        },
        xAxis: [
          {
            type: 'category',
            data: saleroomData2.value.map((d) => d.month)
          }
        ],
        yAxis: [
          {
            type: 'value'
          }
        ],
        series: [
          {
            type: 'bar',
            data: saleroomData2.value.map((d) => d.value)
          }
        ]
      });
    }
  };

  getSaleroomData();
</script>

<style lang="scss" scoped>
  .sale-body {
    padding: 16px 0 10px 0;
  }

  .sale-body-title {
    padding: 6px 20px;
  }

  .sale-rank-item {
    display: flex;
    align-items: center;
    padding: 0 20px;
    margin-top: 18px;
    box-sizing: border-box;

    .sale-rank-item-text {
      flex: 1;
      padding-left: 12px;
    }
  }
</style>
