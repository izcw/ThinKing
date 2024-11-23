import { setToken } from '@/utils/token-util';
import { get, post } from '@/utils/request';

// 注册
export async function postRegister(data) {
  const res = await post('/note/register', data);
  console.log("注册" + res);

  if (res.data.code === 200) {
    setToken(res.data.data?.tokenValue, data.remember);
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

// 登录
export async function Userlogin(data) {
  const res = await post('/note/login', data);
  console.log("登录" );
  console.log(res);
  
  if (res.code === 200) {
    setToken(res.data?.tokenValue, true);
    return res.message;
  }
  // return Promise.reject(new Error(res.data.message));
}

// 获邮箱验证码
export function getEmailCode(data) {
  return get('/note/sendVerificationCode', data);
}

// 验证邮箱验证码
export function postVerifyEmailCode(data) {
  return post('/verifyEmailCode', data);
}


// 获取图片验证码
export function getVerifyCode() {
  return get('/verify/getcode');
}

// 验证图片验证码
export function postCheckVerifyCode(data) {
  return post('/verify/checkcode', data);
}
