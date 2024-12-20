import service from '@/utils/request';

/**
 * 获取用户所有空间
 */
export async function getSpaceAll() {
    const res = await service.get('/note/space/all');
    if (res.code === 200) {
        return res.data;
    }
    return Promise.reject(new Error(res.message));
}

/**
 * 获取用户默认空间
 */
export async function getDefaultSpace() {
    const res = await service.get('/note/space/defaultSpace');
    if (res.code === 200) {
        return res.data;
    }
    return Promise.reject(new Error(res.message));
}

/**
 * 添加空间
 */
export async function addSpace(data) {
    const res = await service.post('/note/space/add', data);
    if (res.code === 200) {
        return res.data;
    }
    return Promise.reject(new Error(res.message));
}

/**
 * 修改默认空间
 */
export async function defaultSpace(params) {
    const res = await service.put('/note/space/defaultspace', null, { params });
    if (res.code === 200) {
        return res.message;
    }
    return Promise.reject(new Error(res.message));
}

/**
 * 修改空间
 */
export async function updateSpace(data) {
    const res = await service.put('/note/space/update', data);
    if (res.code === 200) {
        return res.message;
    }
    return Promise.reject(new Error(res.message));
}



/**
 * 删除空间
 */
export async function deleteSpace(params) {
    const res = await service.delete('/note/space/delete', { params });
    return res;
    return Promise.reject(new Error(res.message));
}
