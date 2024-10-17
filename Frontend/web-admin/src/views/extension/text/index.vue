<template>
  <ele-page>
    <ele-card header="单行文本省略">
      <option-item label="提示风格">
        <el-radio-group v-model="tooltip">
          <el-radio :label="1">原生</el-radio>
          <el-radio :label="2">Tooltip</el-radio>
          <el-radio :label="3">关闭</el-radio>
        </el-radio-group>
      </option-item>
      <div style="width: 520px; max-width: 100%; margin-top: 8px">
        <ele-ellipsis :tooltip="tooltipProps">
          文本省略组件 `ele-ellipsis` 支持单行和多行省略,
          当鼠标移入时会提示全部内容, 且支持使用 Tooltip 组件进行提示.
        </ele-ellipsis>
      </div>
    </ele-card>
    <ele-card header="多行文本省略">
      <option-item label="最大行数">
        <el-radio-group v-model="maxLine">
          <el-radio :label="2">2</el-radio>
          <el-radio :label="3">3</el-radio>
          <el-radio :label="4">4</el-radio>
        </el-radio-group>
      </option-item>
      <div style="width: 520px; max-width: 100%; margin-top: 8px">
        <ele-ellipsis :tooltip="tooltipProps" :max-line="maxLine">
          文本省略组件 `ele-ellipsis` 支持单行和多行省略,
          当鼠标移入时会提示全部内容, 且支持使用 Tooltip 组件进行提示,
          并且支持设置 Tooltip 组件的其它属性, 如提示位置和主题等,
          还可以单独设置提示的内容与展示的内容完全不一样,
          默认会获取展示的文本内容为提示内容.
        </ele-ellipsis>
      </div>
    </ele-card>
    <ele-card header="文本组件">
      <div style="line-height: 1.8">
        <ele-text>EleAdmin Plus</ele-text>
        <ele-text type="secondary">EleAdmin Plus (secondary)</ele-text>
        <ele-text type="placeholder">EleAdmin Plus (placeholder)</ele-text>
        <ele-text type="heading">EleAdmin Plus (heading)</ele-text>
        <ele-text type="primary">EleAdmin Plus (primary)</ele-text>
        <ele-text type="success">EleAdmin Plus (success)</ele-text>
        <ele-text type="warning">EleAdmin Plus (warning)</ele-text>
        <ele-text type="danger">EleAdmin Plus (danger)</ele-text>
        <ele-text type="info">EleAdmin Plus (info)</ele-text>
        <ele-text deleted>EleAdmin Plus (deleted)</ele-text>
        <ele-text underline>EleAdmin Plus (underline)</ele-text>
        <ele-text deleted underline>EleAdmin Plus (deleted underline)</ele-text>
        <ele-text strong>EleAdmin Plus (strong)</ele-text>
        <ele-text italic>EleAdmin Plus (italic)</ele-text>
      </div>
    </ele-card>
    <ele-card header="可复制">
      <div>
        <ele-copyable>This is a copyable text.</ele-copyable>
      </div>
      <div style="margin-top: 8px">
        <ele-copyable style="width: 100%; max-width: 520px">
          <ele-ellipsis :tooltip="tooltipProps">
            文本省略组件 `ele-ellipsis` 支持单行和多行省略,
            当鼠标移入时会提示全部内容, 且支持使用 Tooltip 组件进行提示.
          </ele-ellipsis>
        </ele-copyable>
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, computed } from 'vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 提示风格
  const tooltip = ref(1);

  // 最大行数
  const maxLine = ref(2);

  // tooltip属性
  const tooltipProps = computed(() => {
    if (tooltip.value === 3) {
      return false;
    }
    return {
      original: tooltip.value === 1,
      popperStyle: {
        width: '420px',
        maxWidth: 'calc(100vw - 32px)'
      }
    };
  });
</script>

<script>
  export default {
    name: 'ExtensionText'
  };
</script>
