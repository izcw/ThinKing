<template>
  <div>
    <ele-card style="border-radius: 0">
      <ele-text type="heading" size="lg">修改客户</ele-text>
      <ele-text type="placeholder" style="margin-top: 6px">
        修改客户基本信息后点击保存按钮
      </ele-text>
    </ele-card>
    <ele-page>
      <ele-card>
        <ele-loading :loading="loading">
          <edit-form :data="user" />
        </ele-loading>
      </ele-card>
    </ele-page>
  </div>
</template>

<script setup>
  import { ref, unref } from 'vue';
  import { useRouter } from 'vue-router';
  import { EleMessage } from 'ele-admin-plus/es';
  import EditForm from '../components/edit-form.vue';
  import { getUser } from '@/api/system/user';

  const { currentRoute } = useRouter();

  // 查询状态
  const loading = ref(true);

  // 客户信息
  const user = ref();

  /* 查询客户信息 */
  const query = () => {
    const { query } = unref(currentRoute);
    if (query.id) {
      getUser(Number(query.id))
        .then((data) => {
          loading.value = false;
          user.value = data;
        })
        .catch((e) => {
          EleMessage.error(e.message);
        });
    }
  };

  query();
</script>

<script>
  export default {
    name: 'ListBasicEdit'
  };
</script>
