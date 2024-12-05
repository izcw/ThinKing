import request from '@/utils/request';

/**
 * 用户状态
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


/**
 * 套餐状态
 */
export async function SubscribeListStatus() {
  return new Promise((resolve) => {
    resolve([
      { code: 0, describe: '正常', type: 'primary', ripple: false },
      { code: 1, describe: '下架', type: 'info', ripple: false },
    ]);
  });
}



/**
 * 套餐单位
 */
export async function SnitListStatus() {
  return new Promise((resolve) => {
    resolve([
      { unit: '30', describe: '一个月（30天）' },
      { unit: '90', describe: '3个月（30天）' },
      { unit: '365', describe: '1年（365天）' },
    ]);
  });
}


/**
 * 订单状态
 */
export async function SubscribeOrderListStatus() {
  return new Promise((resolve) => {
    resolve([
      { code: 0, describe: '订单完成', type: 'primary', ripple: false },
      { code: 1, describe: '订单异常', type: 'info', ripple: false },
      { code: 2, describe: '已退款', type: 'info', ripple: false },
      { code: 3, describe: '支付失败', type: 'info', ripple: false },
    ]);
  });
}
