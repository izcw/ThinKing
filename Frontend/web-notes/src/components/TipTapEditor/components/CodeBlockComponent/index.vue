<template>
    <node-view-wrapper class="code-block">
        <select contenteditable="false" v-model="selectedLanguage">
            <option :value="null">
                auto
            </option>
            <option disabled>
                —
            </option>
            <option v-for="(language, index) in languages" :value="language" :key="index">
                {{ language }}
            </option>
        </select>
        <pre><code><node-view-content /></code></pre>
    </node-view-wrapper>
</template>

<script setup>
import { NodeViewContent, nodeViewProps, NodeViewWrapper } from '@tiptap/vue-3'
import { computed, ref } from 'vue'

const props = defineProps(nodeViewProps)

const languages = ref(props.extension.options.lowlight.listLanguages())

const selectedLanguage = computed({
    get() {
        return props.node.attrs.language
    },
    set(language) {
        props.updateAttributes({ language })
    },
})
</script>

<style lang="scss">
.tiptap {
    .code-block {
        position: relative;

        select {
            position: absolute;
            background-color: #fff;
            right: 0.5rem;
            top: 0.5rem;
            border:none; 
            outline:none;
        }
    }
}
</style>