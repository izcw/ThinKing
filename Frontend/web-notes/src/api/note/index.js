import service from '@/utils/request';

// 根据id获取笔记
export async function getPageId(id) {
  const res = await service.get('/note/page/' + id);
  if (res.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.message));
}

// 根据id获取笔记(不需要登录)
export async function getSharePageId(id) {
  const res = await service.get('/note/page/sharepage/' + id);
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
 * 使用模版
 */
export async function useTemplate(params) {
  const res = await service.post('/note/page/useTemplate', null, { params });
  if (res.code === 200) {
    return res;
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


/**
 * 逻辑删除
 */
export async function upRecycle(params) {
  const res = await service.put('/note/page/recycle', null, { params });
  if (res.code === 200) {
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}


/**
 * 删除（彻底删除）
 */
export async function deletePage(params) {
  const res = await service.delete('/note/page/delete', { params });
  if (res.code === 200) {
    return res.message;
  }
  return Promise.reject(new Error(res.message));
}


/**
 * 获取回收站笔记
 */
export async function getRecyclePage(params) {
  const res = await service.get('/note/page/RecyclePage', { params });
  if (res.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.message));
}