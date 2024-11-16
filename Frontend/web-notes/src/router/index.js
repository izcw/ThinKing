import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';
import NoteLayout from '@/views/note/index.vue';
import LoginLayout from '@/views/login/index.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Layout,
      redirect: '/space1',
      children: [
        {
          path: '/:id',
          component: () => import('../views/index/index.vue')
        },
        {
          path: '/:id/:id',
          component: NoteLayout,
          children: [
            {
              path: '/:id/:id',
              component: () => import('../views/note/components/hello.vue')
            },
          ]
        },
        {
          path: '/vip',
          component: () => import('../views/subscribe/index.vue')
        },
        {
          path: '/template',
          component: () => import('../views/template/index.vue')
        }
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
