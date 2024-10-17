<template>
  <el-row :gutter="16">
    <el-col :md="8" :sm="24" :xs="24">
      <ele-card header="宫格拖拽排序">
        <vue-draggable
          v-model="grid"
          item-key="id"
          :animation="300"
          :set-data="() => void 0"
          class="demo-grid"
        >
          <template #item="{ element }">
            <div class="demo-grid-item">{{ element.name }}</div>
          </template>
        </vue-draggable>
      </ele-card>
    </el-col>
    <el-col :md="16" :sm="24" :xs="24">
      <ele-card header="宫格相互拖拽">
        <div style="display: flex; align-items: flex-start">
          <vue-draggable
            v-model="grid1"
            item-key="id"
            :animation="300"
            group="demoDragGrid"
            :set-data="() => void 0"
            class="demo-grid"
          >
            <template #item="{ element }">
              <div class="demo-grid-item">{{ element.name }}</div>
            </template>
          </vue-draggable>
          <vue-draggable
            v-model="grid2"
            item-key="id"
            :animation="300"
            group="demoDragGrid"
            :set-data="() => void 0"
            class="demo-grid"
            style="margin-left: 12px"
          >
            <template #item="{ element }">
              <div class="demo-grid-item">{{ element.name }}</div>
            </template>
          </vue-draggable>
        </div>
      </ele-card>
    </el-col>
  </el-row>
</template>

<script setup>
  import { ref } from 'vue';
  import VueDraggable from 'vuedraggable';

  // 数据
  const grid = ref([
    { id: 1, name: '001' },
    { id: 2, name: '002' },
    { id: 3, name: '003' },
    { id: 4, name: '004' },
    { id: 5, name: '005' },
    { id: 6, name: '006' }
  ]);

  // 数据1
  const grid1 = ref([
    { id: 1, name: '001' },
    { id: 2, name: '002' },
    { id: 3, name: '003' },
    { id: 4, name: '004' },
    { id: 5, name: '005' },
    { id: 6, name: '006' }
  ]);

  // 数据2
  const grid2 = ref([
    { id: 7, name: '007' },
    { id: 8, name: '008' },
    { id: 9, name: '009' },
    { id: 10, name: '010' },
    { id: 11, name: '011' },
    { id: 12, name: '012' }
  ]);
</script>

<style lang="scss" scoped>
  .demo-grid {
    width: 600px;
    margin: 0 auto;
    max-width: 100%;
    min-height: 94px;
    border-radius: 4px;
    border: 1px solid hsla(0, 0%, 60%, 0.2);
    box-sizing: border-box;
    padding: 8px;
    display: grid;
    grid-gap: 8px 8px;
    grid-template-columns: repeat(3, 1fr);
  }

  .demo-grid-item {
    color: #fff;
    background: #1677ff;
    border-radius: 4px;
    text-align: center;
    padding: 28px 0;
    cursor: move;

    &.sortable-ghost {
      opacity: 0;
    }
  }
</style>
