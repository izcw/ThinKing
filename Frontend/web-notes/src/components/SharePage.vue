<template>
    <el-tabs v-model="activeName" class="demo-tabs">
        <el-tab-pane label="公开分享" name="open">
            <div class="openShare" v-if="StorePage.pageData">
                <div class="item">
                    <p>公开分享</p>
                    <el-switch v-model="StorePage.pageData.share" :active-value="1" :inactive-value="0"
                        @change="updateShare" />
                </div>
                <div v-show="StorePage.pageData.share == 1"
                    style="width: 100%;display: flex;flex-direction: column;align-items: center;">
                    <div style="margin:1rem 0;">
                        <qrcode-vue :value="QrcodeData.url" :size="QrcodeData.size"
                            :image-settings="QrcodeData.iconImage" level="H" render-as="svg" />
                    </div>
                    <div class="item">
                        <el-text size="small" truncated>{{ QrcodeData.url }}</el-text>
                        <el-button size="small" style="margin-left:10px;" @click="copyLink">{{ copyStatus }}</el-button>
                    </div>
                </div>
            </div>
        </el-tab-pane>
    </el-tabs>
</template>
<script setup>
import { ref, reactive, watch } from 'vue'
import QrcodeVue from 'qrcode.vue'
import { update } from '@/api/note/index.js'
import logoImages from '@/assets/images/logo.png'
import { WEBSITE_LINK_URl } from "@/config/setting"
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()

const activeName = ref('open')


// 更新
let updateShare = () => {
    console.log("???");
    let share = StorePage.pageData.share == 0 ? 0 : 1
    update({ pageId: StorePage.pageData.pageId, share: share }).then((data) => {
        console.log("修改成功???ntm", data);
        StorePage.pageData = data
    }).catch((e) => {
        console.error('修改失败', e);
    });
}

// 分享二维码
let QrcodeData = reactive(
    {
        url: WEBSITE_LINK_URl + '/share/' + StorePage.pageData.pageId,
        iconImage: {
            src: logoImages,
            height: 20,
            width: 20,
            excavate: true,
        },
        size: 100,
    }
)

// 自定义拷贝链接函数
let copyStatus = ref("拷贝链接")
const copyLink = () => {
    const textarea = document.createElement('textarea');
    textarea.value = QrcodeData.url;
    document.body.appendChild(textarea);
    textarea.select();
    try {
        document.execCommand('copy');
        console.log('链接已成功复制到剪贴板');
        copyStatus.value = "拷贝成功"
        setTimeout(() => {
            copyStatus.value = "拷贝链接"
        }, 500)
        // 这里可以添加提示信息组件（如Element Plus的el-message等）来提示用户复制成功
    } catch (err) {
        console.error('复制链接失败', err);
        // 同样可以添加提示组件来提示用户复制失败
    } finally {
        document.body.removeChild(textarea);
    }
}
</script>
<style scoped lang='scss'>
.openShare {
    width: 100%;

    .item {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
}
</style>
