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
