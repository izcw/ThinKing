import request from '@/utils/request';

/**
 * 分页查询
 */
export async function PageTemplate(params) {
  const res = await request.get('/note/template/page', { params });
  if (res.data.code === 200) {

    return {
      list: res.data.data.records,
      count: res.data.data.total
    };
  }

  return Promise.reject(new Error(res.data.data.message));
}

/**
 * 全部
 */
export async function AllTemplate(params) {
  const res = await request.get('/note/template/all', { params });
  if (res.data.code === 200) {
    return res.data.data;
  }

  return Promise.reject(new Error(res.data.data.message));
}


/**
 * 添加
 */
export async function AddTemplate(data) {
  const res = await request.post('/note/template/add', data);
  if (res.data.code === 200 || res.data.code === 500) {
    return res.data;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 添加
 */
export async function updateTemplate(data) {
  const res = await request.put('/note/template/update', data);
  if (res.data.code === 200 || res.data.code === 500) {
    return res.data;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 单条删除
 */
export async function removeTemplate(id) {
  const res = await request.delete('/note/template/delete/' + id);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}
