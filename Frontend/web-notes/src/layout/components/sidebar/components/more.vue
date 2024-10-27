<template>
    <div class="more text-select GMargin">
        <n-tooltip placement="right" trigger="hover" v-for="item in data" :key="item.id">
            <template #trigger>
                <router-link :to="item.link">
                    <div class="item-more">
                        <n-icon size="20">
                            <!-- <AnimalCat20Filled /> -->
                            <component :is="item.icon" />
                        </n-icon>
                        <span>{{ item.name }}</span>
                    </div>
                </router-link>
            </template>
            <span>{{ item.describe }}</span>
        </n-tooltip>
    </div>
</template>
<script setup>
import { ref } from 'vue'
import { RouterLink, RouterView } from 'vue-router'
import { Crow, Connectdevelop, Blackberry } from '@vicons/fa'
import { Money16Regular, Diamond16Regular, BookInformation24Regular, Box20Regular,Broom16Regular, BookCoins24Regular } from '@vicons/fluent'

let data = ref([
    {
        id: 1,
        name: "会员中心",
        link: '/Yoko',
        describe: "升级享受更好的体验，点击了解》",
        icon: Money16Regular
    },
    {
        id: 2,
        name: "模板中心",
        link: '/Yoko/template',
        describe: "查找精美的模板",
        icon: Diamond16Regular
    },
    {
        id: 3,
        name: "归档",
        link: '/GuguTh67Hi/template',
        describe: "查看已完成的具有价值的笔记",
        icon: BookCoins24Regular
    },
    {
        id: 4,
        name: "文件仓库",
        link: '/GuguTh67Hi/template',
        describe: "查看引用的文件",
        icon: Box20Regular
    },
    {
        id: 5,
        name: "垃圾箱",
        link: '/template',
        describe: "恢复已删除的页面",
        icon: Broom16Regular
    },
    {
        id: 6,
        name: "帮助",
        link: '/template',
        describe: "帮助联系和更多",
        icon: BookInformation24Regular
    }
])
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
</style>
