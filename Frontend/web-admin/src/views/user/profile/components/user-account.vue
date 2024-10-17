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
          已绑定邮箱: eleadmin@eclouds.com
        </ele-text>
      </div>
      <el-link type="primary" :underline="false">去修改</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
    <div class="list-item">
      <div class="list-item-body">
        <ele-text size="md">密保问题</ele-text>
        <ele-text type="placeholder">未设置密保问题</ele-text>
      </div>
      <el-link type="primary" :underline="false">去设置</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
    <div class="list-item">
      <el-icon class="list-item-icon">
        <qq-outlined />
      </el-icon>
      <div class="list-item-body">
        <ele-text size="md">绑定QQ</ele-text>
        <ele-text type="placeholder">当前未绑定QQ账号</ele-text>
      </div>
      <el-link type="primary" :underline="false">去绑定</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
    <div class="list-item">
      <el-icon class="list-item-icon" style="background: #4daf29">
        <wechat-outlined />
      </el-icon>
      <div class="list-item-body">
        <ele-text size="md">绑定微信</ele-text>
        <ele-text type="placeholder">当前未绑定绑定微信账号</ele-text>
      </div>
      <el-link type="primary" :underline="false">去绑定</el-link>
    </div>
    <el-divider style="margin: 0; opacity: 0.6" />
    <div class="list-item">
      <el-icon class="list-item-icon" style="background: #1476fe">
        <alipay-outlined />
      </el-icon>
      <div class="list-item-body">
        <ele-text size="md">绑定支付宝</ele-text>
        <ele-text type="placeholder">当前未绑定绑定支付宝账号</ele-text>
      </div>
      <el-link type="primary" :underline="false">去绑定</el-link>
    </div>
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
