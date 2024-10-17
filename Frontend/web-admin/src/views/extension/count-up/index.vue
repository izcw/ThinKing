<template>
  <ele-page :multi-card="false">
    <ele-card header="基础用法">
      <ele-text size="xxl" style="padding: 0 0 16px 10px">
        <ele-count-up ref="countUpRef" :end-val="demoNum" :options="option" />
      </ele-text>
      <el-space>
        <el-button class="ele-btn-icon" @click="restart">重新开始</el-button>
        <el-button class="ele-btn-icon" @click="update">更新数字</el-button>
      </el-space>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, reactive } from 'vue';

  // 组件实例
  const countUpRef = ref(null);

  // 值
  const demoNum = ref(6317);

  // 配置
  const option = reactive({
    useEasing: true,
    useGrouping: true,
    separator: ',',
    decimal: '.',
    prefix: '',
    suffix: ''
  });

  /* 更新 */
  const update = () => {
    demoNum.value += 100 + Math.round(Math.random() * 300);
  };

  /* 重新开始 */
  const restart = () => {
    if (countUpRef.value) {
      countUpRef.value.reset();
      countUpRef.value.start();
    }
  };
</script>

<script>
  export default {
    name: 'ExtensionCountUp'
  };
</script>
