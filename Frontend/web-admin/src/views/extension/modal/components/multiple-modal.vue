<template>
  <ele-card header="同时打开多个">
    <div>
      <el-space size="large">
        <el-button type="primary" class="ele-btn-icon" @click="openDialog1">
          打开弹窗1
        </el-button>
        <el-button type="primary" class="ele-btn-icon" @click="openDialog2">
          打开弹窗2
        </el-button>
        <el-button type="primary" class="ele-btn-icon" @click="openDialog3">
          打开弹窗3
        </el-button>
      </el-space>
    </div>
    <ele-text block type="placeholder" style="margin-top: 20px">
      同时打开多个弹窗时点击会自动置顶
    </ele-text>
  </ele-card>
  <ele-modal
    :width="460"
    title="弹窗1"
    v-model="visible1"
    :resizable="true"
    :maxable="true"
    :multiple="true"
    :destroy-on-close="false"
    :move-out="['right', 'bottom']"
    position="center"
  >
    <div style="padding: 40px 0">弹窗1</div>
    <template #footer>
      <el-button @click="visible1 = false">取消</el-button>
      <el-button type="primary">确定</el-button>
    </template>
  </ele-modal>
  <ele-modal
    :width="460"
    title="弹窗2"
    v-model="visible2"
    :resizable="true"
    :maxable="true"
    :multiple="true"
    :destroy-on-close="false"
    position="leftBottom"
  >
    <div style="padding: 40px 0">弹窗2</div>
    <template #footer>
      <el-button @click="visible2 = false">取消</el-button>
      <el-button type="primary">确定</el-button>
    </template>
  </ele-modal>
  <ele-modal
    :width="360"
    title="弹窗3"
    v-model="visible3"
    :resizable="true"
    :maxable="true"
    :multiple="true"
    :destroy-on-close="false"
    position="rightTop"
    :style="{
      borderRadius: '8px',
      backdropFilter: 'blur(4px)',
      background: 'hsla(0, 0%, 26%, 0.4)',
      '--ele-modal-icon-color': 'rgba(255, 255, 255, 0.8)',
      '--ele-modal-icon-hover-color': 'rgba(255, 255, 255, 1)',
      '--ele-modal-icon-hover-bg': 'rgba(255, 255, 255, .15)',
      '--ele-modal-header-border': '1px solid rgba(255, 255, 255, 0.1)',
      '--ele-modal-header-padding': '14px 20px',
      '--ele-modal-fullscreen-border': 'none',
      '--ele-scrollbar-color': 'rgba(255, 255, 255, .36)',
      '--ele-scrollbar-hover-color': 'rgba(255, 255, 255, .58)'
    }"
    :title-style="{ color: '#fff' }"
    :body-style="{ color: '#fff' }"
  >
    <div style="padding: 40px 0">弹窗3</div>
  </ele-modal>
</template>

<script setup>
  import { ref } from 'vue';

  // 弹窗是否打开
  const visible1 = ref(false);

  const visible2 = ref(false);

  const visible3 = ref(false);

  /* 打开弹窗 */
  const openDialog1 = () => {
    visible1.value = true;
  };

  const openDialog2 = () => {
    visible2.value = true;
  };

  const openDialog3 = () => {
    visible3.value = true;
  };
</script>
