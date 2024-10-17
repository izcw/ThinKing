<template>
  <ele-card header="用户满意度">
    <div class="user-satisfaction">
      <ele-text size="xxl" class="satisfaction-item">856</ele-text>
      <div class="satisfaction-item">
        <div class="face-smile"><i></i></div>
        <ele-text type="placeholder">正面评论</ele-text>
      </div>
      <ele-text size="xxl" type="success" class="satisfaction-item">
        82%
      </ele-text>
    </div>
    <el-divider style="margin: 24px 0 25px 0; opacity: 0.6" />
    <div class="user-satisfaction">
      <ele-text size="xxl" class="satisfaction-item">60</ele-text>
      <div class="satisfaction-item">
        <div class="face-cry"><i></i></div>
        <ele-text type="placeholder">负面评论</ele-text>
      </div>
      <ele-text size="xxl" type="danger" class="satisfaction-item">9%</ele-text>
    </div>
  </ele-card>
</template>

<style lang="scss" scoped>
  .user-satisfaction {
    display: flex;
    align-items: center;

    .satisfaction-item {
      flex: 1;
      text-align: center;

      .face-smile,
      .face-cry {
        margin-bottom: 8px;
      }
    }
  }

  .face-smile,
  .face-cry {
    width: 50px;
    height: 50px;
    display: inline-block;
    background: #fbd971;
    border-radius: 50%;
    position: relative;
  }

  .face-smile > i,
  .face-smile::before,
  .face-smile::after,
  .face-cry > i,
  .face-cry::before,
  .face-cry::after {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    transform: rotate(225deg);
    border: 3px solid #f0c419;
    border-right-color: transparent !important;
    border-bottom-color: transparent !important;
    box-sizing: border-box;
    position: absolute;
    bottom: 8px;
    left: 11px;
  }

  .face-smile::before,
  .face-smile::after,
  .face-cry::before,
  .face-cry::after {
    content: '';
    width: 12px;
    height: 12px;
    left: 8px;
    top: 14px;
    border-color: #f29c1f;
    transform: rotate(45deg);
  }

  .face-smile::after,
  .face-cry::after {
    left: auto;
    right: 8px;
  }

  .face-cry > i {
    transform: rotate(45deg);
    bottom: -6px;
  }
</style>
