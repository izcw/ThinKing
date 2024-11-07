import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';
import NoteContentLayout from '@/views/NoteContent.vue';
import LoginLayout from '@/views/login/index.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Layout,
      redirect: '/1',
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
      name: 'loginLayout',
      component: LoginLayout,
      children: [
        {
          path: '',
          name: 'login',
          component: () => import('../views/login/components/loginForm.vue'),
        },
        {
          path: '/register',
          name: 'register',
          component: () => import('../views/login/components/registerForm.vue'),
        }
      ]
    }
  ]
});

export default router;
