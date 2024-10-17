<!-- markdown解析 -->
<template>
  <!-- eslint-disable vue/no-v-html -->
  <div
    ref="rootRef"
    v-html="content"
    class="markdown-body"
    @click="handleClick"
  >
  </div>
</template>

<script setup>
  import { ref, watch, onMounted, onBeforeUnmount, nextTick } from 'vue';
  import { getProcessor } from 'bytemd';

  const props = defineProps({
    value: String,
    config: Object
  });

  // 根节点
  const rootRef = ref(null);

  // 解析后内容
  const content = ref(null);

  // 已绑定的插件
  const cbs = ref([]);

  // 绑定插件
  const on = () => {
    if (props.config?.plugins && rootRef.value && content.value) {
      cbs.value = props.config.plugins.map(({ viewerEffect }) => {
        return (
          viewerEffect &&
          viewerEffect({
            markdownBody: rootRef.value,
            file: content.value
          })
        );
      });
    }
  };

  // 解绑插件
  const off = () => {
    if (cbs.value) {
      cbs.value.forEach((cb) => cb && cb());
    }
  };

  // 处理点击事件支持锚点
  const handleClick = (e) => {
    const $ = e.target;
    if ($.tagName !== 'A') {
      return;
    }
    const href = $.getAttribute('href');
    if (!href || !href.startsWith('#')) {
      return;
    }
    const dest = rootRef.value?.querySelector('#user-content-' + href.slice(1));
    if (dest) {
      dest.scrollIntoView();
    }
  };

  // 解析
  watch(
    [() => props.value, () => props.config],
    () => {
      try {
        content.value = getProcessor(
          Object.assign({}, props.config)
        ).processSync(props.value);
      } catch (e) {
        console.error(e);
      }
      off();
      nextTick(() => {
        on();
      });
    },
    {
      immediate: true,
      deep: true
    }
  );

  onMounted(() => {
    on();
  });

  onBeforeUnmount(() => {
    off();
  });
</script>
