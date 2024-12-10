import { ref, computed } from 'vue';
import { defineStore } from 'pinia';
import { getUserInfo } from '@/api/layout/index';
import { getDefaultSpace } from '@/api/space';
import { useRouter } from 'vue-router'
import { getSpacePage } from '@/api/note/index.js'

export const useUserStore = defineStore('userinfo', () => {
  const router = useRouter()

  const userInfoData = ref(null); // 当前登录用户的信息
  const spacePageData = ref(null); // 当前空间的笔记
  const defaultSpace = ref(null); // 默认的空间
  const routerParamsId = ref(); // 路由请求的参数

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


  // 获取当前空间的笔记
  let getSpaceData = (val) => {
    console.log("查找");
    console.log(userInfoData.value.noteSpaces.find((item) => item.spaceId == val));
    if (userInfoData.value.noteSpaces.find((item) => item.spaceId == val) == undefined) {
      // userInfoData.value.
      console.log("没有此空间");
      getDefaultSpaceFun();
      return
    }

    getSpacePage({ spaceId: val }).then((data) => {
      console.log("获取当前空间的所有笔记");
      spacePageData.value = data;
    }).catch((e) => {
      console.error('获取失败', e);
    });
  }


  // 获取默认空间
  let getDefaultSpaceFun = () => {
    getDefaultSpace().then((data) => {
      console.log("默认空间");
      console.log(data);
      defaultSpace.value = data
      router.push('/space/' + data.spaceId)
      return
    }).catch((e) => {
      console.error('获取失败', e);
    });
  }

  // 收藏的页面
  const filterCollect = computed(() => {
    console.log("收藏的页面");
    console.log(spacePageData.value);
    if (spacePageData.value) {
      return spacePageData.value.filter((item) => item.collect == 1);
    }
    return []
  });


  // 使用计算属性构建树形数据
  const treeData = computed(() => {
    return buildTree(spacePageData.value);
  });

  // 将笔记数据构建树形结构的函数
  function buildTree(data) {
    const tree = [];
    const map = new Map();

    if (data) {
      data.forEach(item => {
        const node = { ...item, children: [] };
        map.set(item.pageId, node);
      });

      data.forEach(item => {
        const node = map.get(item.pageId);
        if (item.parentId === '0') {
          tree.push(node);
        } else {
          const parentNode = map.get(item.parentId);
          if (parentNode) {
            parentNode.children.push(node);
          }
        }
      });
    }

    return tree;
  }
  


  return { userInfoData, spacePageData, defaultSpace, routerParamsId, treeData, filterCollect, getSpaceData, fetchUserInfo, getDefaultSpaceFun };
});