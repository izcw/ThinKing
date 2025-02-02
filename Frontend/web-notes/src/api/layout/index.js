import { setToken, removeToken } from '@/utils/token-util';
import  service  from '@/utils/request';

/**
 * 获取当前登录用户的个人信息/空间/套餐/笔记
 */
export async function getUserInfo() {
    const res = await service.get('/note/auth/user');
    if (res.code === 200) {
        return res.data;
    }
    return Promise.reject(new Error(res.message));
}