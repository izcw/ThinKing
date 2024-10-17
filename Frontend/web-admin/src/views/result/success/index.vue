<template>
  <ele-page :multi-card="false">
    <ele-card>
      <el-result icon="success" title="提交成功">
        <template #sub-title>
          <ele-text type="placeholder">
            提交结果页用于反馈一系列操作任务的处理结果，灰色区域可以显示一些补充的信息。
          </ele-text>
        </template>
      </el-result>
      <div style="text-align: center">
        <el-space size="large">
          <el-button type="primary">返回列表</el-button>
          <el-button>查看项目</el-button>
          <el-button>打印</el-button>
        </el-space>
      </div>
      <div
        style="
          max-width: 740px;
          padding: 20px 32px;
          background: hsla(0, 0%, 60%, 0.1);
          border-radius: 4px;
          margin: 26px auto;
        "
      >
        已提交申请，等待部门审核。
      </div>
    </ele-card>
  </ele-page>
</template>

<script>
  export default {
    name: 'ResultSuccess'
  };
</script>
