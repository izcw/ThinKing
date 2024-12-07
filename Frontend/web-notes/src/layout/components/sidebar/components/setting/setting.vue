<template>
  <div class="setting">
    <!-- 左侧菜单 -->
    <div class="left">
      <div>
        <div class="avatar">
          <el-avatar :size="30" :src="FILE_PATH_API_URL + store.userInfoData.avatar" />
          <div class="account">
            <p class="nickname">{{ store.userInfoData.nickname }}</p>
            <p>{{ store.userInfoData.email }}</p>
          </div>
        </div>
        <div class="item" v-for="(menu, index) in menuList" :key="index" :class="{ active: activeIndex === index }"
          @click="changeActive(index)">
          <div class="icon">
            <n-icon size="20">
              <component :is="menu.icon" />
            </n-icon>
          </div>
          <span>{{ menu.label }}</span>
        </div>
      </div>
      <div class="Loguut item" @click="LogOut">
        退出登录
      </div>
    </div>

    <!-- 右侧展示内容 -->
    <div class="right">
      <div style="height: 60px;">
        <span>
          {{ menuList[activeIndex].label }}
        </span>
        <el-divider />
      </div>
      <div style="height: calc(100% - 60px)">
        <component :is="currentComponent" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, markRaw } from 'vue';
import MyAccount from './components/MyAccount.vue';
import Settings from './components/Settings.vue';
import UpgradePlan from './components/UpgradePlan.vue';
import { logoutToken } from '@/api/login/index.js'
import { ElMessage } from 'element-plus'
import { WindowArrowUp16Filled, Settings24Regular } from '@vicons/fluent'
import { UserOutlined } from '@vicons/antd'
import { FILE_PATH_API_URL } from "@/config/setting"
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

// 使用 markRaw 来标记组件
const UserOutlinedIcon = markRaw(UserOutlined);
const Settings24RegularIcon = markRaw(Settings24Regular);
const WindowArrowUp16FilledIcon = markRaw(WindowArrowUp16Filled);

const MyAccountComponent = markRaw(MyAccount);
const SettingsComponent = markRaw(Settings);
const UpgradePlanComponent = markRaw(UpgradePlan);

const activeIndex = ref(0);
const menuList = [
  { label: '我的账号', icon: UserOutlinedIcon, component: MyAccountComponent },
  { label: '设置', icon: Settings24RegularIcon, component: SettingsComponent },
  { label: '升级方案', icon: WindowArrowUp16FilledIcon, component: UpgradePlanComponent }
];

const currentComponent = computed(() => menuList[activeIndex.value].component);

function changeActive(index) {
  activeIndex.value = index;
}



// 退出登录
let LogOut = () => {
  logoutToken().then((msg) => {
    ElMessage.success(msg)
    return
  }).catch((e) => {
    console.error('注销失败', e);
  });
}
</script>

<style lang='scss'>
.setting {
  display: flex;
  width: 100%;
  height: 100%;

  .left {
    width: 300px;
    height: 100%;
    padding: 1rem 0;
    box-sizing: border-box;
    background-color: #FAFAFA;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .avatar {
      padding: 6px 1rem;
      box-sizing: border-box;
      display: flex;
      margin-bottom: 1rem;

      .account {
        margin-left: 6px;
        align-items: center;

        p {
          font-size: 12px;
          color: #666;
        }

        .nickname {
          color: #333;
          font-weight: bold;
        }
      }
    }

    .Loguut {
      color: #0355E3;
      padding: 6px 1rem;
      cursor: pointer;
    }

    .item {
      display: flex;
      margin-right: 10px;

      padding: 6px 1rem;
      box-sizing: border-box;
      border-radius: 4px;
      margin-bottom: 1px;
      cursor: pointer;

      .icon {
        margin-right: 6px;
      }
    }

    .item:hover,
    .item:active,
    .item.active {
      background-color: #EFEFEE;
    }
  }

  .right {
    padding: 1.5rem 1rem;
    box-sizing: border-box;
    width: 100%;
    height: 100%;
  }
}

.configuration {
  .item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;

    .name {
      font-size: 14px;
      color: #333;
    }

    .value {
      font-size: 12px;
      color: #999;
    }
  }
}
</style>
