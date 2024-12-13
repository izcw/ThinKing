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
                    <p class="oldprice">原&emsp;价：<del>￥{{ item.oldprice }}<span>&nbsp;/&nbsp;月</span></del>
                        <span class="economize">立省{{ item.oldprice - item.price }}¥</span>
                    </p>
                </div>
                <el-button type="primary" @click="upgrade(item)"
                    v-if="store.userInfoData.currentSubscription.noteSubscribeOrder == null">升级</el-button>
                <div v-else style="display: flex;flex-direction: column;">
                    <el-button type="primary" disabled>升级</el-button>
                    <div
                        style="transform: scale(0.8);display: flex;align-items: center;justify-content: center;color: #999;font-size: 12px;">
                        <n-icon>
                            <component :is="Info20RegularIcon" />
                        </n-icon>
                        <p>不可升级！当前套餐未过期</p>
                    </div>
                </div>
            </div>
        </el-col>
    </el-row>

    <!-- 支付 -->
    <el-dialog v-model="centerDialogVisible" title="支付" width="400" align-center center :show-close="false"
        :close-on-click-modal="paymentStatus">
        <div style="display: flex;display: flex;flex-direction: column;align-items: center;margin: 1rem 0;"
            v-loading="loading">
            <qrcode-vue :value="QrcodeData.url + PendingPayment.transactions" :size="QrcodeData.size"
                :image-settings="QrcodeData.iconImage" level="H" render-as="svg" />
            <el-text class="mx-1" size="small" style="margin-top: 10px;">支付宝支付</el-text>
            <div class="price">
                {{ PendingPayment.price }}¥
            </div>
            <el-button @click="PaymentOrder" type="small">
                刷新
            </el-button>
            <el-divider />
            <el-text class="mx-1" size="small" style="margin-bottom: 10px;">其他支付</el-text>
            <div class="other">
                <el-space wrap size="50">
                    <n-icon size="30" @click="PaymentMethod('Alipay')" class="item"
                        :class="{ 'active': PendingPayment.transactions == 'Alipay' }">
                        <AlipayOutlined style="color:#469de2;" />
                    </n-icon>
                    <n-icon size="30" @click="PaymentMethod('Wechat')" class="item"
                        :class="{ 'active': PendingPayment.transactions == 'Wechat' }">
                        <WechatOutlined style="color:#65da78;" />
                    </n-icon>
                </el-space>
            </div>
        </div>
    </el-dialog>
</template>
<script setup>
import { ref, reactive, markRaw } from 'vue'
import WeChatImages from '@/assets/images/WeChat.png'
import AlipayImages from '@/assets/images/Alipay.png'
import { PageSubscribe } from '@/api/subscribe/index'
import { paymentOrder } from '@/api/subscribe/order'
import { AlipayOutlined, WechatOutlined } from '@vicons/antd'
import { Info20Regular } from '@vicons/fluent'
import QrcodeVue from 'qrcode.vue'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

// 使用 markRaw 来标记组件
const Info20RegularIcon = markRaw(Info20Regular);


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

let getsubscribeorder = () => {
    PageSubscribe(query).then((val) => {
        data.value = val.filter((item) => item.subscribeId != 1);
        return
    }).catch((e) => {
        console.error('获取失败', e);
    });
}
getsubscribeorder()


// 交易参数
let PendingPayment = ref({
    price: 0.00,
    transactions: "Alipay",
    subscribeId: ''
})

let centerDialogVisible = ref(false)

// 点击升级
let upgrade = (item) => {
    console.log(item);
    centerDialogVisible.value = true
    PendingPayment.value.price = item.price
    PendingPayment.value.subscribeId = item.subscribeId
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
    loading.value = true;
    paymentStatus.value = false;
    console.log(PendingPayment.value);

    setTimeout(() => {
        paymentOrder(PendingPayment.value).then((val) => {

            if (val.code == 200) {
                ElMessage({
                    message: val.message,
                    type: 'success',
                })
            } else {
                ElMessage({
                    message: val.message,
                    type: 'warning',
                })
            }
            store.fetchUserInfo();
            centerDialogVisible.value = false
            loading.value = false
            paymentStatus.value = true
            return
        }).catch((e) => {
            console.error('支付失败', e);
        });


    }, 2000);
}

// 切换支付方式
let PaymentMethod = (val) => {
    PendingPayment.value.transactions = val;
    QrcodeData.iconImage.src = val == 'Alipay' ? AlipayImages : WeChatImages;
}
</script>
<style scoped lang='scss'>
// 方案
.scheme {
    // display: flex;
    margin: 3rem 0;

    .item {
        min-height: 290px;
        max-height: 290px;
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
                transform: scale(0.7);
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
                font-size: 12px;
                color: #999;
            }

            .Current {
                font-weight: bold;
                font-size: 30px;
                color: #0355E3;


            }

            // 原价
            .oldprice {
                font-size: 12px;

                // 节省
                .economize {
                    margin-left: 10px;
                    color: #ED6C7B;
                }
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

// 其他支付
.other .item {
    border: 2px solid transparent;
    border-radius: 4px;
    padding: 4px;
    cursor: pointer;
}

.other .item:hover,
.other .item:active,
.other .item.active {
    border: 2px solid #eee;
}
</style>
