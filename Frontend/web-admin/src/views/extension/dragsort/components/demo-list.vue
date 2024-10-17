<template>
  <el-row :gutter="16">
    <el-col :md="8" :sm="24" :xs="24">
      <ele-card header="列表拖拽排序">
        <vue-draggable
          v-model="list"
          item-key="id"
          :animation="300"
          :set-data="() => void 0"
          class="demo-list"
        >
          <template #item="{ element }">
            <div class="demo-list-item">{{ element.name }}</div>
          </template>
        </vue-draggable>
      </ele-card>
    </el-col>
    <el-col :md="16" :sm="24" :xs="24">
      <ele-card header="列表相互拖拽">
        <div style="display: flex; align-items: flex-start">
          <vue-draggable
            v-model="list1"
            item-key="id"
            :animation="300"
            group="demoDragList"
            :set-data="() => void 0"
            class="demo-list"
          >
            <template #item="{ element }">
              <div class="demo-list-item">{{ element.name }}</div>
            </template>
          </vue-draggable>
          <vue-draggable
            v-model="list2"
            item-key="id"
            :animation="300"
            group="demoDragList"
            :set-data="() => void 0"
            class="demo-list"
            style="margin-left: 12px"
          >
            <template #item="{ element }">
              <div class="demo-list-item">{{ element.name }}</div>
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

  // 列表数据
  const list = ref([
    { id: 1, name: '项目0000001' },
    { id: 2, name: '项目0000002' },
    { id: 3, name: '项目0000003' },
    { id: 4, name: '项目0000004' },
    { id: 5, name: '项目0000005' }
  ]);

  // 列表1数据
  const list1 = ref([
    { id: 1, name: '项目0000001' },
    { id: 2, name: '项目0000002' },
    { id: 3, name: '项目0000003' },
    { id: 4, name: '项目0000004' },
    { id: 5, name: '项目0000005' }
  ]);

  // 列表2数据
  const list2 = ref([
    { id: 6, name: '项目0000006' },
    { id: 7, name: '项目0000007' },
    { id: 8, name: '项目0000008' },
    { id: 9, name: '项目0000009' },
    { id: 10, name: '项目0000010' }
  ]);
</script>

<style lang="scss" scoped>
  .demo-list {
    width: 230px;
    margin: 0 auto;
    max-width: 100%;
    min-height: 94px;
    border-radius: 4px;
    border: 1px solid hsla(0, 0%, 60%, 0.2);
    box-sizing: border-box;
    padding: 8px 8px 0 8px;
  }

  .demo-list-item {
    color: #fff;
    background: #1677ff;
    border-radius: 4px;
    padding: 8px 12px;
    margin-bottom: 8px;
    cursor: move;

    &.sortable-ghost {
      opacity: 0;
    }
  }
</style>
