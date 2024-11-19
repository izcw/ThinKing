import { login } from '@/api/login';
import request from '@/utils/request';

/**
 * 分页查询客户
 */
export async function PageUsers(params) {
  const res = await request.get('/note/user/page', { params });
  if (res.data.code === 200) {
    return {
      list:res.data.data.records,
      count:res.data.data.total
    };
  }

  return Promise.reject(new Error(res.data.data.message));
}

/**
 * 添加用户
 */
export async function AddUser(data) {
  console.log(data);
  
  const res = await request.post('/note/user/add', data);
  if (res.data.code === 200) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 修改用户
 */
export async function UpdateUser(data) {
  const res = await request.put('/note/user/update', data);
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 上传用户头像
 */
export async function UploadAvatar(data) {
  const res = await request.post('/note/user/upload-avatar', data);
  if (res.data.code === 200) {
    return res.data;
  }
  return Promise.reject(new Error(res.data.message));
}






/**
 * 根据id查询用户
 */
export async function getUser(id) {
  const res = await request.get('/system/user/' + id);
  if (res.data.code === 0 && res.data.data) {
    return res.data.data;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 删除用户
 */
export async function removeUser(id) {
  const res = await request.delete('/system/user/' + id);
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 批量删除用户
 */
export async function removeUsers(data) {
  const res = await request.delete('/system/user/batch', {
    data
  });
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 修改用户状态
 */
export async function updateUserStatus(userId, status) {
  const res = await request.put('/system/user/status', {
    userId,
    status
  });
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}

/**
 * 重置用户密码
 */
export async function updateUserPassword(userId, password = '123456') {
  const res = await request.put('/system/user/password', {
    userId,
    password
  });
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}


/**
 * 检查用户是否存在
 */
export async function checkExistence(field, value, id) {
  const res = await request.get('/system/user/existence', {
    params: { field, value, id }
  });
  if (res.data.code === 0) {
    return res.data.message;
  }
  return Promise.reject(new Error(res.data.message));
}
