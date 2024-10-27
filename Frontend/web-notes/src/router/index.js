import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';
import NoteContentLayout from '@/views/NoteContent.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Layout,
      redirect: '/:id',
      children: [
        {
          path: '/:id',
          component: () => import('../views/indexView.vue')
        },
        {
          path: '/:id/:id',
          component: NoteContentLayout,
          children: [
            {
              path: '/:id/:id',
              component: () => import('../views/hello.vue')
            },
          ]
        },
        {
          path: '/vip',
          component: () => import('../views/vipView.vue')
        },
        {
          path: '/template',
          component: () => import('../views/templateView.vue')
        },
        {
          path: '/file',
          component: () => import('@/views/world.vue')
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
