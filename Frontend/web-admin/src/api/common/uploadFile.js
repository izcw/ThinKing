import request from '@/utils/request';

/**
 * 上传用户头像
 */
export async function UploadAvatar(data) {
  const res = await request.post('/upload/avatar', data);
  if (res.data.code === 200 || res.data.code === 500) {
    return res.data;
  }
  return Promise.reject(new Error(res.data.message));
}
