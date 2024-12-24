import request from '@/utils/request';

/**
 * 分页查询
 */
export async function PageSubscribeOrder(params) {
  const res = await request.get('/note/subscribeorder/page', { params });
  if (res.data.code === 200) {
    return {
      list: res.data.data.records,
      count: res.data.data.total
    };
  }

  return Promise.reject(new Error(res.data.data.message));
}

/**
 * 获取全部
 */
export async function PageSubscribeOrderALL() {
  const res = await request.get('/note/subscribeorder/all');
  if (res.data.code === 200) {
    return res.data.data
  }

  return Promise.reject(new Error(res.data.data.message));
}

/**
 * 添加
 */
export async function AddSubscribe(data) {
  const res = await request.post('/note/subscribe/add', data);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 修改
 */
export async function UpdateSubscribe(data) {
  const res = await request.put('/note/subscribe/update', data);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 单条删除
 */
export async function removeSubscribe(id) {
  const res = await request.delete('/note/subscribe/delete/' + id);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 批量删除
 */
export async function BatchremoveUsers(data) {
  const res = await request.delete('/note/subscribe/deleteBatch', {
    data
  });
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}
