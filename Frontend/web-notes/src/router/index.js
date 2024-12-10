import { createRouter, createWebHistory } from 'vue-router';
import Layout from '@/layout/index.vue';
import NoteLayout from '@/layout/components/content/index.vue';
import LoginLayout from '@/views/login/index.vue';
import { setPageTitle } from '@/utils/page-title-util';
import { getToken } from '@/utils/token-util';
import { useUserStore } from '@/stores/modules/user';
import homepage from '@/views/homepage/index.vue'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/home',
      component: homepage,
      meta: { title: '' },
      children: [
        {
          path: '/home',
          name: 'home',
          component: () => import('@/views/homepage/components/box1.vue'),
          meta: { title: '' },
        },
        {
          path: '/share/:shareId',
          name: 'share',
          component: () => import('@/views/homepage/components/share.vue'),
          meta: { title: '分享' },
        },
      ]
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
      path: '/space/:spaceId',
      component: Layout,
      children: [
        {
          path: '/space/:spaceId',
          component: () => import('../views/index/index.vue'),
          meta: { title: '主页' },
        },
        {
          path: '/space/:spaceId/:pageId',
          component: NoteLayout,
          meta: { title: '笔记详情' },
        },
      ],
    },
  ],
});

router.beforeEach(async (to, from, next) => {
  // 将当前路由id存储到pinia
  const store = useUserStore();
  store.routerParamsId = to.params

  const publicRoutes = ['/login', '/register', '/home', '/share/:shareId', '/lock'];
  // 如果是公共路由或匹配 '/share/:shareId'，则直接放行
  if (publicRoutes.includes(to.path) || to.name === 'share') {
    next();
  } else {
    const token = getToken();

    if (token) {
      // 如果用户信息未获取，则获取用户信息
      if (!store.userInfoData) {
        await store.fetchUserInfo();
      }
      next();
    } else {
      next({ path: '/login' });
    }
  }
});


router.afterEach((to) => {
  // 动态设置页面标题，仅在导航完成后设置
  setPageTitle(to.meta.title);
});

export default router;