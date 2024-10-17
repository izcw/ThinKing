/**
 * ElementPlus/EleAdminPlus/Dayjs国际化配置
 */
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRouter } from 'vue-router';
import { I18N_CACHE_NAME } from '@/config/setting';
import { setPageTitle } from '@/utils/page-title-util';
// ElementPlus
import zh_CN from 'element-plus/es/locale/lang/zh-cn';
import zh_TW from 'element-plus/es/locale/lang/zh-tw';
import en from 'element-plus/es/locale/lang/en';
// EleAdminPlus
import eleZh_CN from 'ele-admin-plus/es/lang/zh_CN';
import eleZh_TW from 'ele-admin-plus/es/lang/zh_TW';
import eleEn from 'ele-admin-plus/es/lang/en_US';
// Dayjs
import dayjs from 'dayjs';
import 'dayjs/locale/zh-cn';
import 'dayjs/locale/zh-tw';
const elLocales = { zh_CN, zh_TW, en };
const eleLocales = { zh_CN: eleZh_CN, zh_TW: eleZh_TW, en: eleEn };

export function useLocale() {
  const { currentRoute } = useRouter();
  const { locale } = useI18n();
  const elLocale = ref();
  const eleLocale = ref();

  watch(
    locale,
    () => {
      elLocale.value = elLocales[locale.value];
      eleLocale.value = eleLocales[locale.value];
      dayjs.locale(locale.value.toLowerCase().replace(/_/g, '-'));
      setPageTitle(getRouteTitle(currentRoute.value));
    },
    { immediate: true }
  );
  return { elLocale, eleLocale };
}

/**
 * 获取缓存的语言
 */
export function getCacheLang() {
  return localStorage.getItem(I18N_CACHE_NAME) || 'zh_CN';
}

/**
 * 获取缓存的语言
 */
export function setCacheLang(lang) {
  if (!lang) {
    localStorage.removeItem(I18N_CACHE_NAME);
    return;
  }
  localStorage.setItem(I18N_CACHE_NAME, lang);
}

/**
 * 获取路由对应的标题
 * @param route 路由
 */
export function getRouteTitle(route) {
  const lang = route.meta?.lang ?? {};
  return lang[getCacheLang()] ?? route.meta?.title;
}
