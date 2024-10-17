<template>
    <n-flex>
        <n-tooltip trigger="hover" placement="right">
            <template #trigger>
                <n-float-button position="fixed" bottom="2.5rem" right="2.5rem" menu-trigger="hover">
                    <n-icon>
                        <Crow />
                    </n-icon>
                    <template #menu>
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square">
                                    <n-icon>
                                        <Connectdevelop />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            AI
                        </n-tooltip>
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square">
                                    <n-icon>
                                        <Blackberry />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            插件
                        </n-tooltip>
                        <n-tooltip trigger="hover" placement="right">
                            <template #trigger>
                                <n-float-button shape="square">
                                    <n-icon>
                                        <Magic />
                                    </n-icon>
                                </n-float-button>
                            </template>
                            模板
                        </n-tooltip>
                    </template>
                </n-float-button>
            </template>
            使用AI、模板、插件等
        </n-tooltip>
    </n-flex>

</template>

<script setup>
import { Crow, Connectdevelop, Blackberry, Magic } from '@vicons/fa'
</script>