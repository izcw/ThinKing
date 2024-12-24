<!-- 统计卡片 -->
<template>
  <el-row :gutter="16">
    <el-col :md="12" :sm="12" :xs="24">
      <ele-card class="statistics-card">
        <ele-text type="placeholder" class="statistics-header">
          <div class="statistics-header-text">总销售额</div>
          <ele-tooltip content="指标说明" placement="top" :offset="6">
            <el-icon class="statistics-header-tip">
              <warning />
            </el-icon>
          </ele-tooltip>
        </ele-text>
        <ele-text size="xxl" class="statistics-value">¥ {{ totalSales }}</ele-text>
        <!-- <div class="statistics-body">
          <div class="statistics-trend-text">
            <div>周同比12%</div>
            <ele-text type="danger" :icon="CaretTop" />
          </div>
          <div class="statistics-trend-text">
            <div>日同比11%</div>
            <ele-text type="success" :icon="CaretBottom" />
          </div>
        </div> -->
        <el-divider />
        <div>今年总销售额 ￥ {{ yearlySales }}</div>
      </ele-card>
    </el-col>
    <el-col :md="12" :sm="12" :xs="24">
      <ele-card class="statistics-card">
        <ele-text type="placeholder" class="statistics-header">
          <div class="statistics-header-text">总支付笔数</div>
          <el-tag size="small" :disable-transitions="true">总</el-tag>
        </ele-text>
        <ele-text size="xxl" class="statistics-value">{{ orderData.length }}</ele-text>
        <!-- <v-chart ref="payNumChartRef" :option="payNumChartOption" style="height: 36px" /> -->
        <el-divider />
        <div>今年支付笔数 {{ yearlyOrderCount }}</div>
      </ele-card>
    </el-col>
    <!-- <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="statistics-card">
        <ele-text type="placeholder" class="statistics-header">
          <div class="statistics-header-text">访问量</div>
          <el-tag type="danger" size="small" :disable-transitions="true">
            日
          </el-tag>
        </ele-text>
        <ele-text size="xxl" class="statistics-value">8,846</ele-text>
        <v-chart
          ref="visitChartRef"
          :option="visitChartOption"
          style="height: 36px"
        />
        <el-divider />
        <div>日访问量 1,234</div>
      </ele-card>
    </el-col> -->

    <!-- <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="statistics-card">
        <ele-text type="placeholder" class="statistics-header">
          <div class="statistics-header-text">活动运营效果</div>
          <el-tag type="success" size="small" :disable-transitions="true">
            周
          </el-tag>
        </ele-text>
        <ele-text size="xxl" class="statistics-value">78%</ele-text>
        <div class="statistics-body">
          <el-progress
            color="#13c2c2"
            :percentage="78"
            :show-text="false"
            :stroke-width="8"
            style="width: 100%"
          />
        </div>
        <el-divider />
        <div class="statistics-footer">
          <div class="statistics-trend-text">
            <div>周同比12% </div>
            <ele-text type="danger" :icon="CaretTop" />
          </div>
          <div class="statistics-trend-text">
            <div>日同比11% </div>
            <ele-text type="success" :icon="CaretBottom" />
          </div>
        </div>
      </ele-card>
    </el-col> -->
  </el-row>
</template>

<script setup>
import { ref, reactive , computed } from 'vue';
import { Warning, CaretTop, CaretBottom } from '@element-plus/icons-vue';
import { EleMessage } from 'ele-admin-plus/es';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { LineChart, BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent } from 'echarts/components';
import VChart from 'vue-echarts';
import { getPayNumList } from '@/api/dashboard/analysis';
import { useEcharts } from '@/utils/use-echarts';
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

// 格式化数字为带千位分隔符的字符串
const formatNumber = (num) => {
  return new Intl.NumberFormat().format(num);
};

// 计算全部销售额
const totalSales = computed(() => {
  const total = orderData.value.reduce((sum, order) => sum + order.price, 0);
  return formatNumber(total); // 格式化为带千位分隔符的字符串
});

