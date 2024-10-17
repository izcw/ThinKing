<template>
  <ele-card header="用户评价">
    <div class="rate-header">
      <div class="rate-header-value">4.5</div>
      <div class="rate-header-level">
        <el-rate :model-value="userRate" disabled />
        <div class="rate-header-text">很棒</div>
      </div>
    </div>
    <ele-text type="placeholder" class="rate-body">
      <div class="rate-body-value">-0%</div>
      <div class="rate-body-text">当前没有评价波动</div>
    </ele-text>
    <div class="rate-item">
      <div class="rate-item-progress">
        <el-progress
          color="#52c41a"
          :percentage="60"
          :show-text="false"
          :stroke-width="8"
        />
      </div>
      <ele-text type="placeholder" :icon="StarFilled" class="rate-item-text">
        <span>5 : 368 人</span>
      </ele-text>
    </div>
    <div class="rate-item">
      <div class="rate-item-progress">
        <el-progress
          color="#1890ff"
          :percentage="40"
          :show-text="false"
          :stroke-width="8"
        />
      </div>
      <ele-text type="placeholder" :icon="StarFilled" class="rate-item-text">
        <span>4 : 256 人</span>
      </ele-text>
    </div>
    <div class="rate-item">
      <div class="rate-item-progress">
        <el-progress
          color="#faad14"
          :percentage="20"
          :show-text="false"
          :stroke-width="8"
        />
      </div>
      <ele-text type="placeholder" :icon="StarFilled" class="rate-item-text">
        <span>3 : 49 人</span>
      </ele-text>
    </div>
    <div class="rate-item">
      <div class="rate-item-progress">
        <el-progress
          color="#f5222d"
          :percentage="10"
          :show-text="false"
          :stroke-width="8"
        />
      </div>
      <ele-text type="placeholder" :icon="StarFilled" class="rate-item-text">
        <span>2 : 14 人</span>
      </ele-text>
    </div>
    <div class="rate-item">
      <div class="rate-item-progress">
        <el-progress :percentage="0" :show-text="false" :stroke-width="8" />
      </div>
      <ele-text type="placeholder" :icon="StarFilled" class="rate-item-text">
        <span>1 : 0 人</span>
      </ele-text>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { StarFilled } from '@element-plus/icons-vue';

  // 用户评分
  const userRate = ref(4.5);
</script>

<style lang="scss" scoped>
  .rate-header {
    display: flex;
    align-items: flex-end;

    .rate-header-value {
      line-height: 1;
      font-size: 50px;
    }

    .rate-header-level {
      flex: 1;
      display: flex;
      align-items: center;
      padding-left: 12px;
    }

    .rate-header-text {
      color: #f7ba2a;
      margin-left: 4px;
    }
  }

  .rate-body {
    display: flex;
    align-items: flex-end;
    margin: 18px 0;

    .rate-body-value {
      font-size: 28px;
      line-height: 1;
    }

    .rate-body-text {
      flex: 1;
      font-size: 12px;
      padding-left: 12px;
    }
  }

  .rate-item {
    display: flex;
    align-items: center;

    .rate-item-progress {
      flex: 1;
    }

    .rate-item-text {
      width: 90px;
      flex-shrink: 0;
      white-space: nowrap;
      display: flex;
      align-items: center;

      :deep(.el-icon) {
        font-size: 12px;
        margin: 0 6px 0 8px;
      }
    }
  }
</style>
