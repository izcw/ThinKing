<template>
  <ele-page :multi-card="true">
    <ele-card>
      <!-- 按钮 -->
      <div style="margin-bottom: 16px">
        <el-space>
          <el-button type="primary" class="ele-btn-icon" @click="setContent">
            修改内容
          </el-button>
          <el-button type="primary" class="ele-btn-icon" @click="showHtml">
            获取内容
          </el-button>
          <el-button
            class="ele-btn-icon"
            :type="disabled ? 'primary' : 'danger'"
            @click="toggleDisabled"
          >
            {{ disabled ? '启用' : '禁用' }}
          </el-button>
        </el-space>
      </div>
      <!-- 编辑器 -->
      <tinymce-editor
        ref="editorRef"
        :init="config"
        v-model="content"
        :disabled="disabled"
      />
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { ElMessageBox } from 'element-plus';
  import TinymceEditor from '@/components/TinymceEditor/index.vue';

  //
  const editorRef = ref(null);

  // 编辑器配置
  const config = ref({
    height: 520,
    // 自定义文件上传(这里使用把选择的文件转成blob演示)
    file_picker_callback: (callback, _value, meta) => {
      const input = document.createElement('input');
      input.setAttribute('type', 'file');
      // 设定文件可选类型
      if (meta.filetype === 'image') {
        input.setAttribute('accept', 'image/*');
      } else if (meta.filetype === 'media') {
        input.setAttribute('accept', 'video/*');
      }
      input.onchange = () => {
        const file = input.files?.[0];
        if (!file) {
          return;
        }
        if (meta.filetype === 'media') {
          if (!file.type.startsWith('video/')) {
            editorRef.value?.alert({ content: '只能选择视频文件' });
            return;
          }
        }
        if (file.size / 1024 / 1024 > 20) {
          editorRef.value?.alert({ content: '大小不能超过 20MB' });
          return;
        }
        // 实际项目这里应该上传到后端得到文件url而不是转成blob
        const reader = new FileReader();
        reader.onload = (e) => {
          if (e.target?.result != null) {
            const blob = new Blob([e.target.result], { type: file.type });
            callback(URL.createObjectURL(blob));
          }
        };
        reader.readAsArrayBuffer(file);
      };
      input.click();
    }
  });

  // 编辑器内容
  const content = ref('');

  // 是否禁用
  const disabled = ref(false);

  /* 获取编辑器内容 */
  const showHtml = () => {
    ElMessageBox.alert(content.value, '编辑器内容', {
      confirmButtonText: '知道了',
      closeOnClickModal: true,
      callback: () => {},
      draggable: true
    });
  };

  /* 修改编辑器内容 */
  const setContent = () => {
    content.value = [
      '<div style="text-align: center;color: #fff;background-image: linear-gradient( 135deg, #4C83FF 10%, #2AFADF 100%);padding: 32px 0;">',
      '   <div style="font-size: 28px;margin-bottom: 16px;">EleAdminPlus后台管理模板</div>',
      '   <div style="font-size:18px">通用型后台管理模板，界面美观、开箱即用，拥有丰富的组件和模板</div>',
      '</div><br/>'
    ].join('');
  };

  /* 禁用启用切换 */
  const toggleDisabled = () => {
    disabled.value = !disabled.value;
  };
</script>

<script>
  export default {
    name: 'ExtensionEditor'
  };
</script>
