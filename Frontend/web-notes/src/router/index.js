import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/:id',
      name: 'home',
      component: Layout,
      children: [
        {
          path: '', // 这里使用空字符串，表示与父路径相同
          component: () => import('../views/NoteContent.vue')
        },
        {
          path: 'template', // 这里省略前面的/:id
          name: 'template',
          component: () => import('../views/templateView.vue')
        },
      ]
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/login/index.vue')
    }
  ]
});

export default router;
