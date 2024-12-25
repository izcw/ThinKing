<template>
    <bubble-menu :editor="editor" :tippy-options="{ duration: 50 }" v-if="editor">
        <div class="bubble-menu">
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="0">
                <template #content>加粗<br />Ctrl+B</template>
                <el-button size="small" @click="editor.chain().focus().toggleBold().run()"
                    :class="{ 'is-active': editor.isActive('bold') }">
                    <b>B</b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="0">
                <template #content>斜体<br />Ctrl+I</template>
                <el-button size="small" @click="editor.chain().focus().toggleItalic().run()"
                    :class="{ 'is-active': editor.isActive('italic') }">
                    <b><i>i</i></b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="0">
                <template #content>删除线<br />Ctrl+Shift+S</template>
                <el-button size="small" @click="editor.chain().focus().toggleStrike().run()"
                    :class="{ 'is-active': editor.isActive('strike') }">
                    <b><del>del</del></b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="0">
                <template #content>下划线<br />Ctrl+U</template>
                <el-button size="small" @click="editor.chain().focus().toggleUnderline().run()"
                    :class="{ 'is-active': editor.isActive('underline') }">
                    <b><u>U</u></b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="50">
                <template #content>标记为代码<br />Ctrl+E</template>
                <el-button size="small" @click="editor.commands.toggleCode()"
                    :class="{ 'is-active': editor.isActive('code') }">
                    <b>&lt;/&gt;</b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="0">
                <template #content>表格</template>

                <el-dropdown placement="top-start">
                    <el-button size="small">
                        <n-icon size="24">
                            <Table24Regular />
                        </n-icon>
                    </el-button>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item @click="editor.commands.addColumnBefore()">
                                <n-icon size="12">
                                    <ArrowLeft12Regular />
                                </n-icon>
                                在前面添加一列
                            </el-dropdown-item>
                            <el-dropdown-item @click="editor.commands.addColumnAfter()">
                                <n-icon size="12">
                                    <ArrowRight12Regular />
                                </n-icon>
                                在后面添加一列
                            </el-dropdown-item>
                            <el-dropdown-item @click="editor.commands.deleteColumn()">
                                <n-icon size="12">
                                    <TableDeleteColumn20Filled />
                                </n-icon>
                                删除列
                            </el-dropdown-item>
                            <el-dropdown-item @click="editor.commands.addRowBefore()">
                                <n-icon size="12">
                                    <ArrowUp16Filled />
                                </n-icon>
                                在上方添加一行
                            </el-dropdown-item>
                            <el-dropdown-item @click="editor.commands.addRowAfter()">
                                <n-icon size="12">
                                    <ArrowDown16Filled />
                                </n-icon>
                                在下方添加一行
                            </el-dropdown-item>
                            <el-dropdown-item @click="editor.commands.deleteRow()">
                                <n-icon size="12">
                                    <TableDeleteRow20Filled />
                                </n-icon>
                                删除行
                            </el-dropdown-item>

                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="50">
                <template #content>下标<br />Ctrl+,</template>
                <el-button size="small" @click="editor.commands.toggleSubscript()"
                    :class="{ 'is-active': editor.isActive('subscript') }">
                    <b>X<sub>2</sub></b>
                </el-button>
            </el-tooltip>
            <el-tooltip class="box-item" effect="dark" placement="top" :hide-after="50">
                <template #content>上标</template>
                <el-button size="small" @click="editor.commands.toggleSuperscript()"
                    :class="{ 'is-active': editor.isActive('superscript') }">
                    <b>X<sup>2</sup></b>
                </el-button>
            </el-tooltip>

            <!-- 添加链接 -->
            <el-popover placement="bottom" :width="350" @show="linkPopover" trigger="click" title="添加链接"
                :hide-after="100">
                <template #reference>
                    <el-button size="small" :class="{ 'is-active': editor.isActive('link') }">
                        <b>链接</b>
                    </el-button>
                </template>
                <div style="display: flex;margin: 1rem 0;">
                    <el-input v-model.trim="linkUrl" clearable style="width: 100%;"
                        placeholder="请输入链接：https://xxx.com" />
                    <el-button @click="setLink">
                        确定
                    </el-button>
                </div>
                <el-button size="small" style="width: 100%;" @click="cleanLink">
                    清除链接
                </el-button>
            </el-popover>



            <!-- 文本颜色 -->
            <el-popover placement="bottom" :width="216" trigger="click" title="文本颜色" :hide-after="100">
                <template #reference>
                    <el-button size="small">T</el-button>
                </template>
                <div class="SetColorBox">
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">最近使用</el-text></p>
                        <div class="item-list">
                            <div style="color: #05A045;border: 1px solid #05A045">T</div>
                        </div>
                    </div>
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">文本颜色</el-text></p>
                        <div class="item-list">
                            <div style="color: #333333;border: 1px solid #333333" @click="editor.commands.unsetColor()">
                                T</div>
                            <div style="color: #999999;border: 1px solid #999999"
                                @click="props.editor.commands.setColor('#999999')">T
                            </div>
                            <div style="color: #E91E63;border: 1px solid #E91E63"
                                @click="props.editor.commands.setColor('#E91E63')">T
                            </div>
                            <div style="color: #F57F17;border: 1px solid #F57F17"
                                @click="props.editor.commands.setColor('#F57F17')">T
                            </div>
                            <div style="color: #FFA000;border: 1px solid #FFA000"
                                @click="props.editor.commands.setColor('#FFA000')">T
                            </div>
                            <div style="color: #409EFF;border: 1px solid #409EFF"
                                @click="props.editor.commands.setColor('#409EFF')">T
                            </div>
                            <div style="color: #512DA8;border: 1px solid #512DA8"
                                @click="props.editor.commands.setColor('#512DA8')">T
                            </div>
                            <div style="color: #43A047;border: 1px solid #43A047"
                                @click="props.editor.commands.setColor('#43A047')">T
                            </div>
                        </div>
                    </div>
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">自定义颜色</el-text></p>
                        <div class="item-list">
                            <div style="width: auto;">
                                <ColorPicker ref="colorPicker" format="hex" :disableHistory="true" pureColor="#464CEC"
                                    shape="square" :roundHistory="true" :disableAlpha="true"
                                    @update:pureColor="SetFontColor" />
                            </div>
                        </div>
                    </div>
                </div>
            </el-popover>

            <!-- 文本高亮标注颜色 -->
            <el-popover placement="bottom" :width="216" trigger="click" title="背景颜色" :hide-after="100">
                <template #reference>
                    <el-button size="small" style="background-color: #FFFF00;">B</el-button>
                </template>
                <div class="SetColorBox">
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">最近使用</el-text></p>
                        <div class="item-list">
                            <div style="color: #05A045;border: 1px solid #05A045">T</div>
                        </div>
                    </div>
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">文本颜色</el-text></p>
                        <div class="item-list">
                            <div style="color: #333333;border: 1px solid #eee"
                                @click="editor.chain().focus().unsetHighlight().run()">
                                T</div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#E0E0E0;"
                                @click="props.editor.commands.setHighlight({ color: '#E0E0E0' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#F8BBD0;"
                                @click="props.editor.commands.setHighlight({ color: '#F8BBD0' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#FFAB91;"
                                @click="props.editor.commands.setHighlight({ color: '#FFAB91' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#FFFF00;"
                                @click="props.editor.commands.setHighlight({ color: '#FFFF00' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#BBDEFB;"
                                @click="props.editor.commands.setHighlight({ color: '#BBDEFB' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#D1C4E9;"
                                @click="props.editor.commands.setHighlight({ color: '#D1C4E9' })">T
                            </div>
                            <div style="color: #333333;border: 1px solid #cccccc;background-color:#B2DFDB;"
                                @click="props.editor.commands.setHighlight({ color: '#B2DFDB' })">T
                            </div>
                        </div>
                    </div>
                    <div class="item text-select">
                        <p><el-text class="mx-1" type="info" size="small">自定义颜色</el-text></p>
                        <div class="item-list">
                            <div style="width: auto;">
                                <ColorPicker ref="colorPicker" format="hex" :disableHistory="true" pureColor="#464CEC"
                                    shape="square" :roundHistory="true" :disableAlpha="true"
                                    @update:pureColor="SetFontHighlightColor" />
                            </div>
                        </div>
                    </div>
                </div>
            </el-popover>
        </div>
    </bubble-menu>
