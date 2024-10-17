<template>
  <div>
    <ele-card style="border-radius: 0">
      <ele-text type="heading" size="lg">分步表单</ele-text>
      <ele-text type="placeholder" style="margin-top: 6px">
        将一个冗长或用户不熟悉的表单任务分成多个步骤，指导用户完成。
      </ele-text>
    </ele-card>
    <ele-page>
      <ele-card class="step-card">
        <div style="max-width: 800px; margin: 0 auto; padding: 10px 0 16px 0">
          <ele-steps
            :active="active"
            finish-status="success"
            type="inline"
            :items="[
              { title: '第一步', description: '填写转账信息' },
              { title: '第二步', description: '确认转账信息' },
              { title: '第三步', description: '转账成功' }
            ]"
            style="margin: 0 0 30px 0"
          />
          <step-edit v-if="active === 0" @done="onDone" />
          <step-confirm
            v-if="active === 1"
            :data="form"
            @done="onNext"
            @back="onBack"
          />
          <step-success v-if="active === 2" :data="form" @back="onBack" />
        </div>
        <template v-if="active === 0">
          <el-divider style="margin: 0 0 26px 0; opacity: 0.6" />
          <ele-alert :closable="false">
            <ele-text size="lg" style="margin-bottom: 12px">说明</ele-text>
            <ele-text size="md" style="margin-bottom: 8px">
              转账到支付宝
            </ele-text>
            <ele-text style="margin-bottom: 12px">
              如果需要，这里可以放一些关于产品的常见问题说明。如果需要，
              这里可以放一些关于产品的常见问题说明。如果需要，这里可以放一些关于产品的常见问题说明。
            </ele-text>
            <ele-text size="md" style="margin-bottom: 8px">转账到微信</ele-text>
            <ele-text style="margin-bottom: 8px">
              如果需要，这里可以放一些关于产品的常见问题说明。如果需要，
              这里可以放一些关于产品的常见问题说明。如果需要，这里可以放一些关于产品的常见问题说明。
            </ele-text>
          </ele-alert>
        </template>
      </ele-card>
    </ele-page>
  </div>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import StepEdit from './components/step-edit.vue';
  import StepConfirm from './components/step-confirm.vue';
  import StepSuccess from './components/step-success.vue';

  // 选中步骤
  const active = ref(0);

  //
  const form = reactive({});

  //
  const onDone = (data) => {
    Object.assign(form, data);
    active.value = 1;
  };

  //
  const onNext = () => {
    active.value = 2;
  };

  //
  const onBack = () => {
    active.value = 0;
  };
</script>

<script>
  export default {
    name: 'FormStep'
  };
</script>

<style lang="scss" scoped>
  @media screen and (max-width: 768px) {
    .step-card :deep(.el-card__body) {
      padding: 4px 8px 16px 8px;

      .el-form {
        padding-right: 8px !important;
      }

      .el-result {
        padding: 0;

        .el-result__extra {
          max-width: 100%;
        }
      }
    }
  }
</style>
