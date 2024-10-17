<template>
  <ele-page>
    <ele-card header="基础用法">
      <option-item label="显示折叠按钮" style="margin: 0">
        <el-radio-group v-model="allowCollapse">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="支持自由拉伸" style="margin: 0">
        <el-radio-group v-model="resizable">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="上下布局模式" style="margin: 0">
        <el-radio-group v-model="vertical">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="反转布局方向" style="margin: 0">
        <el-radio-group v-model="reverse">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </option-item>
      <ele-split-panel
        space="0px"
        size="160px"
        :allow-collapse="allowCollapse"
        :resizable="resizable"
        :vertical="vertical"
        :reverse="reverse"
        :custom-style="{
          background: 'rgba(185, 182, 229, .4)',
          overflow: 'hidden',
          border: 'none'
        }"
        :body-style="{
          background: 'rgba(125, 226, 252, .4)',
          overflow: 'hidden'
        }"
        style="height: 360px; margin-top: 12px"
      >
        <div>边栏</div>
        <template #body>
          <div>内容</div>
        </template>
      </ele-split-panel>
    </ele-card>
    <ele-card header="组合使用">
      <div style="margin: 0 0 8px 0">先左右再上下</div>
      <ele-split-panel
        space="0px"
        :min-size="40"
        :max-size="-40"
        :resizable="true"
        :custom-style="{
          background: 'rgba(185, 182, 229, .4)',
          overflow: 'hidden',
          border: 'none'
        }"
        :body-style="{ overflow: 'hidden' }"
        :responsive="false"
        style="height: 400px"
      >
        <div>边栏</div>
        <template #body>
          <ele-split-panel
            space="0px"
            :min-size="40"
            :max-size="-40"
            :vertical="true"
            :resizable="true"
            :custom-style="{
              background: 'rgba(171, 199, 255, .5)',
              overflow: 'hidden',
              border: 'none'
            }"
            :body-style="{
              background: 'rgba(125, 226, 252, .4)',
              overflow: 'hidden'
            }"
            :responsive="false"
            style="height: 400px"
          >
            <div>内容一</div>
            <template #body>
              <div>内容二</div>
            </template>
          </ele-split-panel>
        </template>
      </ele-split-panel>
      <div style="margin: 16px 0 8px 0">先上下再左右</div>
      <ele-split-panel
        space="0px"
        size="120px"
        :min-size="40"
        :max-size="-40"
        :vertical="true"
        :resizable="true"
        :custom-style="{
          background: 'rgba(185, 182, 229, .4)',
          overflow: 'hidden',
          border: 'none'
        }"
        :body-style="{ overflow: 'hidden' }"
        :responsive="false"
        style="height: 400px"
      >
        <div>顶栏</div>
        <template #body>
          <ele-split-panel
            space="0px"
            :min-size="40"
            :max-size="-40"
            :resizable="true"
            :custom-style="{
              background: 'rgba(171, 199, 255, .5)',
              overflow: 'hidden',
              border: 'none'
            }"
            :body-style="{
              background: 'rgba(125, 226, 252, .4)',
              overflow: 'hidden'
            }"
            :responsive="false"
            style="height: 100%"
          >
            <div>边栏</div>
            <template #body>
              <div>内容</div>
            </template>
          </ele-split-panel>
        </template>
      </ele-split-panel>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 是否显示折叠按钮
  const allowCollapse = ref(true);

  // 是否支持自由拉伸
  const resizable = ref(false);

  // 是否上下布局模式
  const vertical = ref(false);

  // 是否反转布局方向
  const reverse = ref(false);
</script>

<script>
  export default {
    name: 'ExtensionSplit'
  };
</script>
