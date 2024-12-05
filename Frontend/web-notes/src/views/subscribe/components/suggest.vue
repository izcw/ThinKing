<template>
    <el-row :gutter="20" class="scheme">
        <el-col :sm="24" :md="8" v-for="item in data" :key="item.id">
            <div class="item">
                <div class="title">{{ item.subscribeName }}<span class="hot" v-if="item.recommend == 1">热门方案</span>
                </div>
                <p class="describe"><el-text line-clamp="2" size="small">
                        {{ item.comments }}
                    </el-text></p>
                <div class="price">
                    <p>折扣价：<span class="Current">￥{{ item.price }}</span><span>&nbsp;/&nbsp;月</span></p>
                    <p>原&emsp;价：<del>￥{{ item.price }}<span>&nbsp;/&nbsp;月</span></del></p>
                </div>
                <el-button type="primary" @click="upgrade(item)">升级</el-button>
            </div>
        </el-col>
    </el-row>

    <!-- 支付 -->
    <el-dialog v-model="centerDialogVisible" title="支付" width="400" align-center center :show-close="false"
        :close-on-click-modal="paymentStatus">
        <div style="display: flex;display: flex;flex-direction: column;align-items: center;margin: 1rem 0;"
            v-loading="loading">
            <qrcode-vue :value="QrcodeData.url" :size="QrcodeData.size" :image-settings="QrcodeData.iconImage" level="H"
                render-as="svg" />
            <el-text class="mx-1" size="small" style="margin-top: 10px;">支付宝支付</el-text>
            <div class="price">
                {{ PendingPayment.price }}¥
            </div>
            <el-button @click="PaymentOrder" type="small">
                刷新
            </el-button>
            <el-divider />
            <el-text class="mx-1" size="small" style="margin-bottom: 10px;">其他支付</el-text>
            <div>
                <n-icon size="30">
                    <WechatOutlined style="color:#65da78;" />
                </n-icon>
                &emsp;
                <n-icon size="30">
                    <AlipayOutlined style="color:#469de2;" />
                </n-icon>
            </div>
        </div>
    </el-dialog>
</template>
<script setup>
import { ref, reactive } from 'vue'
import WeChatImages from '@/assets/images/WeChat.png'
import AlipayImages from '@/assets/images/Alipay.png'
import { PageSubscribe } from '@/api/subscribe/index'
import { AlipayOutlined, WechatOutlined } from '@vicons/antd'
import QrcodeVue from 'qrcode.vue'
import { ElMessage } from 'element-plus'
let centerDialogVisible = ref(false)

const query = reactive({
    page: 1,
    limit: 10,
    sort: "create_time",
    order: "asc",
    subscribe_name: "",
    subscribe_code: "",
    status: 0
})

let data = ref()

PageSubscribe(query).then((val) => {
    console.log(999);

    console.log(val);
    data.value = val.filter((item) => item.subscribeId != 1);
    return
}).catch((e) => {
    console.error('获取失败', e);
});


let PendingPayment = ref()

// 点击升级
let upgrade = (item) => {
    centerDialogVisible.value = true
    PendingPayment.value = item
}


// 支付二维码
let QrcodeData = reactive(
    {
        url: 'https://www.note.zhangchengwei.work',
        iconImage: {
            src: AlipayImages,
            height: 30,
            width: 30,
            excavate: true,
        },
        size: 150,
    }
)

// 模拟支付加载
let loading = ref(false)
let paymentStatus = ref(true) // 支付状态，是否可以关闭弹窗

// 支付订单
let PaymentOrder = () => {
    loading.value = true
    paymentStatus.value = false

    setTimeout(() => {
        centerDialogVisible.value = false
        loading.value = false
        paymentStatus.value = true  
        ElMessage({
            message: '支付成功',
            type: 'success',
        })
    }, 2000);
}
</script>
<style scoped lang='scss'>
// 方案
.scheme {
    // display: flex;
    margin: 3rem 0;

    .item {
        min-height: 270px;
        max-height: 270px;
        padding: 1rem;
        box-sizing: border-box;
        border: 1px solid #eee;
        margin-bottom: 1rem;
        display: flex;
        flex-direction: column;
        justify-content: space-between;

        .title {
            display: flex;
            align-items: flex-start;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 1rem;

            .hot {
                font-size: 12px;
                color: #ED6C7B;
                padding: 4px;
                border-radius: 2px;
                margin-left: 6px;
                background-color: #ffeaea;
            }
        }

        .describe {
            font-size: 14px;
            height: 40px;
            color: #666;
        }

        .price {
            margin: 1rem 0;

            p {
                font-size: 14px;
                color: #999;
            }

            .Current {
                font-weight: bold;
                font-size: 30px;
                color: #0355E3;
            }
        }
    }
}

// 支付价格
.price {
    font-size: 22px;
    color: #333;
    margin-bottom: 10px;
}
</style>
