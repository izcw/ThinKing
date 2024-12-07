<template>
    <div class="more text-select GMargin">
        <n-tooltip placement="right" trigger="hover" v-for="(item, index) in data" :key="item.id">
            <template #trigger>
                <div class="item-more" @click="changeActive(index)">
                    <n-icon size="20">
                        <component :is="item.icon" />
                    </n-icon>
                    <span>{{ item.name }}</span>
                </div>
            </template>
            <span>{{ item.describe }}</span>
        </n-tooltip>

        <div class="item-more" ref="buttonRef" v-click-outside="onClickOutside">
            <n-icon size="20">
                <Broom16Regular />
            </n-icon>
            <span>垃圾箱</span>
        </div>

        <el-popover ref="popoverRef" :virtual-ref="buttonRef" placement="right" trigger="click" :width="500"
            virtual-triggering>
            <el-input v-model="SearchGarbage" style="width: 100%;" placeholder="搜索被移入垃圾箱的页面" />
            <div class="dustbin">
                <div class="item">
                    <p>mysql</p>
                    <div class="tool">
                        <span>恢复&emsp;</span>
                        <span>彻底删除</span>
                    </div>
                </div>
            </div>
            <el-alert title="垃圾箱中超过30天的页面将自动删除" type="info" :closable="false" />
        </el-popover>


        <!-- 弹出框 -->
        <el-dialog v-model="centerDialogVisible" width="1200" align-center>
            <div style="height:800px; overflow-y: auto;">
                <component :is="currentComponent" />
            </div>
        </el-dialog><!-- 设置 -->
    </div>
</template>
<script setup>
import { ref, markRaw, computed, onBeforeUnmount } from 'vue';
import { WindowArrowUp16Filled, Diamond16Regular, Notepad24Regular, Box20Regular, Broom16Regular, BookCoins24Regular } from '@vicons/fluent'
import templateBox from '@/components/template/index.vue'
import subscribeBox from '@/components/subscribe/index.vue'


// 使用 markRaw 来标记组件
const Diamond16RegularIcon = markRaw(Diamond16Regular);
const WindowArrowUp16FilledIcon = markRaw(WindowArrowUp16Filled);

const templateBoxComponent = markRaw(templateBox);
const subscribeBoxComponent = markRaw(subscribeBox);

let data = ref([
    {
        id: 1,
        name: " 模板中心",
        describe: "查找精美的模板",
        icon: Diamond16RegularIcon,
        component: templateBoxComponent
    },
    {
        id: 2,
        name: "会员中心",
        describe: "升级享受更好的体验，点击了解》",
        icon: WindowArrowUp16FilledIcon,
        component: subscribeBoxComponent
    }])


// 居中对话框
const centerDialogVisible = ref(false) // 对话框
const activeIndex = ref(0);
const currentComponent = computed(() => data.value[activeIndex.value].component);

function changeActive(index) {
    console.log(index);

    centerDialogVisible.value = true
    activeIndex.value = index;
}



// 垃圾箱弹出框
const buttonRef = ref()
const popoverRef = ref()
const onClickOutside = () => {
    unref(popoverRef).popperRef?.delayHide?.()
}

// 垃圾箱搜索
let SearchGarbage = ref()
</script>
<style scoped lang='scss'>
.more {
    margin-top: 30px;

    .item-more {
        color: #666;
        display: flex;
        align-items: center;
        padding: 8px;
        border-radius: 4px;
        cursor: pointer;

        span {
            margin-left: 6px
        }
    }

    .item-more:hover,
    .item-more:active {
        background-color: #E9E9E9;
    }
}

// 垃圾桶
.dustbin {
    min-height: 200px;
    margin: 1rem 0 3rem 0;

    .item {
        padding: 6px 10px;
        margin: 4px 0;
        box-sizing: border-box;
        display: flex;
        align-items: center;
        justify-content: space-between;
        cursor: pointer;
    }

    .item:hover,
    .item:active {
        background-color: #E9E9E9;
    }
}

.AccountBox {
    p a {
        display: block;
        font-size: 14px;
        color: #999;
        width: 100%;
        padding: 4px 8px;
        box-sizing: border-box;
        border-radius: 4px;
        cursor: pointer;
    }

    p a:hover {
        background-color: #E9E9E9;
        color: #333;
    }

    .logo {
        display: flex;
        align-items: center;

        img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 1px solid #eee;
        }

        .info {
            margin-left: 10px;
            font-size: 14px;
            color: #333;

            .name {
                font-size: 16px;
            }

            .subscribe {
                color: #999;
            }
        }
    }
}
</style>
