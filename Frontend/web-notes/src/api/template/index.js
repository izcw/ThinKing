import service from '@/utils/request';

/**
 * 分页
 */
export async function PageTemplate(params) {    
    const res = await service.get('/note/template/page',{params});
    if (res.code === 200) {
        return res.data.records;
    }
    return Promise.reject(new Error(res.message));
}