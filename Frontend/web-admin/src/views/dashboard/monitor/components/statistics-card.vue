<!-- 统计卡片 -->
<template>
  <el-row :gutter="16">
    <el-col :md="12" :sm="12" :xs="24">
      <ele-card class="monitor-count">
        <el-empty description="无" />
      </ele-card>
    </el-col>
    <!-- <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="monitor-count">
        <el-tag size="large" :disable-transitions="true">
          <el-icon>
            <user-filled />
          </el-icon>
        </el-tag>
        <ele-text size="xxl" class="monitor-count-value">21.2 k</ele-text>
        <ele-text type="placeholder" class="monitor-count-text">
          总访问人数
        </ele-text>
        <ele-avatar-group :data="visitUsers" size="small" :max-count="4" />
      </ele-card>
    </el-col>
    <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="monitor-count">
        <el-tag type="warning" size="large" :disable-transitions="true">
          <el-icon>
            <opportunity />
          </el-icon>
        </el-tag>
        <ele-text size="xxl" class="monitor-count-value">1.6 k</ele-text>
        <ele-text type="placeholder" class="monitor-count-text">
          点击量(近30天)
        </ele-text>
        <ele-text
          strong
          type="success"
          :icon="ArrowUpBold"
          class="monitor-count-trend"
        >
          &nbsp;110.5%
        </ele-text>
        <ele-tooltip content="指标说明" placement="top" :offset="3">
          <ele-text
            :icon="Warning"
            type="placeholder"
            class="monitor-count-tip"
          />
        </ele-tooltip>
      </ele-card>
    </el-col>
    <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="monitor-count">
        <el-tag type="danger" size="large" :disable-transitions="true">
          <el-icon>
            <flag />
          </el-icon>
        </el-tag>
        <ele-text size="xxl" class="monitor-count-value">826.0</ele-text>
        <ele-text type="placeholder" class="monitor-count-text">
          到达量(近30天)
        </ele-text>
        <ele-text
          strong
          type="danger"
          :icon="ArrowDownBold"
          class="monitor-count-trend"
        >
          &nbsp;15.5%
        </ele-text>
      </ele-card>
    </el-col>
    <el-col :md="6" :sm="12" :xs="24">
      <ele-card class="monitor-count">
        <el-tag type="success" size="large" :disable-transitions="true">
          <el-icon>
            <share />
          </el-icon>
        </el-tag>
        <ele-text size="xxl" class="monitor-count-value">28.8 %</ele-text>
        <ele-text type="placeholder" class="monitor-count-text">
          转化率(近30天)
        </ele-text>
        <ele-text
          strong
          type="success"
          :icon="ArrowUpBold"
          class="monitor-count-trend"
        >
          &nbsp;65.8%
        </ele-text>
        <ele-tooltip content="指标说明" placement="top" :offset="3">
          <ele-text
            :icon="Warning"
            type="placeholder"
            class="monitor-count-tip"
          />
        </ele-tooltip>
      </ele-card>
    </el-col> -->
  </el-row>
</template>

<script setup>
import { ref } from 'vue';
import {
  UserFilled,
  Opportunity,
  Flag,
  Share,
  Warning,
  ArrowUpBold,
  ArrowDownBold
} from '@element-plus/icons-vue';

// 访问人数
const visitUsers = ref([
  {
    key: 1,
    label: 'SunSmile',
    value:
      'https://cdn.eleadmin.com/20200609/c184eef391ae48dba87e3057e70238fb.jpg'
  },
  {
    key: 2,
    label: '你的名字很好听',
    value:
      'https://cdn.eleadmin.com/20200609/b6a811873e704db49db994053a5019b2.jpg'
  },
  {
    key: 3,
    label: '全村人的希望',
    value:
      'https://cdn.eleadmin.com/20200609/948344a2a77c47a7a7b332fe12ff749a.jpg'
  },
  {
    key: 4,
    label: 'Jasmine',
    value:
      'https://cdn.eleadmin.com/20200609/f6bc05af944a4f738b54128717952107.jpg'
  },
  {
    key: 5,
    label: '酷酷的大叔',
    value:
      'https://cdn.eleadmin.com/20200609/2d98970a51b34b6b859339c96b240dcd.jpg'
  },
  {
    key: 6,
    label: '管理员',
    value: 'https://cdn.eleadmin.com/20200610/avatar.jpg'
  }
]);
</script>

<style lang="scss" scoped>
.monitor-count {
  position: relative;
  text-align: center;

  .el-tag {
    width: 34px;
    height: 34px;
    line-height: 34px;
    border-radius: 50%;
    font-size: 15px;
    padding: 0;

    .el-icon {
      font-size: 16px;
      border-radius: 0;
      cursor: default;
    }

    :deep(.el-tag__content) {
      display: flex;
      align-items: center;
      justify-content: center;
    }
  }

  .monitor-count-value {
    margin-top: 8px;
  }

  .monitor-count-text {
    margin: 4px 0 8px 0;
  }

  .monitor-count-trend {
    line-height: 26px;
  }

  .monitor-count-tip {
    position: absolute;
    top: 16px;
    right: 16px;
    font-size: 16px;
    cursor: help;
  }
}
</style>
