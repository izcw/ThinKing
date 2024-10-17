<template>
  <ele-card header="基础用法">
    <div style="max-width: 260px">
      <ele-icon-select
        clearable
        filterable
        :data="icons"
        v-model="selectedIcon"
        placeholder="请选择"
      >
        <template #icon="{ icon }">
          <el-icon>
            <component :is="icon" />
          </el-icon>
        </template>
      </ele-icon-select>
    </div>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';

  // 选中值
  const selectedIcon = ref('');

  // 图标数据
  const icons = ref([
    {
      title: '线框风格',
      children: [
        {
          title: 'System',
          icons: [
            'CircleCheck',
            'CircleClose',
            'Warning',
            'User',
            'More',
            'Setting',
            'House',
            'Star',
            'ChatDotSquare',
            'Delete',
            'Remove',
            'CirclePlus'
          ]
        },
        {
          title: 'Arrow',
          icons: ['ArrowLeft', 'ArrowUp', 'ArrowRight', 'ArrowDown']
        },
        {
          title: 'Media',
          icons: ['Monitor', 'Camera', 'Picture']
        },
        {
          title: 'Traffic',
          icons: ['Location']
        }
      ]
    },
    {
      title: '实底风格',
      children: [
        {
          title: 'System',
          icons: [
            'CircleCheckFilled',
            'CircleCloseFilled',
            'WarningFilled',
            'UserFilled',
            'MoreFilled',
            'Tools',
            'HomeFilled',
            'StarFilled',
            'Comment',
            'DeleteFilled',
            'RemoveFilled',
            'CirclePlusFilled'
          ]
        },
        {
          title: 'Arrow',
          icons: ['CaretLeft', 'CaretTop', 'CaretRight', 'CaretBottom']
        },
        {
          title: 'Media',
          icons: ['Platform', 'CameraFilled', 'PictureFilled']
        },
        {
          title: 'Traffic',
          icons: ['LocationFilled']
        }
      ]
    }
  ]);
</script>

<script>
  import * as BasicIcons from './basic-icons';

  export default {
    components: BasicIcons
  };
</script>
