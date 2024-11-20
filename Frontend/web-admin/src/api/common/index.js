import request from '@/utils/request';

/**
 * 获取状态
 */
export async function ListStatus() {
  return new Promise((resolve) => {
      resolve([
        { code: 0, describe: '正常', type: 'primary', ripple: false },
        { code: 1, describe: '冻结', type: 'warning', ripple: true },
        { code: 2, describe: '异常', type: 'danger', ripple: true },
        { code: 3, describe: '注销', type: 'info', ripple: false },
      ]);
  });
}
