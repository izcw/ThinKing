import { get, post } from '@/utils/request';

/**
 * 分页查询套餐
 */
export async function PageSubscribe(params) {    
    const res = await get('/note/subscribe/page',params);
    if (res.code === 200) {
        return res.data.records;
    }
    return Promise.reject(new Error(res.message));
}