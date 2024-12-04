import { ref } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';

export const useUserStore = defineStore('userinfo', () => {
  const info = ref(null); // 当前登录用户的信息
  const spaces = ref(null); // 当前登录用户的空间列表

  // 获取当前登录用户的个人信息
  const fetchUserInfo = async () => {
    try {
      const response = await getUserInfo();
      console.log("获取成功", response);
      info.value = response; // 假设 response 是用户信息对象
    } catch (error) {
      console.error("获取用户信息失败", error);
    }
  };

  return { info, spaces, fetchUserInfo };
});