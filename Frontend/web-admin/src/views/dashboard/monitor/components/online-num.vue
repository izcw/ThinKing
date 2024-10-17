<template>
  <ele-card header="在线人数">
    <div style="text-align: center">
      <ele-text type="placeholder">{{ currentTime }}</ele-text>
      <ele-text size="xxxl">
        <ele-count-up :end-val="onlineNum" />
      </ele-text>
      <ele-text type="placeholder" style="margin-bottom: 11px">
        在线总人数
      </ele-text>
      <ele-dot :text="updateTimeText" size="8px" />
    </div>
  </ele-card>
</template>

<script setup>
  import { ref, computed, onBeforeUnmount } from 'vue';
  import dayjs from 'dayjs';

  // 在线人数更新定时器
  let onlineNumTimer = null;

  // 在线总人数倒计时
  const updateTime = ref(10);

  // 当前时间
  const currentTime = ref(dayjs(new Date()).format('HH:mm:ss'));

  // 在线人数
  const onlineNum = ref(228);

  // 在线人数倒计时文字
  const updateTimeText = computed(() => updateTime.value + ' 秒后更新');

  /* 在线人数更新倒计时 */
  const startUpdateOnlineNum = () => {
    onlineNumTimer = window.setInterval(() => {
      currentTime.value = dayjs(new Date()).format('HH:mm:ss');
      if (updateTime.value === 1) {
        updateTime.value = 10;
        onlineNum.value = 100 + Math.round(Math.random() * 900);
      } else {
        updateTime.value--;
      }
    }, 1000);
  };

  onBeforeUnmount(() => {
    // 销毁定时器
    if (onlineNumTimer) {
      clearInterval(onlineNumTimer);
      onlineNumTimer = null;
    }
  });

  startUpdateOnlineNum();
</script>
