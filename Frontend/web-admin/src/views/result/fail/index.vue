<template>
  <ele-page :multi-card="false">
    <ele-card>
      <el-result icon="error" title="提交失败">
        <template #sub-title>
          <ele-text type="placeholder">
            请核对并修改以下信息后，再重新提交。
          </ele-text>
        </template>
      </el-result>
      <div style="text-align: center">
        <el-space size="large">
          <el-button type="primary">返回修改</el-button>
          <el-button>重新提交</el-button>
        </el-space>
      </div>
      <div
        style="
          max-width: 760px;
          padding: 20px 32px;
          background: hsla(0, 0%, 60%, 0.1);
          border-radius: 4px;
          margin: 26px auto;
        "
      >
        <div>您提交的内容有如下错误:</div>
        <el-space style="width: 100%; margin-top: 12px" wrap>
          <ele-text type="danger" :icon="CircleClose" />
          <div>您的账户已被冻结</div>
          <el-link type="primary" :underline="false">
            <span>立即解冻</span>
            <el-icon :size="14">
              <arrow-right />
            </el-icon>
          </el-link>
        </el-space>
        <el-space style="width: 100%; margin-top: 12px" wrap>
          <ele-text type="danger" :icon="CircleClose" />
          <div>您的账户还不具备申请资格</div>
          <el-link type="primary" :underline="false">
            <span>立即升级</span>
            <el-icon :size="14">
              <arrow-right />
            </el-icon>
          </el-link>
        </el-space>
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { CircleClose, ArrowRight } from '@element-plus/icons-vue';
</script>

<script>
  export default {
    name: 'ResultFail'
  };
</script>
