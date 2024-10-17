<template>
  <ele-page>
    <ele-card header="基础用法">
      <ele-steps
        :active="active"
        finish-status="success"
        :items="[
          { title: '第一步', description: '填写转账信息' },
          { title: '第二步', description: '确认转账信息' },
          { title: '第三步', description: '转账成功' }
        ]"
        :align-center="!!alignCenter"
      />
      <div style="margin-top: 28px; display: flex; align-items: center">
        <el-button @click="onPrev">上一步</el-button>
        <el-button type="primary" @click="onNext">下一步</el-button>
        <div style="margin-left: 12px">
          <el-checkbox v-model="alignCenter" :true-label="1" :false-label="0">
            居中
          </el-checkbox>
        </div>
      </div>
    </ele-card>
    <ele-card header="紧凑版">
      <ele-steps
        :active="active"
        finish-status="success"
        type="inline"
        :items="[
          { title: '第一步', description: '填写转账信息' },
          { title: '第二步', description: '确认转账信息' },
          { title: '第三步', description: '转账成功' }
        ]"
      />
    </ele-card>
    <ele-card header="竖直方向">
      <div style="height: 320px">
        <ele-steps
          :active="active"
          finish-status="success"
          direction="vertical"
          :items="[
            { title: '第一步', description: '填写转账信息' },
            { title: '第二步', description: '确认转账信息' },
            { title: '第三步', description: '转账成功' }
          ]"
        />
      </div>
    </ele-card>
    <ele-card header="带图标紧凑版">
      <div style="margin-bottom: 28px">
        <el-button @click="onPrev">上一步</el-button>
        <el-button type="primary" @click="onNext">下一步</el-button>
      </div>
      <ele-steps
        :active="active"
        type="inline"
        :items="[
          { title: '账号注册', icon: User },
          { title: '邮箱验证', icon: Message },
          { title: '注册完成', icon: CircleCheck }
        ]"
        :style="{
          '--ele-step-icon-size': '24px',
          '--ele-step-line-height': '24px'
        }"
      />
    </ele-card>
    <ele-card header="带图标居中版">
      <ele-steps
        :active="active"
        :align-center="true"
        :items="[
          { title: '账号注册', icon: User },
          { title: '邮箱验证', icon: Message },
          { title: '注册完成', icon: CircleCheck }
        ]"
        :style="{
          '--ele-step-icon-size': '24px',
          '--ele-step-line-height': '24px'
        }"
      />
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { User, Message, CircleCheck } from '@element-plus/icons-vue';

  // 选中步骤
  const active = ref(0);

  // 居中
  const alignCenter = ref(0);

  /* 上一步 */
  const onPrev = () => {
    if (active.value < 1) {
      active.value = 3;
      return;
    }
    active.value = active.value - 1;
  };

  /* 下一步 */
  const onNext = () => {
    if (active.value > 2) {
      active.value = 0;
      return;
    }
    active.value = active.value + 1;
  };
</script>

<script>
  export default {
    name: 'ExtensionSteps'
  };
</script>
