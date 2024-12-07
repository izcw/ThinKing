import { ref } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';
import { useRouter } from 'vue-router'

export const useUserStore = defineStore('userinfo', () => {
  const userInfoData = ref(null); // 当前登录用户的信息
  const spacePageData = ref(null); // 当前空间的笔记

  // 获取当前登录用户的个人信息
  const fetchUserInfo = async () => {
    try {
      const response = await getUserInfo();
      console.log("获取用户信息成功", response);
      userInfoData.value = response;

    } catch (error) {
      console.error("获取用户信息失败", error);
    }
  };

  return { userInfoData, spacePageData, fetchUserInfo };
});