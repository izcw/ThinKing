// 计算套餐是否过期
export function calculateExpiryDays(createTime, unit) {
    const now = new Date();
    const createDate = new Date(createTime);
    const expiryDate = new Date(createDate.getTime() + unit * 24 * 60 * 60 * 1000); // 过期时间
  
    const diffTime = expiryDate - now; // 计算时间差（毫秒）
  
    return Math.ceil(diffTime / (1000 * 3600 * 24)); // 返回天数，正数表示剩余天数，负数表示已过期天数
  }
  