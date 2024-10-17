<!-- 文件展示列表 -->
<template>
  <div class="demo-file-list">
    <ele-file-list
      :data="data"
      :grid="grid"
      :sort="sort"
      :order="order"
      :sortable="true"
      :box-choose="true"
      selection-type="checkbox"
      :selections="selections"
      :context-menus="contextMenus"
      :context-menu-props="{ menuStyle: { minWidth: '108px' } }"
      :icons="localIcons"
      :small-icons="localSmallIcons"
      :style="{ minHeight: '400px', minWidth: grid ? 'auto' : '456px' }"
      @item-click="onItemClick"
      @sort-change="onSortChange"
      @update:selections="updateSelections"
      @item-context-menu="onCtxMenuClick"
    />
    <div v-if="!data.length" class="demo-file-list-empty">
      <el-empty description="无数据" :image-size="80" />
    </div>
  </div>
  <!-- 用于图片预览 -->
  <div style="display: none">
    <el-image
      ref="previewRef"
      v-if="previewOption.visible"
      :src="previewOption.currentSrc"
      :preview-src-list="previewImages"
      :initial-index="previewOption.current"
      :hide-on-click-modal="true"
      :preview-teleported="true"
    />
  </div>
  <!-- 文件重命名弹窗 -->
  <name-edit v-model="nameEditVisible" :data="nameEditData" @done="onDone" />
</template>

<script setup>
  import { ref, reactive, nextTick } from 'vue';
  import { ElMessageBox } from 'element-plus';
  import { Download, EditPen, Rank, Delete } from '@element-plus/icons-vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import {
    localIcons,
    localSmallIcons
  } from 'ele-admin-plus/es/ele-file-list/icons';
  import { removeUserFile } from '@/api/system/user-file';
  import NameEdit from './name-edit.vue';

  const props = defineProps({
    // 父级id
    parentId: Number,
    // 文件列表数据
    data: Array,
    // 排序字段
    sort: String,
    // 排序方式
    order: String,
    // 选中数据
    selections: Array,
    // 是否网格展示
    grid: Boolean
  });

  const emit = defineEmits([
    'sort-change',
    'update:selections',
    'go-directory',
    'done'
  ]);

  //
  const previewRef = ref(null);

  // 图片预览配置
  const previewOption = reactive({
    currentSrc: '',
    current: 0,
    visible: false
  });

  // 图片预览列表
  const previewImages = ref([]);

  // 文件重命名弹窗是否打开
  const nameEditVisible = ref(false);

  // 文件重命名的数据
  const nameEditData = ref();

  /* 文件列表排序方式改变 */
  const onSortChange = (option) => {
    emit('sort-change', option);
  };

  /* 更新选中数据 */
  const updateSelections = (value) => {
    emit('update:selections', value);
  };

  /* item 点击事件 */
  const onItemClick = (item) => {
    if (item.isDirectory) {
      // 进入文件夹
      emit('go-directory', item);
    } else if (isImageFile(item)) {
      // 预览图片文件
      previewItemImage(item);
    } else {
      // 选中或取消选中文件
      updateSelections(
        props.selections.includes(item)
          ? props.selections.filter((d) => d !== item)
          : [...props.selections, item]
      );
    }
  };

  /* 右键菜单点击事件 */
  const onCtxMenuClick = (option) => {
    const { key, item } = option;
    if (key === 'open') {
      // 打开文件
      if (item.isDirectory || isImageFile(item)) {
        onItemClick(item);
      } else {
        window.open(item.url);
      }
    } else if (key === 'download') {
      // 下载文件
      if (typeof item.downloadUrl === 'string') {
        window.open(item.downloadUrl);
      }
    } else if (key === 'edit') {
      // 重命名
      nameEditData.value = item;
      nameEditVisible.value = true;
    } else if (key === 'remove') {
      // 删除文件
      removeItem(item);
    }
  };

  /* 删除 */
  const removeItem = (item) => {
    ElMessageBox.confirm('确定要删除选中的文件吗?', '提示', {
      type: 'warning',
      draggable: true
    })
      .then(() => {
        const loading = EleMessage.loading('请求中..');
        removeUserFile(item.id)
          .then((msg) => {
            loading.close();
            EleMessage.success(msg);
            onDone();
          })
          .catch((e) => {
            loading.close();
            EleMessage.error(e.message);
          });
      })
      .catch(() => {});
  };

  /* 完成刷新列表数据 */
  const onDone = () => {
    emit('done');
  };

  /* 判断是否是图片文件 */
  const isImageFile = (item) => {
    return (
      typeof item.contentType === 'string' &&
      item.contentType.startsWith('image/') &&
      item.url
    );
  };

  /* 预览图片文件 */
  const previewItemImage = (item) => {
    const temp = props.data.filter((d) => isImageFile(d));
    const index = temp.indexOf(item);
    if (index !== -1) {
      previewImages.value = temp.map((d) => d.url);
      previewOption.currentSrc = item.url;
      previewOption.current = index;
      previewOption.visible = true;
      nextTick(() => {
        previewRef.value?.$el?.querySelector('img')?.click();
      });
    }
  };

  /* 右键菜单 */
  const contextMenus = (item) => {
    if (!item) {
      return [];
    }
    const menus = [
      {
        title: '重命名',
        command: 'edit',
        icon: EditPen,
        divided: item.isDirectory
      },
      {
        title: '移动到',
        command: 'move',
        icon: Rank
      },
      {
        title: '删除',
        command: 'remove',
        icon: Delete,
        divided: true,
        danger: true
      }
    ];
    if (!item.isDirectory) {
      menus.unshift({
        title: '下载',
        command: 'download',
        icon: Download,
        divided: true
      });
    }
    menus.unshift({ title: '打开', command: 'open' });
    return menus;
  };
</script>

<style lang="scss" scoped>
  .demo-file-list {
    position: relative;
    overflow-x: auto;

    .demo-file-list-empty {
      position: absolute;
      top: 100px;
      left: 50%;
      transform: translateX(-50%);
    }
  }
</style>
