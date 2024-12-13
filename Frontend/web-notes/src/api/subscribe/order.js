import service from '@/utils/request';

/**
 * 分页获取当前登录用户的订单+套餐信息
 */
export async function PageSubscribeOrder(params) {    
    const res = await service.get('/note/subscribeorder/page',{params});
    if (res.code === 200) {
        return res.data.records;
    }
    return Promise.reject(new Error(res.message));
}

/**
 * 升级套餐（支付）
 */
export async function paymentOrder(data) {
    const res = await service.post('/note/subscribeorder/payment', data);
    console.log("支付");
    
    console.log(res);
    
    if (res.code === 200 || res.code === 500) {
        return res;
    }
    return Promise.reject(new Error(res.message));
}
