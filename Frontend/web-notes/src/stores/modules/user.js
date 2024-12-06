import { ref } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';
import { useRouter } from 'vue-router'
import { getSpacePage } from '@/api/note/index.js'

import { useOperatingcloudStore } from '@/stores/OperatingCloud'

export const useUserStore = defineStore('userinfo', () => {
  const storeCloud = useOperatingcloudStore()
  const router = useRouter()

  const userInfoData = ref(null); // 当前登录用户的信息
  const spacePageData = ref(null); // 当前空间的笔记

  // 获取当前登录用户的个人信息
  const fetchUserInfo = async () => {
    try {
      const response = await getUserInfo();
      console.log("获取用户信息成功", response);
      userInfoData.value = response;

      storeCloud.cloudData.space = userInfoData.value.noteSpaces.find((item) => item.defaultSpace == 0).spaceId

      // 获取当前空间的所有笔记
      getSpacePage({ spaceId: storeCloud.cloudData.space }).then((data) => {
        console.log("获取当前空间的所有笔记", data);
        spacePageData.value = data
      }).catch((e) => {
        console.error('获取失败', e);
      });

    } catch (error) {
      console.error("获取用户信息失败", error);
    }
  };

  return { userInfoData, spacePageData, fetchUserInfo };
});