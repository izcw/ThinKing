<template>
  <div style="width: 100%;">
    <ele-table-select ref="selectRef" clearable placeholder="请选择发布人" value-key="email" label-key="email"
      v-model="selectedValue" :table-props="tableProps" :init-value="initValue" :popper-width="580">
      <Account-Search @search="onSearch" />
    </ele-table-select>
  </div>
</template>

<script setup>
import { ref, reactive, watch, defineProps, watchEffect, computed, onMounted } from 'vue';
import AccountSearch from './account-search.vue';
import { pageUsers as SysPageUsers } from '@/api/system/user';
import { PageUsers as NotePageUsers } from '@/api/note/user';
import { useUserStore } from '@/store/modules/user';
const userStore = useUserStore();



// 表格下拉选中值
const selectedValue = ref();
const emit = defineEmits(['selectuser']);
// 监听选择用户，传递给父组件
watch(selectedValue, () => {
  emit('selectuser', selectedValue.value);
});

// 系统用户或用户
let switchRole = ref('admin')

// 选择框实例
const selectRef = ref(null);

// 表格配置
const tableProps = reactive({
  datasource: ({ page, limit, where, orders }) => {
    if (switchRole.value == 'admin') {
      return SysPageUsers({ ...where, ...orders, page, limit });
    } else if (switchRole.value == 'user') {
      return NotePageUsers({ ...where, ...orders, page, limit });
    }
  },
  columns: [
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true,
      fixed: 'left'
    },
    {
      prop: 'nickname',
      label: '昵称',
      sortable: 'custom',
      showOverflowTooltip: true,
      slot: 'nickname'
    },
    {
      prop: 'email',
      label: '邮箱',
      sortable: 'custom',
      showOverflowTooltip: true
    }
  ],
  toolbar: false,
  pagination: {
    pageSize: 6,
    layout: 'total, prev, pager, next, jumper'
  },
  footerStyle: { padding: '0px' },
  rowClickChecked: true
});

// 回显值
const initValue = ref();

/* 回显数据 */
const setInitValue = () => {
  // 当前登录用户信息
  let loginUser = computed(() => userStore.info ?? {});
  initValue.value =
  {
    email: loginUser.value.email,
    nickname: loginUser.value.nickname
  };
};

onMounted(()=>{
  // setInitValue()
})

// 父组件的切换值
const props = defineProps({
  switchRole: String
});

// 监听 父组件切换 的变化
watchEffect(() => {
  switchRole.value = props.switchRole
  selectRef.value?.tableRef?.reload({ page: 1, limit: 6 });
});

/* 搜索 */
const onSearch = (where) => {
  selectRef.value?.tableRef?.reload({ where, page: 1, limit: 6 });
};
</script>
