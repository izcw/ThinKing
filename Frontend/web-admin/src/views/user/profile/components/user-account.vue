<template>
  <div class="list-wrapper">
    <div class="list-item">
      <div class="list-item-body">
        <ele-text size="md">密保手机</ele-text>
        <ele-text type="placeholder">已绑定手机: {{ data.phone }}</ele-text>
      </div>
      <el-link type="primary" :underline="false">去修改</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
    <div class="list-item">
      <div class="list-item-body">
        <ele-text size="md">密保邮箱</ele-text>
        <ele-text type="placeholder">
          已绑定邮箱: {{ data.email }}
        </ele-text>
      </div>
      <el-link type="primary" :underline="false">去修改</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
  </div>
</template>

<script setup>
  import {
    QqOutlined,
    WechatOutlined,
    AlipayOutlined
  } from '@/components/icons';

  defineProps({
    data: Object
  });
</script>

<style lang="scss" scoped>
  .list-wrapper {
    padding: 6px 14px;
    box-sizing: border-box;

    .list-item {
      display: flex;
      align-items: center;
      box-sizing: border-box;
      padding: 12px 10px;

      .list-item-body {
        flex: 1;

        .ele-text + .ele-text {
          margin-top: 2px;
        }
      }

      .list-item-icon {
        color: #fff;
        padding: 10px;
        font-size: 24px;
        border-radius: 50%;
        background: #3492ed;
        margin-right: 12px;
      }
    }
  }
</style>
