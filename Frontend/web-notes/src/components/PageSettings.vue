<template>
    <div class="PageSettings text-select">
        <div class="Settings-item">
            <p class="settingsTitle">字体</p>
            <div class="contentBox fontBox">
                <div class="item" v-for="(item, index) in data.font" :key="index"
                    :class="{ 'active': item.value == StorePage.pageData.font }"
                    @click="updateSetting({ font: item.value })">
                    <div class="PreviewText">
                        Ag汉
                    </div>
                    {{ item.name }}
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">字体大小</p>
            <div class="contentBox fontSizeBox">
                <div class="item" v-for="(item, index) in data.fontsize" :key="index"
                    :class="{ 'active': item == StorePage.pageData.size }" @click="updateSetting({ size: item })">
                    {{ item }}px
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面布局</p>
            <div class="contentBox layout">
                <div class="item" v-for="(item, index) in data.layout" :key="index"
                    :class="{ 'active': item.value == StorePage.pageData.layout }"
                    @click="updateSetting({ layout: item.value })">
                    <n-icon size="30">
                        <component :is="item.icon" />
                    </n-icon>
                    <p class="PreviewText">{{ item.name }}</p>
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面权限</p>
            <div class="contentBox">
                <div class="item select">
                    <p>只读</p> <el-switch v-model="StorePage.pageData.readonly" :active-value="'1'" :inactive-value="'0'"
                        @change="SetReadOnly" />
                </div>
                <!-- <div class="item select">
                    <p>加密</p><el-switch v-model="value1" />
                </div> -->
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">其它</p>
            <div class="contentBox">
                <!-- <div class="item select">
                    <p>标题自动编号</p><n-switch size="small" />
                </div> -->
                <!-- <div class="item select">
                    <p>页面底部信息</p><el-switch v-model="value1" />
                </div> -->
                <!-- <div class="item select">
                    <p>转为模板</p><el-switch v-model="StorePage.pageData.template" :active-value="1" :inactive-value="0"
                        @change="updateSetting({ template: StorePage.pageData.template == 0 ? 0 : 1 })" />
                </div> -->
                <el-tooltip class="box-item" content="暂未实现！！" placement="top">
                    <div class="item select">
                        <p>页面历史</p>
                    </div>
                </el-tooltip>
                <!-- <div class="item select">
                    <p>页面背景</p>
                </div> -->
                <div class="item select" @click="exportMarkdown">
                    <p>导出&nbsp;/&nbsp;下载Markdown</p>
                </div>
                <el-tooltip class="box-item" content="暂未实现！！" placement="top">
                    <div class="item select">
                        <p>导入</p>
                    </div>
                </el-tooltip>
                <div class="item select" @click="DeletePageFun(StorePage.pageData)">
                    <p>删除</p>
                </div>
            </div>
        </div>
        <div class="Settings-item">
            <p class="settingsTitle">页面信息</p>
            <div class="contentBox info">
                <div class="item">
                    创建时间：{{ StorePage.pageData.createTime }}
                </div>
                <!-- <div class="item">
                    创建者：Yoko
                </div> -->
                <div class="item">
                    最后编辑于：{{ StorePage.pageData.updateTime }}
                </div>
                <!-- <div class="item">
                    编辑者：Yoko
                </div> -->
                <!-- <div class="item">
                    页面引用：2
                </div> -->
                <!-- <div class="item">
                    字数：400
                </div>
                <div class="item">
                    块数统计：20
                </div> -->
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref, markRaw } from 'vue';
import { ReadingModeMobile24Regular, ArrowAutofitWidth20Regular, PhoneSpanIn16Regular, Phone16Regular, AutoFitWidth20Regular } from '@vicons/fluent'
import { update } from '@/api/note/index.js'
import { useEditorPageStore } from '@/stores/EditorPage'
const storeEditor = useEditorPageStore()
import { usePageStore } from '@/stores/page'
const StorePage = usePageStore()
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()
import { getSpacePage, upRecycle } from '@/api/note/index.js'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'
const router = useRouter()



// 使用 markRaw 来标记组件
const AutoFitWidth20RegularIcon = markRaw(AutoFitWidth20Regular);
const ArrowAutofitWidth20RegularIcon = markRaw(ArrowAutofitWidth20Regular);
const ReadingModeMobile24RegularIcon = markRaw(ReadingModeMobile24Regular);
const Phone16RegularIcon = markRaw(Phone16Regular);


let data = ref({
    font: [
        {
            name: '默认',
            font: 'moren',
            value: 'default'
        },
        {
            name: '衬线体',
            font: 'cehng',
            value: 'serif'
        },
        {
            name: '等宽体',
            font: 'deng',
            value: 'monospace'
        }
    ],
    fontsize: ['12', '14', '16', '18'],
    layout: [
        {
            icon: AutoFitWidth20RegularIcon,
            name: "全宽",
            value: 'big'
        },
        {
            icon: ArrowAutofitWidth20RegularIcon,
            name: "宽松",
            value: 'loose'
        },
        {
            icon: ReadingModeMobile24RegularIcon,
            name: "默认",
            value: 'default'
        },
        {
            icon: Phone16RegularIcon,
            name: "手机",
            value: 'mobile'
        },
    ]
})


