import service from '@/utils/request';

// 根据id获取笔记
export async function getPageId(id) {
  const res = await service.get('/note/page/' + id);
  if (res.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.message));
}

/**
 * 获取空间笔记
 */
export async function getSpacePage(params) {
  const res = await service.get('/note/page/spacePage', { params });
  if (res.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.message));
}

/**
 * 添加
 */
export async function addPage(data) {
  const res = await service.post('/note/page/add', data);
  if (res.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.message));
}


/**
 * 修改
 */
export async function update(data) {
  const res = await service.put('/note/page/update', data);
  if (res.code === 200) {
      return res.data;
  }
  return Promise.reject(new Error(res.message));
}
