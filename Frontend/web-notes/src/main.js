import './assets/css/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import naive from 'naive-ui'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'

import vClickOutside from 'v-click-outside'; // Vue 指令关闭对话框

import App from './App.vue'
import router from './router/index.js'

const app = createApp(App)
const pinia = createPinia()
app.use(pinia)
app.use(router)
app.use(naive)
app.use(ElementPlus)
app.directive('click-outside', vClickOutside);

app.mount('#app')
