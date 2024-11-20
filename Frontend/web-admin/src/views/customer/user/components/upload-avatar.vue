<!-- 头像上传 -->
<template>
  <el-upload
    class="avatar-uploader"
    ref="uploadRef"
    :auto-upload="false"
    :show-file-list="false"
    :before-upload="beforeAvatarUpload"
    :on-change="handleFileChange"
  >
    <el-avatar
      #trigger
      :size="80"
      :src="displayAvatar"
      class="upload-avatar"
    />
  </el-upload>
</template>
<script setup>
import { ref, watch } from 'vue';
import { EleMessage } from 'ele-admin-plus/es';

// 定义事件
const emit = defineEmits(['avatarChange']);

// 定义 Props
const props = defineProps({
  avatarUrl: String, // 默认头像路径
  defaultAvatar: {
    type: String,
    default: ''
  }
});

// 当前选中文件
const selectedFile = ref(null);

// 计算显示的头像 URL
const displayAvatar = ref(props.avatarUrl || props.defaultAvatar);
watch(
  () => props.avatarUrl,
  (newVal) => {
    displayAvatar.value = newVal || props.defaultAvatar;
  },
  { immediate: true }
);

// 验证上传的文件
const beforeAvatarUpload = (rawFile) => {
  if (!['image/jpeg', 'image/png'].includes(rawFile.type)) {
    EleMessage.error('头像图片必须为 JPG 或 PNG 格式!');
    return false;
  }
  if (rawFile.size / 1024 / 1024 > 2) {
    EleMessage.error('头像图片大小不能超过 2MB!');
    return false;
  }
  return true;
};

// 文件选择后处理
const handleFileChange = (file) => {
  selectedFile.value = file.raw;

  // 动态生成图片的临时 URL
  displayAvatar.value = URL.createObjectURL(selectedFile.value);

  // 触发父组件的更新事件
  emit('avatarChange', selectedFile.value);
};
</script>
