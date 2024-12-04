<template>
  <div class="setting">
    <!-- 左侧菜单 -->
    <div class="left">
      <div>
        <div class="avatar">
          <el-avatar :size="30" :src="circleUrl" />
          <div class="account">
            <p class="nickname">Yoko</p>
            <p>2405824084@qq.com</p>
          </div>
        </div>
        <div class="item" v-for="(menu, index) in menuList" :key="index" :class="{ active: activeIndex === index }"
          @click="changeActive(index)">
          <span class="icon">{{ menu.icon }}</span>
          <span>{{ menu.label }}</span>
        </div>
      </div>
      <div class="Loguut item"  @click="LogOut">
        退出登录
      </div>
    </div>

    <!-- 右侧展示内容 -->
    <div class="right">
      <div>
        <span>
          {{ menuList[activeIndex].label }}
        </span>
        <el-divider />
      </div>
      <component :is="currentComponent" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import MyAccount from './components/MyAccount.vue';
import Settings from './components/Settings.vue';
import UpgradePlan from './components/UpgradePlan.vue';
import { logoutToken } from '@/api/login/index.js'
import { ElMessage } from 'element-plus'

const activeIndex = ref(0);
const menuList = [
  { label: '我的账号', icon: '图标', component: MyAccount },
  { label: '设置', icon: '图标', component: Settings },
  { label: '升级方案', icon: '图标', component: UpgradePlan }
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
      align-items: center;
      margin-bottom: 1rem;

      .account {
        margin-left: 6px;

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
