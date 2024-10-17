<template>
  <ele-card header="分组菜单">
    <div style="display: flex; flex-wrap: wrap">
      <el-button type="primary" @click="toGroup1" style="margin: 0 12px 12px 0">
        一级菜单变为分组形式
      </el-button>
      <el-button type="primary" @click="toGroup2" style="margin: 0 12px 12px 0">
        二级菜单变为分组形式
      </el-button>
    </div>
    <ele-text type="placeholder">
      <span>二级菜单可查看列表页面/卡片列表的效果, </span>
      <el-link type="primary" :underline="false" @click="resetMenu">
        重置菜单数据
      </el-link>
    </ele-text>
  </ele-card>
</template>

<script setup>
  import { storeToRefs } from 'pinia';
  import { useUserStore } from '@/store/modules/user';

  const userStore = useUserStore();
  const { menus } = storeToRefs(userStore);
  const tempMenus = JSON.parse(JSON.stringify(menus.value));

  /* 一级菜单变为分组形式 */
  const toGroup1 = () => {
    userStore.setMenus(
      tempMenus.map((m) => {
        const hasChild = !!m.children?.length;
        const meta = m.meta || {};
        return {
          ...m,
          meta: {
            ...meta,
            icon: hasChild ? null : meta.icon,
            props: {
              ...meta.props,
              group: hasChild
            }
          }
        };
      })
    );
  };

  /* 二级菜单变为分组形式 */
  const toGroup2 = () => {
    userStore.setMenus(
      tempMenus.map((m) => {
        return {
          ...m,
          children: m.children
            ? m.children.map((c) => {
                const hasChild = c.children
                  ? !!c.children.filter((t) => !t.meta?.hide).length
                  : false;
                const meta = c.meta || {};
                return {
                  ...c,
                  meta: {
                    ...meta,
                    icon: hasChild ? null : meta.icon,
                    props: {
                      ...meta.props,
                      group: hasChild
                    }
                  }
                };
              })
            : void 0
        };
      })
    );
  };

  /* 重置 */
  const resetMenu = () => {
    userStore.setMenus(JSON.parse(JSON.stringify(tempMenus)));
  };
</script>
