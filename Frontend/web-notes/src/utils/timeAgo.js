// utils/timeAgo.js
import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'
import advancedFormat from 'dayjs/plugin/advancedFormat'

dayjs.extend(relativeTime)
dayjs.extend(advancedFormat)

export function timeAgo(time) {
  const now = dayjs()
  const targetTime = dayjs(time)

  const diffInMinutes = now.diff(targetTime, 'minute')

  if (diffInMinutes < 1) {
    return '刚刚'
  } else if (diffInMinutes < 60) {
    return `${diffInMinutes}分钟前`
  } else if (diffInMinutes < 1440) {  // 小于一天
    return `${now.diff(targetTime, 'hour')}小时前`
  } else if (diffInMinutes < 2880) {  // 小于两天
    return '1天前'
  } else if (diffInMinutes < 10080) {  // 小于一周
    return `${now.diff(targetTime, 'day')}天前`
  } else if (diffInMinutes < 43200) {  // 小于一个月
    return `${now.diff(targetTime, 'week')}周前`
  } else if (diffInMinutes < 525600) {  // 小于一年
    return `${now.diff(targetTime, 'month')}月前`
  } else {  // 超过一年
    return targetTime.format('YYYY/MM/DD')  // 自定义日期格式
  }
}
