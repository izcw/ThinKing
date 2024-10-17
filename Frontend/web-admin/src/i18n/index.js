/**
 * 国际化配置
 */
import { createI18n } from 'vue-i18n';
import { getCacheLang } from './use-locale';
import { zh_CN } from './lang/zh_CN';
import { en } from './lang/en';

const messages = { zh_CN, en };

const i18n = createI18n({
  messages,
  legacy: false,
  silentTranslationWarn: true,
  locale: getCacheLang()
});

export default i18n;
