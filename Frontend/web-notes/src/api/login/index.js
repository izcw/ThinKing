import { setToken, removeToken } from '@/utils/token-util';
import { get, post } from '@/utils/request';
import router from '@/router';

// 注册
export async function postRegister(data) {
  const res = await post('/note/register', data);
  if (res.code === 201) {
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}

// 登录
export async function Userlogin(data) {
  const res = await post('/note/login', data);
  console.log("登录");
  console.log(res);

  if (res.code === 200) {
    setToken(res.data?.tokenValue, true);
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}

// 获邮箱验证码
export function getEmailCode(data) {
  return get('/email/sendEmailCode', data);
}

// 验证邮箱验证码
export function postVerifyEmailCode(data) {
  return post('/email/verifyEmailCode', data);
}


// 获取图片验证码
export function getVerifyCode() {
  return get('/verify/getcode');
}

// 验证图片验证码
export function postCheckVerifyCode(data) {
  return post('/verify/checkcode', data);
}


// 退出登录
export async function logoutToken() {
  const res = await post('/note/logout');
  if (res.code === 200) {
    router.push('/login');
    removeToken()
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}