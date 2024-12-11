<template>
  <ele-page :multi-card="false">
    <top-search />
    <el-row :gutter="16">
      <el-col v-for="(item,index) in data" :key="item.id" :lg="8" :md="12" :sm="12" :xs="24">
        <ele-card :body-style="{ padding: 0 }" style="margin-top: 16px">
          <div style="padding: 24px">
            <div style="display: flex; align-items: center">
              <el-avatar :size="40" :src="item.cover" style="flex-shrink: 0;background-color: transparent;" />
              <ele-text size="md" style="flex: 1; padding-left: 12px">
                {{ item.title }}
              </ele-text>
              <el-tag v-if="index == 0" type="success" size="small" style="margin-right: 1rem;">使用中</el-tag>
              <ele-dot text="正常" type="primary" ripple="false" size="8px" />
            </div>

            <ele-ellipsis style="margin-top: 16px">
              <el-text size="small">数据库账号: {{ item.account }}</el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text size="small" style="display: flex;align-items: center;">
                数据库密码: ****** <ele-text :icon="View" type="placeholder" class="list-item-tool"
                  style="margin-right: 2px;" />
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text size="small">IP(公): {{ item.PublicIP }}</el-text>
            </ele-ellipsis>
            <ele-ellipsis style="margin-top: 16px">
              <el-text size="small" style="display: flex;align-items: center;">
                <ele-text :icon="UploadFilled" type="placeholder" class="list-item-tool"
                  style="margin-right: 2px;" />增量备份: {{ item.time }}
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text size="small" style="display: flex;align-items: center;">
                <ele-text :icon="Timer" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />计划任务（增量）:
                每小时的第0分钟执行一次
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text size="small" style="display: flex;align-items: center;">
                <ele-text :icon="Coin" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />全量备份数量:
                1/3
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text size="small" style="display: flex;align-items: center;">
                <ele-text :icon="Timer" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />计划任务（全量）:
                每天的00:00执行一次
              </el-text>
            </ele-ellipsis>
          </div>
          <el-divider style="margin: 0; opacity: 0.6" />
          <div class="list-item-footer">
            <ele-tooltip placement="top" content="编辑" :offset="-8">
              <ele-text :icon="EditPen" type="placeholder" class="list-item-tool" />
            </ele-tooltip>
            <el-divider direction="vertical" style="margin: 0" />
            <ele-dropdown :items="[
              { title: '1st menu item', command: '1st' },
              { title: '2nd menu item', command: '2nd' },
              { title: '3rd menu item', command: '3rd' }
            ]" class="list-item-tool" style="padding: 0" :popper-options="{
              modifiers: [{ name: 'offset', options: { offset: [0, -4] } }]
            }">
              <ele-text :icon="MoreFilled" type="placeholder" class="list-item-tool-trigger" />
            </ele-dropdown>
          </div>
        </ele-card>
      </el-col>
    </el-row>
    <ele-pagination :total="count" v-model:page-size="limit" v-model:current-page="page" layout="prev, pager, next"
      style="margin-top: 18px; justify-content: center" />
  </ele-page>
</template>

<script setup>
import { ref } from 'vue';
import Nanning from '@/assets/images/Nanning.png'
import Guangzhou from '@/assets/images/Guangzhou.png'
import {
  Download,
  EditPen,
  Share,
  MoreFilled,
  Timer,
  Coin,
  UploadFilled,
  View
} from '@element-plus/icons-vue';
import TopSearch from '../project/components/top-search.vue';

// 数据
const data = ref([]);

// 第几页
const page = ref(1);

// 每页多少条
const limit = ref(8);

// 总数量
const count = ref(0);

/* 查询数据 */
const query = () => {
  count.value = 40;
  data.value = [
    {
      id: 1,
      title: '广东 · 广州',
      account: "nexnote",
      PublicIP: '43.136.33.54',
      time: '2 小时前',
      cover: Guangzhou
    },
    {
      id: 2,
      title: '广西 · 南宁',
      account: "nexnote",
      PublicIP: '43.136.33.54',
      time: '4 小时前',
      cover: Nanning
    }
  ];
};

query();
</script>

<script>
export default {
  name: 'ListCardApplication'
};
</script>

<style lang="scss" scoped>
.list-item-footer {
  display: flex;
  align-items: center;

  .list-item-tool {
    flex: 1;
    display: flex;
    justify-content: center;
    transition: color 0.2s;
    box-sizing: border-box;
    font-size: 16px;
    padding: 16px 0;
    cursor: pointer;

    .list-item-tool-trigger {
      width: 100%;
      padding: 16px 0;
      box-sizing: border-box;
      display: flex;
      justify-content: center;
      outline: none;
    }

    &:hover {
      color: var(--el-color-primary);

      .list-item-tool-trigger {
        color: var(--el-color-primary);
      }
    }
  }
}
</style>
