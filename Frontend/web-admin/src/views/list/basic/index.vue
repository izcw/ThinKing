<template>
  <ele-page hide-footer :flex-table="fixedHeight" style="min-height: 600px">
    <!-- 搜索表单 -->
    <search-form @search="onSearch" />
    <ele-card :flex-table="fixedHeight">
      <!-- 提示信息 -->
      <ele-alert
        show-icon
        :closable="false"
        :style="{ marginBottom: toolDefault ? '12px' : '4px' }"
      >
        <template #title>
          <span>已选择&nbsp;</span>
          <ele-text strong type="primary" tag="span">
            {{ selections.length }}
          </ele-text>
          <span>&nbsp;项数据&emsp;</span>
          <span>其中冻结状态的用户有 </span>
          <b>{{ selections.filter((d) => d.status === 1).length }} 个 &emsp;</b>
          <el-link
            type="primary"
            :underline="false"
            style="vertical-align: 0px"
            @click="clearChoose"
          >
            清空
          </el-link>
        </template>
      </ele-alert>
      <!-- 表格 -->
      <ele-pro-table
        ref="tableRef"
        row-key="userId"
        :border="bordered"
        :stripe="striped"
        row-click-checked
        highlight-current-row
        :toolbar="{ theme: toolDefault ? 'default' : 'plain' }"
        :columns="columns"
        :datasource="datasource"
        v-model:current="current"
        v-model:selections="selections"
        :default-sort="{ prop: 'createTime', order: 'ascending' }"
        @done="onDone"
      >
        <template #toolbar>
          <el-space>
            <el-button
              type="primary"
              :icon="Plus"
              class="ele-btn-icon"
              @click="openEdit()"
            >
              新建
            </el-button>
            <ele-dropdown
              :disabled="!selections.length"
              :items="[
                { title: '批量删除', command: 'del' },
                { title: '批量修改', command: 'edit' }
              ]"
              @command="onDropClick"
            >
              <el-button :disabled="!selections.length" class="ele-btn-icon">
                <span>批量操作</span>
                <el-icon :size="12" style="margin: 0 -4px 0 4px">
                  <arrow-down />
                </el-icon>
              </el-button>
            </ele-dropdown>
          </el-space>
        </template>
        <!-- 表头工具按钮 -->
        <template #tools>
          <el-space size="default" :wrap="true">
            <div>
              <span style="vertical-align: -1px">边框&nbsp;</span>
              <el-switch v-model="bordered" size="small" />
            </div>
            <el-divider direction="vertical" style="margin: 0" />
            <div>
              <span style="vertical-align: -1px">斑马线&nbsp;</span>
              <el-switch v-model="striped" size="small" />
            </div>
            <el-divider direction="vertical" style="margin: 0" />
            <div>
              <span style="vertical-align: -1px">表头背景&nbsp;</span>
              <el-switch v-model="toolDefault" size="small" />
            </div>
            <el-divider direction="vertical" style="margin: 0" />
            <div>
              <span style="vertical-align: -1px">高度铺满&nbsp;</span>
              <el-switch v-model="fixedHeight" size="small" />
            </div>
            <el-divider direction="vertical" style="margin: 0" />
          </el-space>
        </template>
        <!-- 头像列 -->
        <template #avatar="{ row }">
          <el-avatar
            v-if="row.avatar"
            :src="row.avatar"
            :size="32"
            @click.stop=""
            style="vertical-align: -8px"
          />
          <el-avatar
            v-else
            :size="32"
            style="background: #1677ff; vertical-align: -8px"
            @click.stop=""
          >
            {{
              row.nickname && row.nickname.length > 2
                ? row.nickname.substring(row.nickname.length - 2)
                : row.nickname
            }}
          </el-avatar>
        </template>
        <!-- 用户名列 -->
        <template #nickname="{ row }">
          <router-link
            :to="'/list/basic/details/' + row.userId"
            style="text-decoration: none"
            @click.stop=""
          >
            <el-link type="primary" :underline="false">
              {{ row.nickname }}
            </el-link>
          </router-link>
        </template>
        <!-- 状态列 -->
        <template #status="{ row }">
          <ele-dot v-if="row.status === 0" text="正常" size="8px" />
          <ele-dot
            v-else-if="row.status === 1"
            text="冻结"
            type="danger"
            :ripple="false"
            size="8px"
          />
        </template>
        <!-- 角色列 -->
        <template #roles="{ row }">
          <el-tag
            v-for="item in row.roles"
            :key="item.roleId"
            size="small"
            :disable-transitions="true"
          >
            {{ item.roleName }}
          </el-tag>
        </template>
        <!-- 操作列 -->
        <template #action="{ row }">
          <el-space>
            <el-link
              type="primary"
              :underline="false"
              @click.stop="openEdit(row)"
            >
              修改
            </el-link>
            <el-divider direction="vertical" style="margin: 0" />
            <div @click.stop="">
              <ele-popconfirm
                :width="248"
                placement="top-end"
                title="删除此用户"
                content="删除后不可恢复, 确定要删除吗?"
                :popperOptions="{
                  modifiers: [
                    { name: 'arrow', options: { padding: 32 } },
                    { name: 'offset', options: { offset: [32, 6] } }
                  ]
                }"
                @confirm="remove(row)"
              >
                <template #reference>
                  <el-link type="danger" :underline="false">删除</el-link>
                </template>
              </ele-popconfirm>
            </div>
          </el-space>
        </template>
        <!-- 用户名表头 -->
        <template #nicknameHeader="{ column }">
          <ele-text
            :type="nicknameFilterValue ? 'primary' : 'heading'"
            tag="span"
          >
            {{ column.label }}
          </ele-text>
          <nickname-filter @search="onNicknameFilter" />
        </template>
      </ele-pro-table>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, reactive, computed, nextTick } from 'vue';
  import { useRouter } from 'vue-router';
  import { Plus, ArrowDown } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus';
  import { useI18n } from 'vue-i18n';
  import { usePageTab } from '@/utils/use-page-tab';
  import SearchForm from './components/search-form.vue';
  import NicknameFilter from './components/nickname-filter.vue';
  import { pageUsers } from '@/api/system/user';

  const { t } = useI18n();
  const { push } = useRouter();
  const { removePageTab } = usePageTab();

  // 表格实例
  const tableRef = ref(null);

  // 用户名筛选值
  const nicknameFilterValue = ref('');

  // 表格搜索参数
  const lastWhere = reactive({});

  // 表格列配置
  const columns = computed(() => {
    return [
      {
        type: 'selection',
        columnKey: 'selection',
        width: 48,
        align: 'center',
        fixed: 'left'
      },
      {
        type: 'index',
        columnKey: 'index',
        width: 48,
        align: 'center',
        showOverflowTooltip: true,
        fixed: 'left'
      },
      {
        columnKey: 'avatar',
        prop: 'avatar',
        label: t('list.basic.table.avatar'),
        width: 80,
        align: 'center',
        slot: 'avatar',
        showOverflowTooltip: true
      },
      {
        prop: 'username',
        label: t('list.basic.table.username'),
        minWidth: 100,
        sortable: 'custom',
        showOverflowTooltip: true
      },
      {
        prop: 'nickname',
        label: t('list.basic.table.nickname'),
        minWidth: 100,
        sortable: 'custom',
        slot: 'nickname',
        headerSlot: 'nicknameHeader',
        showOverflowTooltip: true
      },
      {
        prop: 'organizationName',
        label: t('list.basic.table.organizationName'),
        minWidth: 100,
        sortable: 'custom',
        showOverflowTooltip: true
      },
      {
        prop: 'phone',
        label: t('list.basic.table.phone'),
        minWidth: 100,
        sortable: 'custom',
        showOverflowTooltip: true
      },
      {
        columnKey: 'roles',
        label: t('list.basic.table.roles'),
        showOverflowTooltip: true,
        slot: 'roles',
        hideInTable: true
      },
      {
        columnKey: 'sexName',
        prop: 'sexName',
        label: t('list.basic.table.sexName'),
        width: 100,
        align: 'center',
        sortable: 'custom',
        filters: [
          {
            text: '男',
            value: '男'
          },
          {
            text: '女',
            value: '女'
          }
        ],
        filterMultiple: false,
        showOverflowTooltip: true
      },
      {
        prop: 'createTime',
        label: t('list.basic.table.createTime'),
        minWidth: 100,
        sortable: 'custom',
        showOverflowTooltip: true
      },
      {
        prop: 'status',
        label: t('list.basic.table.status'),
        width: 90,
        sortable: 'custom',
        align: 'center',
        slot: 'status',
        showOverflowTooltip: true
      },
      {
        columnKey: 'action',
        label: t('list.basic.table.action'),
        width: 110,
        align: 'center',
        resizable: false,
        slot: 'action',
        fixed: 'right'
      }
    ];
  });

  // 表格选中数据
  const selections = ref([]);

  // 表格单选选中数据
  const current = ref(null);

  // 表格是否显示边框
  const bordered = ref(false);

  // 表格是否斑马纹
  const striped = ref(false);

  // 表头工具栏风格
  const toolDefault = ref(false);

  // 表格固定高度
  const fixedHeight = ref(true);

  // 表格数据源
  const datasource = ({ page, limit, where, orders, filters }) => {
    return pageUsers({
      ...where,
      ...orders,
      ...filters,
      page,
      limit
    });
  };

  /* 表格数据请求完成事件 */
  const onDone = () => {
    // 回显 id 为 45、47、48 的数据的复选框
    nextTick(() => {
      const ids = [45, 47, 48];
      tableRef.value?.setSelectedRowKeys(ids);
    });
  };

  /* 搜索事件 */
  const onSearch = (where) => {
    Object.assign(lastWhere, where);
    doReload();
  };

  /* 刷新表格 */
  const reload = (where) => {
    tableRef.value?.reload({ page: 1, where });
  };

  /* 清空选择 */
  const clearChoose = () => {
    tableRef.value?.clearSelection();
  };

  /* 编辑 */
  const openEdit = (row) => {
    const path = row ? '/list/basic/edit' : '/list/basic/add';
    removePageTab({ key: path });
    nextTick(() => {
      push({
        path,
        query: row ? { id: row.userId } : void 0
      });
    });
  };

  /* 删除 */
  const remove = (row) => {
    console.log(row);
    EleMessage.info('点击了删除');
  };

  /* 下拉按钮点击 */
  const onDropClick = (command) => {
    if (command === 'del') {
      EleMessage.info('点击了批量删除');
    } else if (command === 'edit') {
      EleMessage.info('点击了批量修改');
    }
  };

  /* 表格搜索 */
  const doReload = () => {
    if (nicknameFilterValue.value) {
      reload({
        ...lastWhere,
        nickname: nicknameFilterValue.value
      });
    } else {
      reload(lastWhere);
    }
  };

  /* 用户名筛选事件 */
  const onNicknameFilter = (nickname) => {
    nicknameFilterValue.value = nickname;
    doReload();
  };
</script>

<script>
  export default {
    name: 'ListBasic'
  };
</script>
