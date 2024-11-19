import { login } from '@/api/login';
import request from '@/utils/request';

/**
 * 查询套餐列表
 */
export async function listSubscribe(params) {
  const res = await request.get('/note/subscribe/all');

  if (res.data.code === 200 && res.data.data) {
    return res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}
