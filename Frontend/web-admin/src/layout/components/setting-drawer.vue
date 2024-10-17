<!-- 主题设置抽屉 -->
<template>
  <ele-drawer
    :size="268"
    :append-to-body="true"
    :model-value="modelValue"
    :title="t('layout.setting.title')"
    @update:modelValue="updateModelValue"
  >
    <div :class="['setting-wrapper', { 'setting-dark': darkMode }]">
      <!-- 侧栏风格 -->
      <div v-if="layout !== 'top'" class="setting-theme">
        <ele-tooltip
          :content="t('layout.setting.sideStyles.dark')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div class="setting-side-dark" @click="updateSidebarStyle('dark')">
            <ele-text
              v-if="sidebarStyle === 'dark'"
              type="primary"
              :icon="Check"
            />
          </div>
        </ele-tooltip>
        <ele-tooltip
          :content="t('layout.setting.sideStyles.light')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div class="setting-side-light" @click="updateSidebarStyle('light')">
            <ele-text
              v-if="sidebarStyle === 'light'"
              type="primary"
              :icon="Check"
            />
          </div>
        </ele-tooltip>
      </div>
      <!-- 顶栏风格 -->
      <div class="setting-theme">
        <ele-tooltip
          :content="t('layout.setting.headStyles.light')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div class="setting-head-light" @click="updateHeaderStyle('light')">
            <ele-text
              v-if="headerStyle === 'light'"
              type="primary"
              :icon="Check"
            />
          </div>
        </ele-tooltip>
        <ele-tooltip
          :content="t('layout.setting.headStyles.dark')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div class="setting-head-dark" @click="updateHeaderStyle('dark')">
            <ele-text
              v-if="headerStyle === 'dark'"
              type="primary"
              :icon="Check"
            />
          </div>
        </ele-tooltip>
        <ele-tooltip
          :content="t('layout.setting.headStyles.primary')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div
            class="setting-head-primary"
            @click="updateHeaderStyle('primary')"
          >
            <ele-text
              v-if="headerStyle === 'primary'"
              type="primary"
              :icon="Check"
            />
          </div>
        </ele-tooltip>
      </div>
      <!-- 主题色 -->
      <div class="setting-colors">
        <div
          v-for="item in themes"
          :key="item.name"
          :style="{ 'background-color': item.color || item.value }"
          class="setting-color-item"
          @click="updateColor(item.value)"
        >
          <el-icon v-if="item.value ? item.value === color : !color">
            <check />
          </el-icon>
          <ele-tooltip
            :content="t('layout.setting.colors.' + item.name)"
            placement="top"
            :hide-after="0"
            :offset="9"
          >
            <div class="setting-color-tooltip"></div>
          </ele-tooltip>
        </div>
        <!-- 颜色选择器 -->
        <el-color-picker
          ref="colorPickerRef"
          v-model="colorValue"
          :predefine="predefineColors"
          class="setting-color-picker"
          @change="updateColor"
          @activeChange="onColorChange"
        />
      </div>
      <!-- 暗黑模式 -->
      <div class="setting-item">
        <div class="setting-item-title">{{ t('layout.setting.darkMode') }}</div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="darkMode"
            @update:modelValue="updateDarkMode"
          />
        </div>
      </div>
      <!-- 圆角主题 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.roundedTheme') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="roundedTheme"
            @update:modelValue="updateRoundedTheme"
          />
        </div>
      </div>
      <el-divider />
      <!-- 导航布局 -->
      <ele-text type="placeholder" class="setting-title hidden-xs-only">
        {{ t('layout.setting.layout') }}
      </ele-text>
      <div class="setting-theme hidden-xs-only">
        <ele-tooltip
          :content="t('layout.setting.layoutStyles.side')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div
            class="setting-side-dark setting-layout-side"
            @click="updateLayout('side')"
          >
            <ele-text v-if="layout === 'side'" type="primary" :icon="Check" />
          </div>
        </ele-tooltip>
        <ele-tooltip
          :content="t('layout.setting.layoutStyles.top')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div
            class="setting-head-dark setting-layout-top"
            @click="updateLayout('top')"
          >
            <ele-text v-if="layout === 'top'" type="primary" :icon="Check" />
          </div>
        </ele-tooltip>
        <ele-tooltip
          :content="t('layout.setting.layoutStyles.mix')"
          placement="top"
          :hide-after="0"
          :offset="9"
        >
          <div class="setting-layout-mix" @click="updateLayout('mix')">
            <ele-text v-if="layout === 'mix'" type="primary" :icon="Check" />
          </div>
        </ele-tooltip>
      </div>
      <!-- 侧栏菜单布局 -->
      <div v-if="layout !== 'top'" class="setting-item hidden-xs-only">
        <div class="setting-item-title">
          {{ t('layout.setting.sidebarLayout') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="sidebarLayout === 'mix'"
            @update:modelValue="updateSidebarLayout"
          />
        </div>
      </div>
      <!-- 内容区域铺满 -->
      <div class="setting-item hidden-xs-only">
        <div class="setting-item-title">
          {{ t('layout.setting.fluid') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="fluid"
            @update:modelValue="updateFluid"
          />
        </div>
      </div>
      <el-divider class="hidden-xs-only" />
      <ele-text type="placeholder" class="setting-title">
        {{ t('layout.setting.other') }}
      </ele-text>
      <!-- 固定主体 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.fixedBody') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="fixedBody"
            @update:modelValue="updateFixedBody"
          />
        </div>
      </div>
      <!-- 固定顶栏 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.fixedHeader') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :disabled="fixedBody"
            :model-value="fixedHeader"
            @update:modelValue="updateFixedHeader"
          />
        </div>
      </div>
      <!-- 固定侧栏 -->
      <div v-if="layout !== 'top'" class="setting-item hidden-xs-only">
        <div class="setting-item-title">
          {{ t('layout.setting.fixedSidebar') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :disabled="fixedBody"
            :model-value="fixedSidebar"
            @update:modelValue="updateFixedSidebar"
          />
        </div>
      </div>
      <!-- 图标是否置于顶栏 -->
      <div v-if="layout !== 'top'" class="setting-item hidden-xs-only">
        <div class="setting-item-title">
          {{ t('layout.setting.logoInHeader') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="logoInHeader"
            @update:modelValue="updateLogoInHeader"
          />
        </div>
      </div>
      <!-- 侧栏彩色图标 -->
      <div v-if="layout !== 'top'" class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.colorfulIcon') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="colorfulIcon"
            @update:modelValue="updateColorfulIcon"
          />
        </div>
      </div>
      <!-- 侧栏排他展开 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.uniqueOpened') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="uniqueOpened"
            @update:modelValue="updateUniqueOpened"
          />
        </div>
      </div>
      <!-- 响应式开关 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.responsive') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="responsive"
            @update:modelValue="updateResponsive"
          />
        </div>
      </div>
      <!-- 色弱模式 -->
      <div class="setting-item">
        <div class="setting-item-title">{{ t('layout.setting.weakMode') }}</div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="weakMode"
            @update:modelValue="updateWeakMode"
          />
        </div>
      </div>
      <!-- 页签 -->
      <div class="setting-item">
        <div class="setting-item-title">{{ t('layout.setting.showTabs') }}</div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="tabBar"
            @update:modelValue="updateTabBar"
          />
        </div>
      </div>
      <!-- 固定主页页签 -->
      <div v-if="tabBar" class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.fixedHome') }}
        </div>
        <div class="setting-item-control">
          <el-switch
            size="small"
            :model-value="fixedHome"
            @update:modelValue="updateFixedHome"
          />
        </div>
      </div>
      <!-- 页签风格 -->
      <div v-if="tabBar" class="setting-item">
        <div class="setting-item-title">{{ t('layout.setting.tabStyle') }}</div>
        <div class="setting-item-control" style="width: 90px">
          <el-select
            size="small"
            :model-value="tabStyle"
            @update:modelValue="updateTabStyle"
          >
            <el-option
              value="simple"
              :label="t('layout.setting.tabStyles.default')"
            />
            <el-option
              value="indicator"
              :label="t('layout.setting.tabStyles.dot')"
            />
            <el-option
              value="button"
              :label="t('layout.setting.tabStyles.card')"
            />
          </el-select>
        </div>
      </div>
      <!-- 切换动画 -->
      <div class="setting-item">
        <div class="setting-item-title">
          {{ t('layout.setting.transitionName') }}
        </div>
        <div class="setting-item-control" style="width: 110px">
          <el-select
            size="small"
            :model-value="transitionName"
            @update:modelValue="updateTransitionName"
          >
            <el-option
              value="slide-right"
              :label="t('layout.setting.transitions.slideRight')"
            />
            <el-option
              value="slide-bottom"
              :label="t('layout.setting.transitions.slideBottom')"
            />
            <el-option
              value="zoom-in"
              :label="t('layout.setting.transitions.zoomIn')"
            />
            <el-option
              value="zoom-out"
              :label="t('layout.setting.transitions.zoomOut')"
            />
            <el-option
              value="fade"
              :label="t('layout.setting.transitions.fade')"
            />
          </el-select>
        </div>
      </div>
      <!-- 重置 -->
      <div style="padding-top: 6px">
        <el-divider />
        <el-button size="small" class="ele-fluid" @click="resetSetting">
          {{ t('layout.setting.reset') }}
        </el-button>
      </div>
    </div>
  </ele-drawer>
</template>

<script setup>
  import { ref, nextTick } from 'vue';
  import { useI18n } from 'vue-i18n';
  import { storeToRefs } from 'pinia';
  import { Check } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import { useThemeStore } from '@/store/modules/theme';

  defineProps({
    // 是否显示
    modelValue: Boolean
  });

  const emit = defineEmits(['update:modelValue']);

  const { t } = useI18n();
  const themeStore = useThemeStore();

  const {
    tabBar,
    layout,
    sidebarLayout,
    headerStyle,
    sidebarStyle,
    tabStyle,
    fixedHeader,
    fixedSidebar,
    fixedBody,
    fluid,
    logoInHeader,
    transitionName,
    colorfulIcon,
    uniqueOpened,
    fixedHome,
    weakMode,
    darkMode,
    color,
    roundedTheme,
    responsive
  } = storeToRefs(themeStore);

  // 预设主题颜色
  const themes = ref([
    {
      name: 'default',
      color: '#1677ff'
    },
    {
      name: 'dust',
      value: '#5f80c7'
    },
    {
      name: 'sunset',
      value: '#faad14'
    },
    {
      name: 'volcano',
      value: '#f5686f'
    },
    {
      name: 'purple',
      value: '#9266f9'
    },
    {
      name: 'green',
      value: '#33cc99'
    },
    {
      name: 'geekblue',
      value: '#32a2d4'
    }
  ]);

  // 颜色选择器预设颜色
  const predefineColors = ref([
    '#f5222d',
    '#fa541c',
    '#fa8c16',
    '#faad14',
    '#a0d911',
    '#52c41a',
    '#13c2c2',
    '#2f54eb',
    '#722ed1',
    '#eb2f96'
  ]);

  // 颜色选择器选中颜色
  const colorValue = ref(void 0);

  /* 更新modelValue */
  const updateModelValue = (value) => {
    emit('update:modelValue', value);
  };

  const updateTabBar = (value) => {
    themeStore.setTabBar(value);
  };

  const updateLayout = (value) => {
    themeStore.setLayout(value);
  };

  const updateSidebarLayout = (value) => {
    themeStore.setSidebarLayout(value ? 'mix' : 'default');
  };

  const updateHeaderStyle = (value) => {
    themeStore.setHeaderStyle(value);
  };

  const updateSidebarStyle = (value) => {
    themeStore.setSidebarStyle(value);
  };

  const updateTabStyle = (value) => {
    themeStore.setTabStyle(value);
  };

  const updateFixedHeader = (value) => {
    themeStore.setFixedHeader(value);
  };

  const updateFixedSidebar = (value) => {
    themeStore.setFixedSidebar(value);
  };

  const updateFixedBody = (value) => {
    themeStore.setFixedBody(value);
  };

  const updateFluid = (value) => {
    themeStore.setFluid(value);
  };

  const updateLogoInHeader = (value) => {
    themeStore.setLogoInHeader(value);
  };

  const updateColorfulIcon = (value) => {
    themeStore.setColorfulIcon(value);
  };

  const updateUniqueOpened = (value) => {
    themeStore.setUniqueOpened(value);
  };

  const updateFixedHome = (value) => {
    themeStore.setFixedHome(value);
    location.reload();
  };

  const updateResponsive = (value) => {
    themeStore.setResponsive(value);
    location.reload();
  };

  const updateRoundedTheme = (value) => {
    themeStore.setRoundedTheme(value);
  };

  const updateWeakMode = (value) => {
    themeStore.setWeakMode(value);
  };

  const updateTransitionName = (value) => {
    themeStore.setTransitionName(value);
  };

  const updateDarkMode = (value) => {
    doWithLoading(() => themeStore.setDarkMode(value));
  };

  const updateColor = (value) => {
    doWithLoading(() => themeStore.setColor(value ?? null));
  };

  const resetSetting = () => {
    doWithLoading(() => themeStore.resetSetting());
  };

  const doWithLoading = (func) => {
    func()
      .then(() => {
        initColorValue();
      })
      .catch((e) => {
        console.error(e);
        EleMessage.error('主题加载失败');
      });
  };

  /* 更新颜色选择器选中 */
  const initColorValue = () => {
    if (color?.value && !themes.value.some((t) => t.value === color.value)) {
      colorValue.value = color.value;
    } else {
      colorValue.value = void 0;
    }
  };

  initColorValue();

  // 解决ElColorPicker第一次点击预设颜色未选中的问题
  const colorPickerRef = ref(null);
  const onColorChange = (color) => {
    const index = predefineColors.value.indexOf(color.toLowerCase());
    const ins = colorPickerRef.value?.$refs?.predefine;
    if (index != -1 && ins != null && !ins.rgbaColors[index].selected) {
      nextTick(() => {
        ins.rgbaColors[index].selected = true;
      });
    }
  };
</script>

<style lang="scss" scoped>
  .setting-wrapper {
    .setting-title {
      font-size: 13px;
      margin-bottom: 15px;
    }

    /* 主题风格 */
    .setting-theme > div {
      width: 52px;
      height: 36px;
      line-height: 1;
      border-radius: var(--el-border-radius-base);
      margin: 0 20px 30px 0;
      padding: 15px 0 0 24px;
      box-sizing: border-box;
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.15);
      background: #f0f2f5;
      display: inline-block;
      vertical-align: top;
      position: relative;
      overflow: hidden;
      cursor: pointer;
      transition: background-color 0.2s;
      font-size: 16px;

      &::before,
      &::after {
        content: '';
        width: 100%;
        height: 10px;
        background: #fff;
        position: absolute;
        left: 0;
        top: 0;
        transition: background-color 0.2s;
      }

      &::after {
        width: 14px;
        height: 100%;
      }

      &.setting-side-dark::after,
      &.setting-head-dark::before,
      &.setting-layout-mix::before,
      &.setting-layout-mix::after {
        background: #001529;
      }

      &.setting-head-light::before,
      &.setting-head-dark::before,
      &.setting-head-primary::before {
        z-index: 1;
      }

      &.setting-side-light::before,
      &.setting-side-dark:not(.setting-layout-side)::before,
      &.setting-head-light::after,
      &.setting-head-dark::after,
      &.setting-head-primary::after {
        opacity: 0.5;
      }

      &.setting-head-primary::before {
        background: var(--el-color-primary) !important;
      }

      &.setting-layout-top {
        padding-left: 18px;

        &::after {
          display: none;
        }
      }
    }

    /* 主题色选择 */
    .setting-colors {
      color: #fff;
      margin-bottom: 20px;
      line-height: 0;
    }

    .setting-color-item {
      width: 20px;
      height: 20px;
      line-height: 20px;
      border-radius: var(--el-border-radius-small);
      margin: 8px 8px 0 0;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      vertical-align: top;
      position: relative;
      text-align: center;
      cursor: pointer;

      .setting-color-tooltip {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
      }
    }

    .setting-colors .setting-color-item:last-child {
      margin-right: 0;
    }

    /* 主题配置项 */
    .setting-item {
      display: flex;
      align-items: center;
      margin-bottom: 20px;

      .setting-item-title {
        flex: 1;
        line-height: 28px;
      }

      .setting-item-control {
        line-height: 1;
      }
    }

    .el-divider.el-divider--horizontal {
      margin: 0 0 20px 0;
      opacity: 0.6;
    }

    /* 暗黑模式 */
    &.setting-dark .setting-theme > div {
      background: #000;
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.55);

      &::before,
      &::after {
        background: #1f1f1f;
      }

      &.setting-side-dark::after,
      &.setting-head-dark::before,
      &.setting-layout-mix::before,
      &.setting-layout-mix::after {
        background: #262626;
      }
    }

    /* 颜色选择器 */
    .setting-colors :deep(.el-color-picker) {
      margin-top: 8px;
      line-height: 0;

      .el-color-picker__trigger {
        padding: 0;
        width: 20px;
        height: 20px;
        border: none;
      }

      .el-color-picker__color {
        border: none;
      }

      .el-color-picker__empty {
        background: conic-gradient(
          from 90deg at 50% 50%,
          rgb(255, 0, 0) -19.41deg,
          rgb(255, 0, 0) 18.76deg,
          rgb(255, 138, 0) 59.32deg,
          rgb(255, 230, 0) 99.87deg,
          rgb(20, 255, 0) 141.65deg,
          rgb(0, 163, 255) 177.72deg,
          rgb(5, 0, 255) 220.23deg,
          rgb(173, 0, 255) 260.13deg,
          rgb(255, 0, 199) 300.69deg,
          rgb(255, 0, 0) 340.59deg,
          rgb(255, 0, 0) 378.76deg
        );
        height: 100%;
        width: 100%;

        & > svg {
          display: none;
        }
      }
    }
  }
</style>
