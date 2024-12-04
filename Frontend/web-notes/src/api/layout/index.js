import { setToken, removeToken } from '@/utils/token-util';
import { get, post } from '@/utils/request';

/**
 * 获取当前登录用户的个人信息/空间/套餐/笔记
 */
export async function getUserInfo() {
    console.log("hhhhh888");
    
    const res = await get('/note/auth/user');
    console.log("获取用户信息");
    console.log(res);

    if (res.code === 200) {
        return res.message;
    }
    return Promise.reject(new Error(res.message));
}