<template>
  <el-config-provider :locale="elLocale">
    <ele-config-provider
      :map-key="MAP_KEY"
      :license="LICENSE_CODE"
      :locale="eleLocale"
    >
      <ele-app>
        <router-view />
      </ele-app>
    </ele-config-provider>
  </el-config-provider>
</template>

<script setup>
  import { useThemeStore } from '@/store/modules/theme';
  import { MAP_KEY, LICENSE_CODE } from '@/config/setting';
  import { useLocale } from '@/i18n/use-locale';

  // 恢复主题
  const themeStore = useThemeStore();
  themeStore.recoverTheme();

  // 国际化配置
  const { elLocale, eleLocale } = useLocale();
</script>
