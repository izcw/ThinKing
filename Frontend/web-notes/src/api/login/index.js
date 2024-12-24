import { setToken, removeToken } from '@/utils/token-util';
import service from '@/utils/request';
import router from '@/router';
import { useUserStore } from '@/stores/modules/user'

// 注册
export async function postRegister(data) {
  const res = await service.post('/note/register', data);
  if (res.code === 200) {
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}

// 登录
export async function Userlogin(data) {
  const res = await service.post('/note/login', data);
  if (res.code === 200) {
    setToken(res.data?.tokenValue, true);
  }
  return res;
  // return Promise.reject(new Error(res.message));
}

// 获邮箱验证码
export function getEmailCode(params) {
  return service.get('/email/sendEmailCode', { params });
}

// 验证邮箱验证码
export function postVerifyEmailCode(data) {
  return service.post('/email/verifyEmailCode', data);
}


// 获取图片验证码
export function getVerifyCode() {
  return service.get('/verify/getcode');
}

// 验证图片验证码
export function postCheckVerifyCode(data) {
  return service.post('/verify/checkcode', data);
}


// 退出登录
export async function logoutToken() {
  const res = await service.post('/note/logout');
  if (res.code === 200) {
    let store = useUserStore()

    router.push('/login');
    removeToken();
    store.userInfoData = null
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}