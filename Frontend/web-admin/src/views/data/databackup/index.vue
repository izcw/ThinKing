<template>
  <ele-page :multi-card="false">
    <el-row :gutter="16">
      <el-col v-for="(item, index) in data" :key="item.id" :lg="24" :md="24" :sm="24" :xs="24">
        <ele-card :body-style="{ padding: 0 }" style="margin-top: 16px">
          <div style="padding: 24px">
            <div style="display: flex; align-items: center">
              <el-avatar :size="40" :src="item.cover" style="flex-shrink: 0;background-color: transparent;" />
              <ele-text size="md" style="flex: 1; padding-left: 12px">
                {{ item.title }}
              </ele-text>
              <!-- <ele-dot text="正常" type="primary" :ripple="false" size="8px" /> -->
            </div>
            <!-- <ele-ellipsis style="margin-top: 16px">
              <el-text type="info">备份到：</el-text> <el-text>{{ item.whereto }}</el-text>
            </ele-ellipsis> -->
            <!-- <ele-ellipsis style="margin-top: 16px">
              <el-text type="info">IP：</el-text> <el-text>{{ item.PublicIP }}</el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text type="info">数据库账号：</el-text> <el-text>{{ item.account }}</el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text style="display: flex;align-items: center;">
                <el-text type="info">数据库密码：</el-text> <el-text>******</el-text><ele-text
                  :icon="View" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />
              </el-text>
            </ele-ellipsis> -->

            <ele-ellipsis style="margin-top: 16px">
              <el-text style="display: flex;align-items: center;">
                <ele-text :icon="UploadFilled" type="placeholder" class="list-item-tool"
                  style="margin-right: 2px;" /><el-text type="info">增量备份：</el-text>
                <el-text>
                  {{ detailsData?.incremental[0]?.backupTime ? timeAgo(detailsData?.incremental[0]?.backupTime) : "暂无备份"}}</el-text>
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text style="display: flex;align-items: center;">
                <ele-text :icon="Timer" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />
                <el-text type="info">计划周期（增量）：</el-text> <el-text>每小时的第0分钟执行一次</el-text>
              </el-text>
            </ele-ellipsis>

            <ele-ellipsis style="margin-top: 16px">
              <el-text style="display: flex;align-items: center;">
                <ele-text :icon="Coin" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />
                <el-text type="info">全量备份数量：</el-text> <el-text>{{ detailsData?.full.length }}/3</el-text>
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis>
              <el-text style="display: flex;align-items: center;">
                <ele-text :icon="Timer" type="placeholder" class="list-item-tool" style="margin-right: 2px;" />
                <el-text type="info">计划周期（全量）：</el-text> <el-text>每天的00:00执行一次</el-text>
              </el-text>
            </ele-ellipsis>
            <ele-ellipsis style="margin-top: 16px">
              <el-button-group>
                <el-button type="success" plain @click="IncrementalFun">
                  <el-icon><Plus /></el-icon>执行（增量备份）
                </el-button>
                <el-button type="success" plain @click="FullFun">
                  <el-icon><CirclePlusFilled /></el-icon>执行（全量备份）
                </el-button>
              </el-button-group>
            </ele-ellipsis>
            <ele-ellipsis style="margin-top: 16px">
              <el-button type="primary" plain text bg @click="ExportCompressedFile"><el-icon><Download /></el-icon>导出备份压缩包</el-button>
              <el-button type="warning" plain text bg @click="ImportDataFun"><el-icon><Upload /></el-icon>导入</el-button>
            </ele-ellipsis>
            <ele-ellipsis style="margin-top: 16px">
              <el-alert title="导入数据时，请删除sql文件第一行：" type="info"
                description="mysqldump: [Warning] Using a password on the command line interface can be insecure."
                show-icon />
            </ele-ellipsis>
          </div>
          <el-divider style="margin: 0; opacity: 0.6" />
          <div class="list-item-footer">
            <!-- <ele-tooltip placement="top" content="编辑" :offset="-8">
              <ele-text :icon="EditPen" type="placeholder" class="list-item-tool" />
            </ele-tooltip> -->
            <ele-tooltip placement="top" content="日志" :offset="-8">
              <ele-text :icon="Warning" @click="showlog" type="placeholder" class="list-item-tool" />
            </ele-tooltip>
            <el-divider direction="vertical" style="margin: 0" />
            <!-- <ele-dropdown :items="[
              { title: '编辑', command: '2nd' }
            ]" class="list-item-tool" style="padding: 0" :popper-options="{
              modifiers: [{ name: 'offset', options: { offset: [0, -4] } }]
            }">
              <ele-text :icon="MoreFilled" type="placeholder" class="list-item-tool-trigger" />
            </ele-dropdown> -->
          </div>
        </ele-card>
      </el-col>
    </el-row>


  </ele-page>


  <!-- 日志 -->
  <el-dialog v-model="centerDialogVisible" title="日志" width="1400" align-center>
    <el-scrollbar height="700px"
      style="background-color: #333333;color:#fff;line-height: 28px; padding: 1rem;box-sizing: border-box;">
      <p v-if="logdata">暂无日志</p>
      <div v-else>
        <p v-for="item in logdata">{{ item }}</p>
      </div>
    </el-scrollbar>
  </el-dialog>

    <!-- 导入 -->
    <el-dialog v-model="centerimport" title="导入" width="500" align-center>
      <el-input v-model="input" style="width: 240px" placeholder="Please input" />
  </el-dialog>
