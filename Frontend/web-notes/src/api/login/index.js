// src/api/login/index.js
import { get, post } from '@/utils/request';

// 注册
export function postRegister(data) {
  return post('/note/user/register', data);
}

// 登录
export function postlogin(data) {
  return post('/note/user/login', data);
}

// 获邮箱验证码
export function getEmailCode(data) {
  return get('/note/user/sendVerificationCode', data);
}

// 验证邮箱验证码
export function postVerifyEmailCode(data) {
  return post('/note/user/verifyEmailCode',data);
}


// 获取图片验证码
export function getVerifyCode() {
  return get('/note/verify/getcode');
}

// 验证图片验证码
export function postCheckVerifyCode(data) {
  return post('/note/verify/checkcode', data);
}
