// 接口地址
export const API_BASE_URL = import.meta.env.VITE_API_URL;
export const FILE_PATH_API_URL = import.meta.env.VITE_API_URL + '/file_warehouse/';

// 官网链接
export const WEBSITE_LINK_URl = import.meta.env.VITE_WEBSITE_LINK;

// 项目名称
export const PROJECT_NAME = import.meta.env.VITE_APP_NAME;

// 不需要登录的路由
export const WHITE_LIST = ['/login', '/forget'];

// token本地缓存的名称
export const TOKEN_CACHE_NAME = 'token';

// 主题配置本地缓存的名称
export const THEME_CACHE_NAME = 'theme';

// i18n本地缓存的名称
export const I18N_CACHE_NAME = 'i18n-lang';
