<template>
  <ele-card header="地图位置选择器">
    <el-space>
      <ele-dropdown
        v-model="mode"
        :items="[
          { title: 'POI检索模式', command: 'poi' },
          { title: '关键字检索模式', command: 'keyword' }
        ]"
        trigger="click"
      >
        <template #default="{ selected }">
          <el-button class="ele-btn-icon">
            <span>{{ selected.title }}</span>
            <el-icon :size="12" style="margin: 0 -4px 0 4px">
              <arrow-down />
            </el-icon>
          </el-button>
        </template>
      </ele-dropdown>
      <el-button class="ele-btn-icon" @click="openMapPicker">
        打开位置选择
      </el-button>
    </el-space>
    <div style="margin-top: 12px">选中位置: {{ result.location }}</div>
    <div style="margin-top: 12px">详细地址: {{ result.address }}</div>
    <div style="margin-top: 12px">经 纬 度 : {{ result.lngAndLat }}</div>
  </ele-card>
  <!-- 地图位置选择弹窗 -->
  <ele-map-picker
    v-model="visible"
    :dark-mode="darkMode"
    :return-regions="true"
    :keyword-mode="mode === 'keyword'"
    @done="onChoose"
  />
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { ArrowDown } from '@element-plus/icons-vue';
  import { useThemeStore } from '@/store/modules/theme';
  import { storeToRefs } from 'pinia';

  const themeStore = useThemeStore();
  const { darkMode } = storeToRefs(themeStore);

  // 是否显示地图选择弹窗
  const visible = ref(false);

  // 地点检索类型
  const mode = ref('poi');

  // 选择结果
  const result = reactive({
    location: '',
    address: '',
    lngAndLat: ''
  });

  /* 打开位置选择 */
  const openMapPicker = () => {
    visible.value = true;
  };

  /* 地图选择后回调 */
  const onChoose = (location) => {
    console.log(location);
    result.location = `${location.city?.province}/${location.city?.city}/${location.city?.district}`;
    result.address = `${location.name} ${location.address}`;
    result.lngAndLat = `${location.lng},${location.lat}`;
    visible.value = false;
  };
</script>
