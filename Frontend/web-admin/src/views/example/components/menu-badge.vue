<template>
  <ele-card header="修改菜单徽章">
    <el-form label-width="80px" style="max-width: 360px">
      <el-form-item label="菜单">
        <el-tree-select
          :data="treeData"
          check-strictly
          default-expand-all
          placeholder="请选择菜单"
          v-model="path"
          class="ele-fluid"
        />
      </el-form-item>
      <el-form-item label="徽章值">
        <el-input clearable v-model="badge" placeholder="请输入徽章值" />
      </el-form-item>
      <el-form-item label="徽章类型">
        <el-select
          clearable
          v-model="type"
          placeholder="请选择徽章类型"
          class="ele-fluid"
        >
          <el-option label="primary" value="primary" />
          <el-option label="success" value="success" />
          <el-option label="warning" value="warning" />
          <el-option label="danger" value="danger" />
          <el-option label="info" value="info" />
        </el-select>
      </el-form-item>
      <el-form-item style="margin: 0">
        <el-button type="primary" @click="setBadge">更新</el-button>
      </el-form-item>
    </el-form>
  </ele-card>
</template>

<script setup>
  import { ref, computed } from 'vue';
  import { storeToRefs } from 'pinia';
  import { EleMessage, mapTree } from 'ele-admin-plus/es';
  import { useUserStore } from '@/store/modules/user';

  const userStore = useUserStore();
  const { menus } = storeToRefs(userStore);

  // 菜单树选择数据
  const treeData = computed(() => {
    return mapTree(menus.value, (m) => {
      return {
        ...m,
        value: m.path,
        label: m.meta?.title
      };
    });
  });

  const path = ref();

  const badge = ref();

  const type = ref();

  /* 修改菜单徽章数据 */
  const setBadge = () => {
    if (!path.value) {
      EleMessage.error('请选择菜单');
      return;
    }
    userStore.setMenuBadge(
      path.value,
      !badge.value || isNaN(Number(badge.value))
        ? badge.value
        : Number(badge.value),
      type.value
    );
  };
</script>
