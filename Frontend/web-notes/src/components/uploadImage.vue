<template>
    <div class="upload-container">
        <!-- 显示拖拽区域 -->
        <div
            class="drag-area"
            @dragover.prevent="handleDragOver"
            @drop.prevent="handleDrop"
            @click="triggerInputClick"
        >
            <p>将文件拖拽到此区域或</p>
            <el-button type="primary" plain>点击上传</el-button>
            <input type="file" ref="fileInput" accept="image/jpeg, image/png" @change="handleFileChange"
                style="display: none" />
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore()

// 定义 Base64 图片字符串
const base64Image = ref('');

// 触发文件选择框
const triggerInputClick = () => {
    const fileInput = document.querySelector('input[type="file"]');
    fileInput.click();
};

// 处理文件选择
const handleFileChange = (event) => {
    const file = event.target.files[0]; // 获取选择的文件

    // 文件类型判断
    if (file && (file.type === 'image/jpeg' || file.type === 'image/png')) {
        // 文件大小判断：5MB = 5 * 1024 * 1024 字节
        if (file.size / 1024 / 1024 < 5) {
            // 使用 FileReader 转换文件为 Base64
            const reader = new FileReader();
            reader.readAsDataURL(file);  // 读取文件为 DataURL
            reader.onload = () => {
                // 获取 Base64 编码
                base64Image.value = reader.result;
                // console.log('Base64 Image:', base64Image.value);  // 打印 Base64 编码
                storeEditor.editor.chain().focus().setImage({ src: base64Image.value }).run();
            };
        } else {
            ElMessage.warning('文件大小不能超过 5MB');
        }
    } else {
        ElMessage.warning('只能上传 JPG/PNG 文件');
    }
};

// 处理拖拽文件
const handleDrop = (event) => {
    const file = event.dataTransfer.files[0]; // 获取拖拽的文件

    // 文件类型判断
    if (file && (file.type === 'image/jpeg' || file.type === 'image/png')) {
        // 文件大小判断：5MB = 5 * 1024 * 1024 字节
        if (file.size / 1024 / 1024 < 5) {
            // 使用 FileReader 转换文件为 Base64
            const reader = new FileReader();
            reader.readAsDataURL(file);  // 读取文件为 DataURL
            reader.onload = () => {
                // 获取 Base64 编码
                base64Image.value = reader.result;
                // console.log('Base64 Image:', base64Image.value);  // 打印 Base64 编码
                storeEditor.editor.chain().focus().setImage({ src: base64Image.value }).run();
            };
        } else {
            ElMessage.warning('文件大小不能超过 5MB');
        }
    } else {
        ElMessage.warning('只能上传 JPG/PNG 文件');
    }
};

// 拖拽区域需要显示提示
const handleDragOver = (event) => {
    event.preventDefault(); // 阻止默认行为，允许拖拽文件
};
</script>

<style scoped lang="scss">
.upload-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50px;
    max-height: 50px;
    margin-top: 50px;
}

.drag-area {
    text-align: center;
    border: 2px dashed #409eff;
    padding: 30px;
    border-radius: 10px;
    width: 100%;
    max-width: 100%;
    max-height: 100%;
    background-color: #f7f8fa;
    transition: background-color 0.3s ease;
}

.drag-area p {
    margin: 10px 0;
    font-size: 16px;
    color: #409eff;
}

.drag-area:hover {
    background-color: #eef6fc;
}

.base64-output {
    margin-top: 20px;
    word-wrap: break-word;
    word-break: break-all;
    font-size: 14px;
}

.base64-output span {
    color: #409eff;
}
</style>
