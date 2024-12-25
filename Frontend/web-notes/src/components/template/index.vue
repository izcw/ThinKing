<template>
    <div class="blankPage">
        <CollapseMenuBox />
        <div class="container">
            <div class="banner">
                <h1>模版中心</h1>
            </div>

            <div style="display: flex;align-items: center;margin-bottom: 3rem;">
                <el-input v-model="SearchValue" size="large" placeholder="请搜索模版名称" />
                <el-button type="primary" size="large" @click="SearchTemplate" plain>搜索</el-button>
            </div>
            <div class="template">
                <!-- <div class="catalog">
                    <div class="item" v-for="(item, index) in menuList" :key="index"
                        :class="{ active: selectItem == index }" @click="SearchTemplate(item, index)">
                        <el-text truncated>{{ item.label }}</el-text>
                    </div>
                </div> -->
                <div class="content">
                    <!-- {{ TemplateData.length }} -->
                    <el-empty v-show="!TemplateData || TemplateData.length <= 0" :image-size="100" :image="logoGrey"
                        description="没有此模版" style="margin: 3rem;" />

                    <el-row :gutter="20" v-show="TemplateData">
                        <el-col :span="12" :md="12" :lg="6" :xl="4" v-for="(item, index) in TemplateData" :key="index">
                            <div class="item">
                                <div class="PreviewBox">
                                    <img :src="FILE_PATH_API_URL + item.preview" alt="">
                                    <el-tooltip class="box-item" content="未实现" placement="top">
                                        <el-button color="#626aef" size="small"
                                            @click="useTemplateFun(item.pageId)">使用</el-button>
                                    </el-tooltip>
                                </div>
                                <h3><el-text truncated>{{ item.templateName }}</el-text></h3>
                                <p><el-text type="info" size="small" line-clamp="2">{{ item.comments }}</el-text>
                                </p>
                            </div>
                        </el-col>
                    </el-row>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref, reactive, defineEmits } from 'vue'
import CollapseMenuBox from '@/components/CollapseMenu.vue';
import { FILE_PATH_API_URL } from "@/config/setting"
import { PageTemplate } from '@/api/template/index'
import { useTemplate } from '@/api/note/index'
import logoGrey from "@/assets/images/logo-grey.png"
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()

let selectItem = ref(0)

const menuList = ref([
    { label: '全部', icon: '图标' },
    { label: '计划', icon: '图标' },
    { label: '学习', icon: '图标' },
    { label: '打卡', icon: '图标' }
]);


const query = reactive({
    page: 1,
    limit: 20,
    sort: "create_time",
    order: "desc",
    templateName: "",
})

let TemplateData = ref()


// 获取数据
let getTemplate = () => {
    PageTemplate(query).then((val) => {
        TemplateData.value = val
        return
    }).catch((e) => {
        console.error('获取失败', e);
    });
}
getTemplate();


// 搜索模版
let SearchValue = ref()
let SearchTemplate = () => {
    query.templateName = SearchValue.value;
    getTemplate()
}


const emit = defineEmits();
// 使用模版
let useTemplateFun = (valid) => {
    useTemplate({ pageId: valid, spaceId: store.routerParamsId.spaceId }).then((val) => {
        console.log(val);
        router.push('/space/' + store.routerParamsId.spaceId + '/' + val.data.pageId);
        store.getSpaceData(store.routerParamsId.spaceId);
        // 触发关闭对话框的事件
        emit('closeDialog');
        ElMessage({
            message: val.message,
            type: 'success',
        });
        return
    }).catch((e) => {
        ElMessage.error('使用失败')
        console.error('使用失败', e);
    });
}
</script>
<style scoped lang='scss'>
.container {
    box-sizing: border-box;
    height: 100%;
    margin: 0 auto;


    .banner {
        width: 100%;
        height: 300px;
        background-color: #d7c3e8;
        background-image: url("/src/assets/images/template-banner2.png");
        background-position: center;
        background-repeat: no-repeat;
        background-size: auto 100%;
        margin-bottom: 60px;
        border-radius: 10px;

        display: flex;
        align-items: center;

        h1 {
            padding-left: 30px;
            font-size: 34px;
            color: #fff;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
        }
    }

    .template {
        display: flex;

        .catalog {
            width: 240px;
            height: 100%;
            border-left: 1px solid #eee;
            box-sizing: border-box;
            margin-right: 1rem;

            .item {
                cursor: pointer;
                padding: 6px 1rem;
                box-sizing: border-box;
                margin-bottom: 4px;
                border-radius: 4px;

                display: flex;
                align-items: center;

                span {
                    max-width: 240px;
                }
            }

            .item:hover,
            .item:active,
            .item.active {
                background-color: #EFEFEE;
            }

            .item:hover span,
            .item:active span,
            .item.active span {
                color: #444;
            }
        }

        .content {
            width: 100%;
            height: 100%;

            .item {
                width: 100%;
                height: 300px;
                margin-bottom: 30px;
                cursor: pointer;

                .PreviewBox {
                    width: 100%;
                    height: 180px;
                    position: relative;

                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        object-position: center;
                        border: 1px solid #EFEFEE;
                        box-sizing: border-box;
                    }

                    .el-button {
                        position: absolute;
                        bottom: 1rem;
                        right: 1rem;
                        opacity: 0;
                        transition: all 0.3s ease;
                    }

                }

                &:hover,
                &:active {
                    .el-button {
                        opacity: 1;
                    }
                }

                h3 {
                    margin-top: 6px;

                    span {
                        color: #444;
                    }
                }

            }
        }


    }
}

@media (max-width: 1200px) {
    .template {
        flex-direction: column;

        .catalog {
            width: 100% !important;
            margin-bottom: 1rem;
        }

        .content {
            margin-left: 0 !important;
        }
    }
}
</style>
