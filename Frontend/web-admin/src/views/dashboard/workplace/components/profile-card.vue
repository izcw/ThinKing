<!-- 用户信息 -->
<template>
  <ele-card :body-style="{ padding: '20px' }">
    <div class="profile-wrapper">
      <div class="profile-main">
        <el-avatar :size="68" :src="FILE_PATH_API_URL + loginUser.avatar" class="profile-avatar" />
        <div class="profile-body">
          <ele-text size="xl" type="heading" style="font-weight: normal">
            {{ greeting }}好, {{ loginUser.nickname }}, 开始您一天的工作吧!
          </ele-text>
          <ele-text type="placeholder" :icon="CollectionTag">
            简单记，深刻思 - ThinKing笔记 - Small in one
          </ele-text>
        </div>
      </div>
      <div class="profile-count">
        <div class="profile-count-item">
          <div class="profile-count-header">
            <el-tag size="large" type="warning" :disable-transitions="true">
              <el-icon>
                <MostlyCloudy />
              </el-icon>
            </el-tag>
            <span class="profile-count-name">数据备份</span>
          </div>
          <ele-text size="xl" type="heading" style="font-weight: normal">
            2 / 3
          </ele-text>
        </div>
        <div class="profile-count-item">
          <div class="profile-count-header">
            <el-tag size="large" type="success" :disable-transitions="true">
              <el-icon>
                <bell-filled />
              </el-icon>
            </el-tag>
            <span class="profile-count-name">消息</span>
          </div>
          <ele-text size="xl" type="heading" style="font-weight: normal">
            0
          </ele-text>
        </div>
      </div>
    </div>
  </ele-card>
</template>

<script setup>
import { computed,onMounted ,ref} from 'vue';
import {
  CollectionTag,
  Briefcase,
  Checked,
  UserFilled,
  MostlyCloudy,
  BellFilled
} from '@element-plus/icons-vue';
import { useUserStore } from '@/store/modules/user';
import { FILE_PATH_API_URL } from "@/config/setting"
import { getGreeting } from "@/utils/timeGreeting.js"

const userStore = useUserStore();

// 当前登录用户信息
const loginUser = computed(() => userStore.info ?? {});


// 早、中晚
const greeting = ref('');
onMounted(() => {
  greeting.value = getGreeting();
});
</script>

<style lang="scss" scoped>
.profile-wrapper {
  display: flex;
  align-items: center;

  .profile-main {
    flex: 1;
    display: flex;
    align-items: center;
    overflow: hidden;

    .profile-avatar {
      flex-shrink: 0;
    }

    .profile-body {
      flex: 1;
      padding-left: 12px;
      box-sizing: border-box;
    }

    h4 {
      margin-bottom: 6px;
    }
  }
}

.profile-count {
  flex-shrink: 0;
  text-align: right;
  white-space: nowrap;

  .profile-count-item {
    display: inline-block;
    margin: 0 4px 0 24px;

    .el-tag {
      width: 26px;
      height: 26px;
      border-radius: 50%;

      :deep(.el-icon) {
        cursor: default;
        border-radius: 0;
      }
    }

    .profile-count-name {
      margin-left: 8px;
    }

    .profile-count-header {
      display: flex;
      align-items: center;
      margin-bottom: 4px;
    }
  }
}

@media screen and (max-width: 992px) {
  .profile-count .profile-count-item {
    margin: 0 2px 0 12px;
  }
}

@media screen and (max-width: 768px) {
  .profile-wrapper {
    display: block;

    .profile-count {
      margin-top: 14px;
    }
  }
}
</style>
