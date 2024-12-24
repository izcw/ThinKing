<!-- 小组成员 -->
<template>
  <ele-card :header="title" :body-style="{ padding: '8px 0px', height: '370px' }">
    <template #extra>
      <more-icon @command="onCommand" />
    </template>
    <div v-for="(item, index) in userList" :key="index" class="user-list-item">
      <el-avatar :size="46" :src="FILE_PATH_API_URL + item.avatar" style="flex-shrink: 0" />
      <div class="user-list-item-body">
        <div>{{ item.nickname }}</div>
        <ele-ellipsis type="placeholder" size="sm">
          {{ item.introduction }}
        </ele-ellipsis>
      </div>
      <div style="flex-shrink: 0">
        <!-- <el-tag v-for="rolesitem in item.roles" :key="rolesitem.roleId" size="small" :disable-transitions="true"
          :type="rolesitem.roleCode === 'admin' ? 'danger' : rolesitem.roleCode === 'senior' ? 'primary' : rolesitem.roleCode === 'user' ? 'success' : 'info'">
          {{ rolesitem.roleName }}
        </el-tag> -->
      </div>
    </div>
  </ele-card>
</template>

<script setup>
import { ref } from 'vue';
import MoreIcon from './more-icon.vue';
import { FILE_PATH_API_URL } from "@/config/setting"
import { pageUsers } from '@/api/system/user/index';

defineProps({
  title: String
});

const emit = defineEmits(['command']);

// 小组成员数据
const userList = ref([]);

/* 查询小组成员 */
const queryUserList = async (page, limit) => {
  ({ list: userList.value } = await pageUsers({
    // ...where,
    page,
    limit
  }))
};
queryUserList(1, 5)

const onCommand = (command) => {
  emit('command', command);
};
</script>

<style lang="scss" scoped>
.user-list-item {
  display: flex;
  align-items: center;
  padding: 12px 18px;
  transition: background-color 0.2s;
  cursor: pointer;

  .user-list-item-body {
    flex: 1;
    padding-left: 12px;
    box-sizing: border-box;
  }

  &+.user-list-item {
    border-top: 1px solid hsla(0, 0%, 60%, 0.2);
  }

  &:hover {
    background: hsla(0, 0%, 60%, 0.08);
  }
}
</style>