</template>


<script setup>
import { ref } from 'vue';
import { timeAgo } from '@/utils/timeAgo'
import { EleMessage } from 'ele-admin-plus/es';
import Nanning from '@/assets/images/Nanning.png'
import Guangzhou from '@/assets/images/Guangzhou.png'
import dataImg from '@/assets/images/data.png'
import {
  Download,
  EditPen,
  Share,
  MoreFilled,
  Timer,
  Coin,
  UploadFilled,
  View,
  Warning,
  Upload,
  Plus,
  CirclePlusFilled
} from '@element-plus/icons-vue';
import TopSearch from '../project/components/top-search.vue';
import { getBackupdetails, getBackuplogs, PostIncremental, PostFull ,PostDownloadAll} from '@/api/data/Backup/index.js';

// 获取当前备份信息
let detailsData = ref()
let showbackupInfo = () => {
  getBackupdetails()
    .then((data) => {
      console.log("获取当前备份信息");
      console.log(data);
      detailsData.value = data;
    })
    .catch((e) => {
      console.log("错误" + e);

    });
}
showbackupInfo()


// 查看日志
let logdata = ref()
let showlog = () => {
  centerDialogVisible.value = true
  getBackuplogs()
    .then((data) => {
      logdata.value = data;
    })
    .catch((e) => {
      console.log("错误" + e);

    });
}

// 增量备份
let IncrementalFun = () => {
  PostIncremental()
    .then((msg) => {
      EleMessage.success(msg);
      showbackupInfo()
    })
    .catch((e) => {
      EleMessage.error(e);
    });
}

// 全备份
let FullFun = () => {
  PostFull()
    .then((msg) => {
      EleMessage.success(msg);
      showbackupInfo()
    })
    .catch((e) => {
      EleMessage.error(e);
    });
}

// 导出压缩包
let ExportCompressedFile = ()=>{
  PostDownloadAll()
    .then((msg) => {
      EleMessage.success(msg);
    })
    .catch((e) => {
      EleMessage.error(e);
    });
}

// 导入数据
let centerimport = ref(false)
let ImportDataFun = ()=>{
  centerimport.value = true
}

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
      title: '备份数据',
      account: "nexnote",
      PublicIP: '43.136.33.54',
      time: '2 小时前',
      cover: dataImg,
      whereto: "/dsf/dsf"
    },
    // {
    //   id: 2,
    //   title: '广西 · 南宁',
    //   account: "nexnote_backup",
    //   PublicIP: '43.136.33.54',
    //   time: '4 小时前',
    //   cover: Nanning
    // }
  ];
};

query();


// 日志弹窗
let centerDialogVisible = ref(false)
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
