export const getGreeting = () => {
  const currentHour = new Date().getHours();
  if (currentHour >= 5 && currentHour < 12) {
    return '早上';
  } else if (currentHour >= 12 && currentHour < 18) {
    return '中午';
  } else {
    return '晚上';
  }
};
