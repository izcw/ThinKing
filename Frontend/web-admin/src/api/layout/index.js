import request from '@/utils/request';

/**
 * 获取当前登录用户的个人信息/菜单/权限/角色
 */
export async function getUserInfo() {
  const res = await request.get('/auth/user');
  if (res.data.code === 0 && res.data.data) {
    return res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 修改当前登录用户的密码
 */
export async function updatePassword(data) {
  const res = await request.put('/auth/password', data);
  if (res.data.code === 0) {
    return res.data.message ?? '修改成功';
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 修改当前登录用户的个人信息
 */
export async function updateUserInfo(data) {
  const res = await request.put('/auth/user', data);
  if (res.data.code === 0 && res.data.data) {
    return res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}
