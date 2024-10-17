<template>
  <ele-page>
    <ele-card header="消息提示">
      <option-item label="主题风格">
        <el-radio-group v-model="theme">
          <el-radio :label="0">默认</el-radio>
          <el-radio :label="1">简约</el-radio>
          <el-radio :label="2">原始</el-radio>
        </el-radio-group>
      </option-item>
      <option-item>
        <el-space size="large">
          <el-button @click="showMessage('success')">成功</el-button>
          <el-button @click="showMessage('warning')">警告</el-button>
          <el-button @click="showMessage('error')">错误</el-button>
          <el-button @click="showMessage('info')">信息</el-button>
        </el-space>
      </option-item>
      <option-item label="Loading">
        <el-space size="large">
          <el-button @click="showLoading()" class="ele-btn-icon">
            Open
          </el-button>
          <el-button @click="showLoading(true)" class="ele-btn-icon">
            加遮罩层
          </el-button>
          <el-button @click="showLoading(true, true)" class="ele-btn-icon">
            居中显示
          </el-button>
        </el-space>
      </option-item>
    </ele-card>
    <ele-card header="文本提示">
      <option-item label="基础用法">
        <ele-tooltip content="EleAdminPlus" placement="top" :offset="8">
          <el-button>Dark</el-button>
        </ele-tooltip>
        <ele-tooltip
          content="EleAdminPlus"
          placement="top"
          effect="light"
          :offset="8"
        >
          <el-button>Light</el-button>
        </ele-tooltip>
      </option-item>
      <option-item label="主题设置">
        <ele-tooltip
          content="EleAdminPlus"
          placement="top"
          effect="danger"
          :offset="8"
        >
          <el-button>Danger</el-button>
        </ele-tooltip>
        <ele-tooltip
          content="EleAdminPlus"
          placement="top"
          effect="warning"
          :offset="8"
        >
          <el-button>Warning</el-button>
        </ele-tooltip>
        <ele-tooltip
          content="EleAdminPlus"
          placement="top"
          effect="success"
          :offset="8"
        >
          <el-button>Success</el-button>
        </ele-tooltip>
        <ele-tooltip
          content="EleAdminPlus"
          placement="top"
          bg="linear-gradient( 135deg, #43CBFF 10%, #9708CC 100%)"
          arrow-bg="#7556E0"
          :offset="8"
        >
          <el-button>Custom</el-button>
        </ele-tooltip>
      </option-item>
      <option-item label="气泡卡片">
        <ele-popover :width="180" trigger="hover" title="这是标题" :offset="8">
          <template #reference>
            <el-button>Hover me</el-button>
          </template>
          <div>This is content.</div>
          <div>This is content.</div>
        </ele-popover>
        <ele-popover :width="180" trigger="click" title="这是标题" :offset="8">
          <template #reference>
            <el-button>Click me</el-button>
          </template>
          <div>This is content.</div>
          <div>This is content.</div>
        </ele-popover>
        <ele-popconfirm
          :width="258"
          :offset="8"
          title="用户满意度调研"
          content="您在使用中是否对本产品还满意?"
          cancel-button-text="关闭"
          confirm-button-text="满意"
          :cancel-button-props="{ style: { order: -1, margin: '0 auto 0 0' } }"
        >
          <template #reference>
            <el-button>Popconfirm</el-button>
          </template>
          <template #action="{ cancel }">
            <el-button size="small" plain type="danger" @click="cancel()">
              反馈
            </el-button>
          </template>
        </ele-popconfirm>
      </option-item>
    </ele-card>
    <ele-card header="警告提示">
      <div style="margin-bottom: 8px">基本用法:</div>
      <el-row :gutter="16">
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            title="Info Text"
            show-icon
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="success"
            title="Success Text"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="warning"
            title="Warning Text"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="error"
            title="Error Text"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
      </el-row>
      <div style="margin: 8px 0">文字描述:</div>
      <el-row :gutter="16">
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            title="Info Text"
            description="Info Description Info Description Info Description Info Description"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="success"
            title="Success Text"
            description="Success Description Success Description Success Description"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="warning"
            title="Warning Text"
            description="Warning Description Warning Description Warning Description"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
        <el-col :md="6" :sm="12" :xs="24">
          <ele-alert
            show-icon
            type="error"
            title="Error Text"
            description="Error Description Error Description Error Description Error Description"
            style="margin-bottom: 12px"
            :effect="effect"
          />
        </el-col>
      </el-row>
      <div style="margin: 8px 0">嵌套使用、操作按钮:</div>
      <el-row :gutter="16">
        <el-col :md="6" :sm="24" :xs="24">
          <ele-alert
            show-icon
            title="嵌套使用"
            :closable="false"
            :effect="effect"
            :icon-props="{ style: { fontSize: '18px', marginTop: '3px' } }"
            style="margin-bottom: 12px"
          >
            <ele-alert
              show-icon
              type="error"
              title="Error Description Error Description"
              :effect="effect"
              :title-style="{ fontSize: '13px', lineHeight: '18px' }"
            />
          </ele-alert>
        </el-col>
        <el-col :md="6" :sm="24" :xs="24">
          <ele-alert
            show-icon
            title="Info Text"
            description="Info Description Info Description"
            :effect="effect"
            style="margin-bottom: 12px"
          >
            <template #action>
              <div
                :style="{
                  display: 'flex',
                  'flex-direction': 'column',
                  '--el-fill-color-light': 'rgba(0, 0, 0, 0.06)',
                  '--el-fill-color': 'rgba(0, 0, 0, 0.15)'
                }"
              >
                <el-button type="primary" size="small" style="width: 72px">
                  Accept
                </el-button>
                <el-button
                  :text="effect !== 'dark'"
                  :type="effect === 'dark' ? 'primary' : void 0"
                  size="small"
                  style="margin: 4px 0 0 0; width: 72px"
                >
                  Decline
                </el-button>
              </div>
            </template>
          </ele-alert>
        </el-col>
        <el-col :md="6" :sm="24" :xs="24">
          <ele-alert
            show-icon
            type="success"
            title="Success Text"
            :effect="effect"
            style="margin-bottom: 12px"
          >
            <template #action>
              <div
                :style="{
                  '--el-fill-color-light': 'rgba(0, 0, 0, 0.06)',
                  '--el-fill-color': 'rgba(0, 0, 0, 0.15)'
                }"
              >
                <el-button
                  :text="effect !== 'dark'"
                  :type="effect === 'dark' ? 'success' : void 0"
                  size="small"
                >
                  UNDO
                </el-button>
              </div>
            </template>
          </ele-alert>
        </el-col>
        <el-col :md="6" :sm="24" :xs="24">
          <ele-alert
            show-icon
            type="error"
            title="Error Text"
            :closable="false"
            :effect="effect"
            style="margin-bottom: 12px"
          >
            <template #action>
              <div
                :style="{
                  '--el-fill-color-light': 'rgba(0, 0, 0, 0.06)',
                  '--el-fill-color': 'rgba(0, 0, 0, 0.15)'
                }"
              >
                <el-button
                  :text="effect !== 'dark'"
                  :type="effect === 'dark' ? 'danger' : void 0"
                  size="small"
                  style="padding: 0 6px"
                >
                  UNDO
                </el-button>
              </div>
            </template>
          </ele-alert>
        </el-col>
      </el-row>
      <option-item label="主题风格">
        <el-radio-group v-model="effect">
          <el-radio label="light">light</el-radio>
          <el-radio label="dark">dark</el-radio>
        </el-radio-group>
      </option-item>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import OptionItem from '../avatar/components/option-item.vue';

  // 主题风格
  const theme = ref(0);

  /* 打开消息 */
  const showMessage = (type) => {
    const messages = {
      success: '这是一条成功的提示',
      warning: '这是一条警告的提示',
      error: '这是一条错误的提示',
      info: '这是一条普通的提示'
    };
    EleMessage({
      type,
      message: messages[type],
      plain: theme.value === 1,
      original: theme.value === 2,
      showClose: true
    });
  };

  /* 打开加载提示 */
  const showLoading = (mask, centered) => {
    const loading = EleMessage.loading({
      message: '正在加载中..',
      plain: theme.value === 1,
      original: mask ? false : theme.value === 2,
      showClose: true,
      mask,
      centered
    });
    setTimeout(() => {
      loading.close();
    }, 3000);
  };

  //
  const effect = ref('light');
</script>

<script>
  export default {
    name: 'ExtensionMessage'
  };
</script>
