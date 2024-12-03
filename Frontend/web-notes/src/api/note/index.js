import { setToken } from '@/utils/token-util';
import { get, post } from '@/utils/request';

// 根据id获取笔记
export function postVerifyEmailCode(data) {
  return post('/', data);
}