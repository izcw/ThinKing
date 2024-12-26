<template>
    <div class="uploadImage">
        <el-text class="mx-1">网络图片</el-text>
        <div style="display: flex;margin-bottom: 50px;padding-top: 10px;">
            <el-input v-model="inputImageUrl" style="width: 100%" placeholder="输入图片网络链接" />
            <el-button type="primary" style="width: 60px" plain @click="NetworkImages">确定</el-button>
        </div>

        <el-text class="mx-1">上传图片</el-text>
        <div class="upload-container">
            <!-- 显示拖拽区域 -->
            <div class="drag-area" @dragover.prevent="handleDragOver" @drop.prevent="handleDrop"
                @click="triggerInputClick">
                <p>点击上传或将文件拖拽到此区域或</p>
                <input type="file" ref="fileInput" accept="image/jpeg, image/png" @change="handleFileChange"
                    style="display: none" />
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore();


// 插入网络图片
let inputImageUrl = ref();
let NetworkImages = ()=>{
    storeEditor.editor.commands.setImage({ src: inputImageUrl.value })
    inputImageUrl.value = ''
}


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
        if (file.size / 1024 / 1024 < 2) {
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
            ElMessage.warning('文件大小不能超过 2MB');
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
.uploadImage{

    button:hover{
        color: #409eff !important;
    }
}
.upload-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50px;
    max-height: 50px;
    margin-top: 40px;
    cursor: pointer;
}

.drag-area {
    text-align: center;
    border: 2px dashed #e9e9e9;
    padding: 30px;
    border-radius: 10px;
    width: 100%;
    max-width: 100%;
    max-height: 100%;
    background-color: #f7f7f7;
    transition: background-color 0.3s ease;
}

.drag-area p {
    margin: 10px 0;
    font-size: 12px;
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
