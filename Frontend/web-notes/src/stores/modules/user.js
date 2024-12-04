import { ref } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';

export const useUserStore = defineStore('userinfo', () => {
  const userInfoData = ref(null); // 当前登录用户的信息

  // 获取当前登录用户的个人信息
  const fetchUserInfo = async () => {
    try {
      const response = await getUserInfo();
      console.log("获取成功", response);
      userInfoData.value = response;
    } catch (error) {
      console.error("获取用户信息失败", error);
    }
  };

  return { userInfoData, fetchUserInfo };
});