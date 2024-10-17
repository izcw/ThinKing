<!-- markdown编辑器 -->
<template>
  <div ref="rootRef" class="ele-bytemd-wrap"></div>
</template>

<script setup>
  import { ref, watch, onMounted } from 'vue';
  import { Editor } from 'bytemd';
  import 'bytemd/dist/index.min.css';

  const props = defineProps({
    // 绑定值
    modelValue: {
      type: String,
      required: true
    },
    // 编辑器配置
    config: Object,
    // 高度
    height: String,
    // 全屏时的层级
    fullIndex: {
      type: Number,
      default: 999
    }
  });

  const emit = defineEmits(['update:modelValue', 'change']);

  // 编辑器实例
  let editor = null;

  // 根节点
  const rootRef = ref(null);

  // 渲染编辑器
  onMounted(() => {
    const ins = new Editor({
      target: rootRef.value,
      props: Object.assign({}, props.config, { value: props.modelValue })
    });
    ins.$on('change', (e) => {
      emit('update:modelValue', e.detail.value);
      emit('change', e.detail.value);
    });
    editor = ins;
  });

  // 更新配置
  watch(
    () => props.config,
    (config) => {
      const option = Object.assign({}, config);
      for (let key in option) {
        if (typeof option[key] === 'undefined') {
          delete option[key];
        }
      }
      editor?.$set(option);
    },
    { deep: true }
  );

  watch(
    () => props.modelValue,
    (value) => {
      editor?.$set({ value });
    }
  );

  defineExpose({ editor });
</script>

<style lang="scss" scoped>
  // 修改编辑器高度
  .ele-bytemd-wrap :deep(.bytemd) {
    height: v-bind(height);

    // 修改全屏的zIndex
    &.bytemd-fullscreen {
      z-index: v-bind(fullIndex);
    }

    // 去掉默认的最大宽度限制
    .CodeMirror .CodeMirror-lines {
      max-width: 100%;
    }

    pre.CodeMirror-line,
    pre.CodeMirror-line-like {
      padding: 0 24px;
    }

    .markdown-body {
      max-width: 100%;
      padding: 16px 24px;
    }

    // 去掉github图标
    .bytemd-toolbar-right > .bytemd-toolbar-icon:last-child {
      display: none;
    }
  }
</style>
