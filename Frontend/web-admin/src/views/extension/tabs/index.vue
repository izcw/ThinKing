<template>
  <ele-page>
    <ele-card header="基础用法">
      <option-item label="尺寸">
        <el-radio-group v-model="size" size="large">
          <el-radio label="small">小型</el-radio>
          <el-radio label="default">默认</el-radio>
          <el-radio label="large">大型</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="风格" style="margin: 0">
        <div style="max-width: 220px">
          <el-select v-model="type" size="small" class="ele-fluid">
            <el-option label="默认" value="default" />
            <el-option label="卡片" value="card" />
            <el-option label="边框卡片" value="border-card" />
            <el-option label="朴素" value="plain" />
            <el-option label="简约" value="simple" />
            <el-option label="指示器" value="indicator" />
            <el-option label="按钮" value="button" />
          </el-select>
        </div>
      </option-item>
      <ele-tabs
        :items="items"
        v-model="active"
        :size="size"
        :type="type"
        :mousewheel="true"
        style="margin-top: 24px"
        :class="{ 'demo-card-button': type === 'button' }"
      >
        <template #user>
          <div style="padding: 20px 0">User</div>
        </template>
        <template #role>
          <div style="padding: 20px 0">Role</div>
        </template>
        <template #organization>
          <div style="padding: 20px 0">Organization</div>
        </template>
        <template #menu>
          <div style="padding: 20px 0">Menu</div>
        </template>
      </ele-tabs>
    </ele-card>
    <ele-card header="右键菜单和拖动排序">
      <ele-tabs
        :items="items"
        v-model="active"
        type="border-card"
        :context-menu="true"
        :context-menus="[
          { title: '关闭当前', command: 'close' },
          { title: '关闭左侧', command: 'left' },
          { title: '关闭右侧', command: 'right' },
          { title: '关闭其他', command: 'other' }
        ]"
        :sortable="true"
      >
        <template #user>
          <div style="padding: 20px 0">User</div>
        </template>
        <template #role>
          <div style="padding: 20px 0">Role</div>
        </template>
        <template #organization>
          <div style="padding: 20px 0">Organization</div>
        </template>
        <template #menu>
          <div style="padding: 20px 0">Menu</div>
        </template>
      </ele-tabs>
    </ele-card>
    <ele-card header="组合使用">
      <ele-card
        bordered
        :header-style="{ padding: '0 16px' }"
        style="max-width: 600px"
      >
        <template #header>
          <ele-tabs
            :items="[
              { name: 'new', label: '最新' },
              { name: 'hot', label: '热门' }
            ]"
            v-model="active2"
            type="plain"
            size="large"
          />
        </template>
        <template #extra>
          <el-link type="primary" :underline="false">查看全部</el-link>
        </template>
        <div v-if="active2 === 'new'">New</div>
        <div v-if="active2 === 'hot'">Hot</div>
      </ele-card>
    </ele-card>
    <ele-card header="自定义风格" :body-style="{ paddingTop: '6px' }">
      <div style="max-width: 480px; min-height: 224px">
        <ele-tabs
          :items="[
            { name: 'new', label: '最新动态' },
            { name: 'hot', label: '热门时讯' },
            { name: 'subject', label: '专题推荐' }
          ]"
          v-model="active3"
          type="simple"
          class="demo-tabs"
        >
          <template #new>
            <div style="padding: 10px 0">
              <template v-for="i in 4" :key="i">
                <el-divider
                  v-if="i > 1"
                  border-style="dashed"
                  style="margin: 0"
                />
                <div style="padding: 8px 0; display: flex">
                  <ele-ellipsis style="flex: 1; cursor: pointer">
                    EleAdmin新版本发布, 欢迎体验 1-{{ i }}
                  </ele-ellipsis>
                  <ele-text type="placeholder">2023-05-20</ele-text>
                </div>
              </template>
            </div>
          </template>
          <template #hot>
            <div style="padding: 10px 0">
              <template v-for="i in 3" :key="i">
                <el-divider
                  v-if="i > 1"
                  border-style="dashed"
                  style="margin: 0"
                />
                <div style="padding: 8px 0; display: flex">
                  <ele-ellipsis style="flex: 1; cursor: pointer">
                    EleAdmin新版本发布, 欢迎体验 2-{{ i }}
                  </ele-ellipsis>
                  <ele-text type="placeholder">2023-05-20</ele-text>
                </div>
              </template>
            </div>
          </template>
          <template #subject>
            <div style="padding: 10px 0">
              <template v-for="i in 2" :key="i">
                <el-divider
                  v-if="i > 1"
                  border-style="dashed"
                  style="margin: 0"
                />
                <div style="padding: 8px 0; display: flex">
                  <ele-ellipsis style="flex: 1; cursor: pointer">
                    EleAdmin新版本发布, 欢迎体验 3-{{ i }}
                  </ele-ellipsis>
                  <ele-text type="placeholder">2023-05-20</ele-text>
                </div>
              </template>
            </div>
          </template>
        </ele-tabs>
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 选中
  const active = ref('user');

  // 标签页数据
  const items = ref([
    {
      name: 'user',
      label: '用户管理'
    },
    {
      name: 'role',
      label: '角色管理'
    },
    {
      name: 'organization',
      label: '机构管理',
      closable: true
    },
    {
      name: 'menu',
      label: '菜单管理',
      closable: true
    }
  ]);

  // 尺寸
  const size = ref('default');

  // 风格
  const type = ref('default');

  //
  const active2 = ref('new');

  //
  const active3 = ref('new');
</script>

<script>
  export default {
    name: 'ExtensionTabs'
  };
</script>

<style lang="scss" scoped>
  /* 按钮风格增加灰色背景 */
  .demo-card-button :deep(.el-tabs__header) {
    background: hsla(0, 0%, 60%, 0.1);
    box-shadow: 0 0 0 8px hsla(0, 0%, 60%, 0.1);
  }

  /* 自定义样式 */
  div.demo-tabs.ele-tabs :deep(.el-tabs__header) {
    --ele-tab-padding: 0;
    --ele-tab-height: 46px;
    --ele-tab-simple-active-bg: none;
    --ele-tab-simple-hover-bg: none;

    .el-tabs__item {
      font-size: 16px;
      transition: none;

      & + .el-tabs__item {
        margin-left: 40px;
      }

      &:hover,
      &.is-active {
        font-weight: bold;
      }

      &.is-active::after {
        height: 3px;
        width: 20px !important;
        left: 50%;
        transform: translateX(-50%);
        display: block;
      }
    }
  }
</style>
