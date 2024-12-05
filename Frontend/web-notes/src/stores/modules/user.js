import { ref } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';
import { useRouter } from 'vue-router'

import { useOperatingcloudStore } from '@/stores/OperatingCloud'

export const useUserStore = defineStore('userinfo', () => {
  const storeCloud = useOperatingcloudStore()
  const router = useRouter()

  const userInfoData = ref(null); // 当前登录用户的信息

  // 获取当前登录用户的个人信息
  const fetchUserInfo = async () => {
    try {
      const response = await getUserInfo();
      console.log("获取成功", response);
      userInfoData.value = response;
      
      storeCloud.cloudData.space = userInfoData.value.noteSpaces.find((item)=>item.defaultSpace == 0).spaceId
      router.push('/space' + userInfoData.value.noteSpaces.find((item)=>item.defaultSpace == 0).spaceId)
    } catch (error) {
      console.error("获取用户信息失败", error);
    }
  };

  return { userInfoData, fetchUserInfo };
});