// 更新设置
let updateSetting = (val) => {
    update({ pageId: StorePage.pageData.pageId, ...val }).then((data) => {
        console.log("修改成功", data);
        StorePage.pageData = data
        store.getSpaceData(StorePage.pageData.spaceId)
    }).catch((e) => {
        console.error('修改失败', e);
    });
}


// 设置只读
let SetReadOnly = () => {
    updateSetting({ readonly: StorePage.pageData.readonly == '0' ? '0' : '1' })
    storeEditor.editor.setEditable(StorePage.pageData.readonly == '0' ? true : false)
}


// 删除页面
let DeletePageFun = (val) => {
    console.log(val);

    upRecycle({ pageId: val.pageId, status: 1 }).then((msg) => {
        console.log("删除成功", msg);
        // if (store.routerParamsId.pageId == val) {
        router.push('/space/' + val.spaceId)
        // }
        ElMessage({
            message: msg,
            type: 'success',
        });
        setTimeout(() => {
            getSpacePage({ spaceId: store.routerParamsId.spaceId }).then((data) => {
                console.log("获取当前空间的所有笔记");
                store.spacePageData = data;
            }).catch((e) => {
                console.error('获取失败', e);
            });
        }, 100);
    }).catch((e) => {
        console.error(e);
    });
}


// 导出markdown
// 导入 Turndown.js
import TurndownService from "turndown";

// 初始化 Turndown.js
const turndownService = new TurndownService({
    headingStyle: "atx", // 设置标题风格为 `#`
    bulletListMarker: "-", // 列表符号设置为 `-`
    codeBlockStyle: "fenced", // 代码块样式为围栏样式 (```)
});

// 自定义规则（可选，根据需要添加）
turndownService.addRule("removeStyles", {
    filter: ["style", "script"], // 过滤 <style> 和 <script> 标签
    replacement: () => "",
});

// 导出 Markdown 文件的方法
const exportMarkdown = () => {
    // 假设 editor 是你的编辑器实例
    const htmlContent = storeEditor.editor.getHTML(); // 替换为你的实际调用方法

    // 转换 HTML 为 Markdown
    const markdownContent = turndownService.turndown(htmlContent);

    // 创建 Blob 对象
    const blob = new Blob([markdownContent], { type: "text/markdown;charset=utf-8" });

    // 创建下载链接
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = StorePage.pageData.title ? StorePage.pageData.title : '未命名页面' + ".md"; // 默认文件名
    link.click();

    // 释放 URL 对象
    URL.revokeObjectURL(url);
};
</script>
<style scoped lang='scss'>
.PageSettings {
    .Settings-item {
        margin-bottom: 2rem;


        .settingsTitle {
            font-size: 14px;
            padding: 4px 0;
            margin: 4px 0;
            color: #999;
        }

        .contentBox {
            width: 100%;
        }

        .select {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-radius: 4px;
            cursor: pointer;
            padding: 4px;
            margin-bottom: 10px;
        }

        .select:hover,
        .select:active {
            background-color: #F7F7FA;
        }

        // 字体
        .fontBox {
            display: flex;
            justify-content: space-between;

            .item {
                width: 60px;
                height: 60px;
                padding: 4px;
                box-sizing: border-box;
                // border: 1px solid #DCDCDC;
                border-radius: 4px;
                color: #999;
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                cursor: pointer;

                .PreviewText {
                    font-size: 18px;
                    color: #333;
                }


            }

            .item.active .PreviewText {
                color: #18A0FB;
            }

            .item:hover {
                background-color: #F7F7FA;
            }
        }

        // 字体大小
        .fontSizeBox {
            display: flex;
            justify-content: space-between;

            .item {
                padding: 2px 4px;
                box-sizing: border-box;
                font-size: 14px;
                color: #999;
                border: 1px solid #DCDCDC;
                border-radius: 4px;
                cursor: pointer;
            }

            .item.active {
                color: #18A0FB;
            }

            .item:hover {
                background-color: #F7F7FA;
            }
        }

        // 布局
        .layout {
            display: flex;
            justify-content: space-between;

            .item {
                width: 60px;
                height: 60px;
                padding: 4px;
                box-sizing: border-box;
                border-radius: 4px;
                color: #999;
                font-size: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                cursor: pointer;
            }

            .item.active {
                color: #18A0FB !important;
            }

            .item:hover {
                background-color: #F7F7FA;
            }
        }

        // 页面信息
        .info {
            font-size: 12px;
            color: #999;
        }
    }
}
</style>
