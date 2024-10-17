<template>
  <ele-page>
    <ele-card header="基础用法">
      <ele-edit-tag
        v-model="tags"
        :size="size"
        :type="type"
        :effect="effect"
        :validator="validator"
        :tooltip-props="{ effect: 'danger' }"
      />
      <ele-text type="secondary" style="padding: 8px 0">{{
        JSON.stringify(tags)
      }}</ele-text>
      <option-item label="尺寸选择">
        <el-radio-group v-model="size">
          <el-radio label="large">large</el-radio>
          <el-radio label="default">default</el-radio>
          <el-radio label="small">small</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="颜色选择" style="margin-top: 8px">
        <el-radio-group v-model="type">
          <el-radio label="">primary</el-radio>
          <el-radio label="success">success</el-radio>
          <el-radio label="info">info</el-radio>
          <el-radio label="warning">warning</el-radio>
          <el-radio label="danger">danger</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="主题选择" style="margin-top: 8px">
        <el-radio-group v-model="effect">
          <el-radio label="light">light</el-radio>
          <el-radio label="dark">dark</el-radio>
          <el-radio label="plain">plain</el-radio>
        </el-radio-group>
      </option-item>
    </ele-card>
    <ele-card header="进阶用法">
      <div style="margin-bottom: 12px">自定义异步验证:</div>
      <ele-edit-tag
        v-model="tags2"
        :size="size"
        :type="type"
        :effect="effect"
        :validator="validator2"
        :tooltip-props="{ effect: 'danger' }"
      />
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 选中尺寸
  const size = ref('default');

  // 选中类型
  const type = ref('info');

  // 选中主题
  const effect = ref('light');

  // 标签输入
  const tags = ref(['标签一', '标签二', '标签三']);

  /* 限制不能重复添加 */
  const validator = (value) => {
    return new Promise((resolve, reject) => {
      if (tags.value.includes(value)) {
        reject(new Error(value + '已经存在'));
        return;
      }
      resolve();
    });
  };

  // 标签输入
  const tags2 = ref(['标签一', '标签二', '标签三']);

  /* 自定义异步验证 */
  const validator2 = (value) => {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (value !== 'eleadmin') {
          reject(new Error('只能输入eleadmin'));
          return;
        }
        resolve();
      }, 1000);
    });
  };
</script>

<script>
  export default {
    name: 'ExtensionTag'
  };
</script>
