<template>
  <div class="option-item">
    <div
      v-if="label"
      class="option-item-label"
      :style="[{ width: labelWidth }, labelStyle || {}]"
    >
      {{ label }}
    </div>
    <div class="option-item-body">
      <slot></slot>
    </div>
  </div>
</template>

<script setup>
  defineProps({
    label: String,
    labelWidth: String,
    labelStyle: Object
  });
</script>

<style lang="scss" scoped>
  .option-item {
    display: flex;
    align-items: center;

    .option-item-label {
      text-align: right;

      &::after {
        content: ':';
      }

      & + .option-item-body {
        padding-left: 12px;
      }
    }

    .option-item-body {
      flex: 1;
    }

    & + .option-item {
      margin-top: 24px;
    }
  }

  @media screen and (max-width: 768px) {
    .option-item {
      display: block;

      .option-item-label {
        text-align: left;
        margin-bottom: 8px;

        & + .option-item-body {
          padding-left: 0;
        }
      }
    }
  }
</style>