</template>
<script setup>
import { ref, defineProps, markRaw } from 'vue'
import { ElButton, ElPopover, ElTooltip, ElMessage } from 'element-plus'
import { Table24Regular, ArrowLeft12Regular, ArrowRight12Regular, TableDeleteColumn20Filled, ArrowUp16Filled, ArrowDown16Filled, TableDeleteRow20Filled } from '@vicons/fluent'
import { BubbleMenu } from '@tiptap/vue-3'
import { ColorPicker } from "vue3-colorpicker";
import "vue3-colorpicker/style.css";
const colorPicker = ref(null);


const props = defineProps({
    editor: {
        type: Object,
        required: true
    }
})

// 设置字体颜色
const SetFontColor = (pureColor) => {
    console.log("纯色变化:", pureColor); // 打印纯色变化
    props.editor.commands.setColor(pureColor)
}

// 设置字体高亮颜色
const SetFontHighlightColor = (pureColor) => {
    console.log("纯色变化:", pureColor); // 打印纯色变化
    props.editor.commands.setHighlight({ color: pureColor })
}



// 设置链接
let linkUrl = ref()
const setLink = () => {
    if (linkUrl.value == null || linkUrl.value == '') {
        ElMessage({
            message: '链接不能为空！',
            type: 'info',
            plain: true,
        })
        return;
    }
    props.editor.commands.toggleLink({ href: linkUrl.value, target: '_blank' })
}

// 点击链接弹出框时触发
const linkPopover = () => {
    console.log("显示");
    linkUrl.value = props.editor.getAttributes('link').href
}

// 取消链接
const cleanLink = () => {
    linkUrl.value = ''
    props.editor.commands.unsetLink()
}
</script>
<style scoped lang='scss'>
.bubble-menu {
    width: 500px;
    padding: 6px 12px;
    border-radius: 4px;
    background-color: #fff;
    box-shadow: 0 2px 10px #ccc;

}

// 设置颜色
.SetColorBox {
    .item {
        margin-bottom: 1rem;

        .item-list {
            display: flex;
            flex-wrap: wrap;

            div {
                font-weight: bold;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
                border-radius: 4px;
                cursor: pointer;
                box-sizing: border-box;
                margin: 4px;

                &:hover {
                    border-width: 2px !important;
                }
            }


        }

        p {
            margin-bottom: 6px;
        }
    }
}
</style>
