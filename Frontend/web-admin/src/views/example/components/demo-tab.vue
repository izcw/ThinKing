<template>
  <ele-card header="页签操作">
    <div style="display: flex; align-items: center">
      <div style="flex-shrink: 0; padding-right: 12px">操作指定页签:</div>
      <div style="flex: 1; max-width: 160px">
        <el-select
          clearable
          v-model="tabPath"
          placeholder="请选择页签"
          class="ele-fluid"
        >
          <el-option
            v-for="(item, index) in tabs"
            :key="item.key"
            :label="item.title"
            :value="item.fullPath || index"
          />
        </el-select>
      </div>
    </div>
    <div style="display: flex; flex-wrap: wrap">
      <el-button
        type="primary"
        style="margin: 16px 12px 0 0"
        @click="onUpdate2"
      >
        修改页签标题
      </el-button>
      <el-button
        type="primary"
        style="margin: 16px 12px 0 0"
        @click="onUpdate3"
      >
        修改为不可关闭
      </el-button>
      <el-button type="primary" style="margin: 16px 12px 0 0" @click="onClose2">
        关闭页签
      </el-button>
      <el-button type="primary" style="margin: 16px 12px 0 0" @click="onClose3">
        关闭当前并切换至
      </el-button>
    </div>
    <div style="margin: 28px 0 12px 0">操作当前页签:</div>
    <div style="display: flex; flex-wrap: wrap">
      <el-button
        type="primary"
        style="margin: 0 12px 16px 0"
        @click="onRefresh"
      >
        刷新当前页签
      </el-button>
      <el-button type="primary" style="margin: 0 12px 16px 0" @click="onUpdate">
        修改当前页签标题
      </el-button>
      <el-button type="primary" style="margin: 0 12px 16px 0" @click="onClose">
        关闭当前页签
      </el-button>
      <el-button
        type="primary"
        style="margin: 0 12px 16px 0"
        @click="onCloseAll"
      >
        关闭全部页签
      </el-button>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref, unref } from 'vue';
  import { storeToRefs } from 'pinia';
  import { useRouter } from 'vue-router';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useThemeStore } from '@/store/modules/theme';
  import { usePageTab } from '@/utils/use-page-tab';

  const {
    reloadPageTab,
    setPageTabTitle,
    finishPageTab,
    removeAllPageTab,
    getRouteTabKey,
    setPageTab,
    removePageTab
  } = usePageTab();

  const { currentRoute, push } = useRouter();

  // 当前打开的页签
  const themeStore = useThemeStore();
  const { tabs } = storeToRefs(themeStore);

  /* 刷新当前页签 */
  const onRefresh = () => {
    reloadPageTab();
  };

  /* 修改当前页签标题 */
  const onUpdate = () => {
    setPageTabTitle('新的标题');
  };

  /* 关闭当前页签 */
  const onClose = () => {
    finishPageTab();
  };

  /* 关闭全部页签 */
  const onCloseAll = () => {
    removeAllPageTab({ active: getRouteTabKey() });
  };

  // 下拉框选中
  const tabPath = ref('');

  /* 修改指定页签标题 */
  const onUpdate2 = () => {
    if (
      !tabPath.value ||
      !tabs.value.some((t) => t.fullPath === tabPath.value)
    ) {
      tabPath.value = '';
      EleMessage.error('请选择页签');
      return;
    }
    setPageTab({
      path: tabPath.value,
      title: '新的标题'
    });
  };

  /* 修改指定页签为不可关闭 */
  const onUpdate3 = () => {
    if (
      !tabPath.value ||
      !tabs.value.some((t) => t.fullPath === tabPath.value)
    ) {
      tabPath.value = '';
      EleMessage.error('请选择页签');
      return;
    }
    setPageTab({
      path: tabPath.value,
      closable: false
    });
  };

  /* 关闭指定页签 */
  const onClose2 = () => {
    if (!tabPath.value) {
      EleMessage.error('请选择页签');
      return;
    }
    const t = tabs.value.find((t) => t.fullPath === tabPath.value);
    if (!t) {
      tabPath.value = '';
      EleMessage.error('请选择页签');
      return;
    }
    if (t.path === unref(currentRoute).path) {
      onRefresh();
      return;
    }
    removePageTab({
      key: tabPath.value,
      active: getRouteTabKey()
    });
  };

  /* 关闭当前页签并切换至指定页签 */
  const onClose3 = () => {
    if (!tabPath.value) {
      EleMessage.error('请选择页签');
      return;
    }
    const t = tabs.value.find((t) => t.fullPath === tabPath.value);
    if (!t) {
      tabPath.value = '';
      EleMessage.error('请选择页签');
      return;
    }
    if (t.path === unref(currentRoute).path) {
      onRefresh();
      return;
    }
    removePageTab({ key: unref(currentRoute).path });
    push(tabPath.value);
  };
</script>
