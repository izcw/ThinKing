import { createApp } from 'vue';
import App from './App.vue';
import store from './store';
import router from './router';
import permission from './utils/permission';
import i18n from './i18n';
import installer from './as-needed';
import 'element-plus/theme-chalk/display.css';
import 'ele-admin-plus/es/style/nprogress.scss';
import './styles/themes/rounded.scss';
import './styles/themes/dark.scss';
import './styles/index.scss';
import "./assets/font/smiley-sans/font.css";


const app = createApp(App);

app.use(store);
app.use(router);
app.use(permission);
app.use(i18n);
app.use(installer);

app.mount('#app');
