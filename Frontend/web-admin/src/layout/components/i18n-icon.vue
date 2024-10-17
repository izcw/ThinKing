<!-- 国际化语言切换 -->
<template>
  <ele-dropdown
    :items="[
      { title: '简体中文', command: 'zh_CN' },
      { title: 'English', command: 'en' }
    ]"
    :model-value="locale"
    :placement="placement"
    :menu-style="{ minWidth: '108px' }"
    :popper-options="{
      modifiers: [{ name: 'offset', options: { offset: [0, 5] } }]
    }"
    style="line-height: inherit"
    @command="changeLanguage"
  >
    <div
      :style="{
        height: '100%',
        display: 'flex',
        alignItems: 'center',
        outline: 'none'
      }"
    >
      <slot>
        <el-icon>
          <global-outlined :style="iconStyle" />
        </el-icon>
      </slot>
    </div>
  </ele-dropdown>
</template>

<script setup>
  import { useI18n } from 'vue-i18n';
  import { GlobalOutlined } from '@/components/icons';
  import { setCacheLang } from '@/i18n/use-locale';

  defineProps({
    // placement
    placement: {
      type: String,
      default: 'bottom'
    },
    // 自定义样式
    iconStyle: Object
  });

  const { locale } = useI18n();

  /* 切换语言 */
  const changeLanguage = (command) => {
    locale.value = command;
    setCacheLang(command);
  };
</script>
