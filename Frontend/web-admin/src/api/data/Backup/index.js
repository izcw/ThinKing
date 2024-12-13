import request from '@/utils/request';

/**
 * 查询日志
 */
export async function getBackuplogs() {
  const res = await request.get('/backup/operations');
  if (res.data.code === 200) {
    return  res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 获取当前备份信息
 */
export async function getBackupdetails() {
  const res = await request.get('/backup/details');
  if (res.data.code === 200) {
    return  res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 增量备份
 */
export async function PostIncremental(data) {
  const res = await request.post('/backup/incremental', data);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 全量备份
 */
export async function PostFull(data) {
  const res = await request.post('/backup/full', data);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 导出下载
 */
export async function PostDownloadAll(data) {
  // 发送 POST 请求获取文件流
  const res = await request.post('/backup/downloadAll', data, {
    responseType: 'blob', // 告诉浏览器这是一个文件流
  });

  // 如果返回的状态是 200，处理文件下载
  if (res.status === 200) {
    // 创建一个 Blob 对象，将返回的数据（文件流）转换为 Blob
    const blob = new Blob([res.data], { type: 'application/zip' });

    // 创建一个下载链接
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'all_backups.zip';  // 设置下载的文件名

    // 模拟点击链接以触发下载
    link.click();

    // 释放对象 URL
    URL.revokeObjectURL(link.href);

    return "下载成功";
  }

  // 如果返回状态不是 200，则抛出错误
  return Promise.reject(new Error(res.status));
}
