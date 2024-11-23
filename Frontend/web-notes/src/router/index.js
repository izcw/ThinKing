import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';
import NoteLayout from '@/views/note/index.vue';
import LoginLayout from '@/views/login/index.vue';
import { setPageTitle } from '@/utils/page-title-util';
import { getToken } from '@/utils/token-util'; // 用于获取 token

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
          path: '/:spaceId',
          component: () => import('../views/index/index.vue'),
          meta: { title: '空间详情' },
        },
        {
          path: '/:spaceId/:noteId',
          component: NoteLayout,
          meta: { title: '笔记详情' },
          children: [
            {
              path: 'edit',
              component: () => import('../views/note/components/hello.vue'),
              meta: { title: '编辑笔记' },
            },
          ],
        },
        {
          path: '/vip',
          component: () => import('../views/subscribe/index.vue'),
          meta: { title: 'VIP 订阅' },
        },
        {
          path: '/template',
          component: () => import('../views/template/index.vue'),
          meta: { title: '模板中心' },
        },
      ],
    },
    {
      path: '/login',
      name: 'loginLayout',
      component: LoginLayout,
      meta: { title: '登录' },
      children: [
        {
          path: '',
          name: 'login',
          component: () => import('../views/login/components/loginForm.vue'),
          meta: { title: '用户' },
        },
        {
          path: '/register',
          name: 'register',
          component: () => import('../views/login/components/registerForm.vue'),
          meta: { title: '用户' },
        },
      ],
    },
  ],
});



router.beforeEach((to, from, next) => {
  const token = getToken();

  // 动态设置页面标题
  if (to.meta.title) {
    setPageTitle(to.meta.title);
  }

  // 路由守卫逻辑
  if (to.path === '/login' || to.path === '/register') {
    next();
  } else if (!token) {
    next({ path: '/login' });
  } else {
    next();
  }
});

export default router;
