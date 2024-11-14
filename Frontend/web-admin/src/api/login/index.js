import request from '@/utils/request';
import { setToken } from '@/utils/token-util';

/**
 * 登录
 */
export async function login(data) {
  const res = await request.post('/system/login', data);
  if (res.data.code === 200) {
    setToken(res.data.data?.tokenValue, data.remember);
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 获取验证码
 */
export async function getCaptcha() {
  const res = await request.get('/verify/captcha');
  if (res.data.code === 200 && res.data.data) {
    return res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}
