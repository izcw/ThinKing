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
      redirect: '/home', // 修改默认重定向到 /home
    },
    {
      path: '/home',
      name: 'home',
      component: () => import('../views/homepage/index.vue'),
      meta: { title: '' },
    },
    {
      path: '/lock',
      name: 'lock',
      component: () => import('../views/lockscreen/index.vue'),
      meta: { title: '锁屏' },
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
          meta: { title: '登录' },
        },
        {
          path: '/register',
          name: 'register',
          component: () => import('../views/login/components/registerForm.vue'),
          meta: { title: '注册' },
        },
      ],
    },
    {
      path: '/:spaceId',
      component: Layout,
      children: [
        {
          path: '',
          component: () => import('../views/index/index.vue'),
          meta: { title: '主页' },
        },
        {
          path: ':noteId',
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
  ],
});



router.beforeEach((to, from, next) => {
  const token = getToken();

  // 路由守卫逻辑
  if (to.path === '/login' || to.path === '/register' || to.path === '/home' || to.path === '/lock') {
    next();
  } else if (!token) {
    next({ path: '/login' });
  } else {
    next();
  }
});

router.afterEach((to) => {
  // 动态设置页面标题，仅在导航完成后设置
  setPageTitle(to.meta.title);
});


export default router;
