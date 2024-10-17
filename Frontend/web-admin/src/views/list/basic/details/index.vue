<template>
  <ele-page :multi-card="false">
    <ele-card>
      <div style="margin-bottom: 16px">
        <el-button
          :icon="Back"
          type="primary"
          class="ele-btn-icon"
          @click="onBack"
        >
          返回列表
        </el-button>
      </div>
      <el-descriptions :border="true" :column="2" class="detail-table">
        <el-descriptions-item label="用户名">
          <div>{{ form.nickname }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="头像">
          <div style="display: flex">
            <el-avatar
              v-if="form.avatar"
              :src="form.avatar"
              :size="32"
              @click.stop=""
            />
            <el-avatar v-else :size="32" style="background: #1677ff">
              {{
                form.nickname && form.nickname.length > 2
                  ? form.nickname.substring(form.nickname.length - 2)
                  : form.nickname
              }}
            </el-avatar>
          </div>
        </el-descriptions-item>
        <el-descriptions-item label="用户账号">
          <div>{{ form.username }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="性别">
          <div>{{ form.sexName }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="手机号">
          <div>{{ form.phone }}</div>
        </el-descriptions-item>
        <el-descriptions-item label="角色">
          <el-tag
            v-for="item in form.roles"
            :key="item.roleId"
            size="small"
            :disable-transitions="true"
          >
            {{ item.roleName }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <ele-dot v-if="form.status === 0" text="正常" size="9px" />
          <ele-dot
            v-else-if="form.status === 1"
            text="冻结"
            type="danger"
            :ripple="false"
            size="9px"
          />
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">
          <div>{{ form.createTime }}</div>
        </el-descriptions-item>
      </el-descriptions>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, watch, unref } from 'vue';
  import { useRouter } from 'vue-router';
  import { Back } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { usePageTab } from '@/utils/use-page-tab';
  import { getUser } from '@/api/system/user';
  const ROUTE_PATH = '/list/basic/details';

  const { currentRoute, push } = useRouter();
  const { setPageTabTitle, removePageTab } = usePageTab();

  // 用户信息
  const { form, assignFields } = useFormData({
    userId: void 0,
    avatar: void 0,
    username: '',
    nickname: '',
    sexName: '',
    phone: '',
    roles: [],
    createTime: void 0,
    status: void 0
  });

  // 请求状态
  const loading = ref(true);

  /* 返回 */
  const onBack = () => {
    removePageTab({ key: unref(currentRoute).path });
    push('/list/basic');
  };

  /* 查询详情 */
  const query = () => {
    const { params } = unref(currentRoute);
    const id = params.id;
    if (!id || form.userId === Number(id)) {
      return;
    }
    loading.value = true;
    getUser(Number(id))
      .then((data) => {
        loading.value = false;
        assignFields(data);
        // 修改页签标题
        if (unref(currentRoute).path.startsWith(ROUTE_PATH)) {
          setPageTabTitle('用户详情 - ' + data.nickname);
        }
      })
      .catch((e) => {
        loading.value = false;
        EleMessage.error(e.message);
      });
  };

  watch(
    currentRoute,
    (route) => {
      const { fullPath } = unref(route);
      if (!fullPath.startsWith(ROUTE_PATH)) {
        return;
      }
      query();
    },
    { immediate: true }
  );
</script>

<script>
  export default {
    name: 'ListBasicDetails'
  };
</script>

<style lang="scss" scoped>
  .detail-table :deep(.el-descriptions__label) {
    width: 108px;
    text-align: right;
    font-weight: normal;
  }
</style>