// 计算今年的销售额
const yearlySales = computed(() => {
  const currentYear = new Date().getFullYear(); // 获取当前年份
  const total = orderData.value.reduce((sum, order) => {
    const orderDate = new Date(order.create_time);
    const orderYear = orderDate.getFullYear();

    if (orderYear === currentYear) {
      return sum + order.price;
    }
    return sum;
  }, 0);
  return formatNumber(total); // 格式化为带千位分隔符的字符串
});


// 计算今年的订单数量
const yearlyOrderCount = computed(() => {
  const currentYear = new Date().getFullYear(); // 获取当前年份
  return orderData.value.filter((order) => {
    const orderDate = new Date(order.create_time);
    return orderDate.getFullYear() === currentYear;
  }).length; // 过滤出今年的订单并返回数量
});

// -----


use([CanvasRenderer, LineChart, BarChart, GridComponent, TooltipComponent]);

//
const visitChartRef = ref(null);

//
const payNumChartRef = ref(null);

useEcharts([visitChartRef, payNumChartRef]);

// 访问量折线图配置
const visitChartOption = reactive({});

// 支付笔数柱状图配置
const payNumChartOption = reactive({});

/* 获取支付笔数数据 */
const getPayNumData = () => {
  getPayNumList()
    .then((data) => {
      Object.assign(visitChartOption, {
        color: '#975fe5',
        tooltip: {
          trigger: 'axis',
          formatter: `<i style="background: #975fe5;
                                  width: 10px;
                                  height: 10px;
                                  margin-right: 5px;
                                  border-radius: 50%;
                                  display: inline-block;"
                        ></i>{b0}: {c0}`
        },
        grid: {
          top: 0,
          bottom: 0,
          left: 0,
          right: 0
        },
        xAxis: [
          {
            show: false,
            type: 'category',
            boundaryGap: false,
            data: data.map((d) => d.date)
          }
        ],
        yAxis: [
          {
            show: false,
            type: 'value',
            splitLine: {
              show: false
            }
          }
        ],
        series: [
          {
            type: 'line',
            smooth: true,
            symbol: 'none',
            areaStyle: {
              opacity: 0.5
            },
            data: data.map((d) => d.value)
          }
        ]
      });

      Object.assign(payNumChartOption, {
        tooltip: {
          trigger: 'axis',
          formatter: `<i style="background: #5b8ff9;
                                  width: 10px;
                                  height: 10px;
                                  margin-right: 5px;
                                  border-radius: 50%;
                                  display: inline-block;"
                        ></i>{b0}: {c0}`
        },
        grid: {
          top: 0,
          bottom: 0,
          left: 0,
          right: 0
        },
        xAxis: [
          {
            show: false,
            type: 'category',
            data: data.map((d) => d.date)
          }
        ],
        yAxis: [
          {
            show: false,
            type: 'value',
            splitLine: {
              show: false
            }
          }
        ],
        series: [
          {
            type: 'bar',
            data: data.map((d) => d.value)
          }
        ]
      });
    })
    .catch((e) => {
      EleMessage.error(e.message);
    });
};

// getPayNumData();
</script>

<style lang="scss" scoped>
.statistics-card {
  :deep(.el-card__body) {
    padding: 16px 22px 12px 22px;
  }

  :deep(.el-divider) {
    margin: 12px 0;
    opacity: 0.6;
  }

  .statistics-header {
    display: flex;
    align-items: center;

    .statistics-header-text {
      flex: 1;
    }

    .statistics-header-tip {
      font-size: 16px;
      cursor: help;
    }
  }

  .statistics-value {
    margin-top: 4px;
  }

  .statistics-body {
    height: 36px;
    display: flex;
    padding-top: 18px;
    box-sizing: border-box;
  }

  .statistics-trend-text {
    display: flex;
    align-items: center;
    white-space: nowrap;
    word-break: break-all;
    overflow: hidden;

    .el-icon {
      font-size: 16px;
      margin-left: 4px;
    }

    &+.statistics-trend-text {
      margin-left: 14px;
    }
  }

  .statistics-footer {
    display: flex;
    align-items: center;
  }
}
</style>
