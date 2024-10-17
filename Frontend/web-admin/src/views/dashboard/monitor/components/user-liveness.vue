<template>
  <ele-card header="用户活跃度" :body-style="{ padding: '64px 0' }">
    <div class="progress-body">
      <div class="progress-group">
        <el-progress
          type="circle"
          color="#52c41a"
          :percentage="70"
          :show-text="false"
          :stroke-width="8"
          :width="136"
        />
        <el-progress
          type="circle"
          color="#1890ff"
          :percentage="60"
          :show-text="false"
          :stroke-width="6"
          :width="98"
        />
        <el-progress
          type="circle"
          color="#f5222d"
          :percentage="35"
          :show-text="false"
          :stroke-width="4"
          :width="66"
        />
      </div>
      <div class="progress-legend">
        <div class="progress-legend-item">
          <ele-dot type="success" text="活跃率:70%" :ripple="false" />
        </div>
        <div class="progress-legend-item">
          <ele-dot text="留存率:60%" :ripple="false" />
        </div>
        <div class="progress-legend-item">
          <ele-dot type="danger" text="跳出率:35%" :ripple="false" />
        </div>
      </div>
    </div>
  </ele-card>
</template>

<style lang="scss" scoped>
  .progress-body {
    display: flex;
    align-items: center;
    justify-content: center;

    .progress-group {
      display: flex;
      flex-shrink: 0;
      position: relative;

      .el-progress:not(:first-child) {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
      }
    }

    .progress-legend {
      padding: 0 0 0 8px;
      flex-shrink: 0;

      .progress-legend-item {
        font-size: 12px;

        & + .progress-legend-item {
          margin-top: 8px;
        }

        :deep(.ele-dot-text) {
          margin-left: 6px;
        }
      }
    }
  }
</style>
