<template>
  <ele-page>
    <ele-card header="垂直菜单">
      <div style="display: flex; flex-wrap: wrap">
        <option-item label="暗色主题" style="margin: 0 12px 12px 0">
          <el-switch v-model="dark" size="small" />
        </option-item>
        <option-item label="彩色图标" style="margin: 0 12px 12px 0">
          <el-switch v-model="colorful" size="small" />
        </option-item>
        <option-item label="折叠菜单" style="margin: 0 12px 12px 0">
          <el-switch v-model="collapse" size="small" />
        </option-item>
      </div>
      <div style="display: flex; flex-wrap: wrap">
        <div style="margin: 0 12px 12px 0">
          <el-button type="primary" @click="changeData">
            一级菜单分组形式
          </el-button>
        </div>
        <div style="margin: 0 12px 12px 0">
          <el-button type="primary" @click="changeColor">
            更改菜单背景颜色
          </el-button>
        </div>
      </div>
      <div style="max-width: 240px">
        <ele-menus
          mode="vertical"
          :items="menuItems"
          :collapse="collapse"
          :collapse-transition="true"
          :default-active="menuActive"
          :theme="dark ? 'dark' : 'light'"
          :colorful="colorful"
        />
      </div>
    </ele-card>
    <ele-card header="水平菜单">
      <div style="max-width: 800px">
        <ele-menus
          mode="horizontal"
          :items="navItems"
          :default-active="navActive"
          :theme="dark ? 'dark' : 'light'"
          :colorful="colorful"
        />
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, shallowRef } from 'vue';
  import {
    Setting,
    Calendar,
    Goods,
    Link,
    User
  } from '@element-plus/icons-vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 是否暗色主题
  const dark = ref(false);

  // 是否彩色图标
  const colorful = ref(false);

  // 垂直菜单是否折叠
  const collapse = ref(false);

  // 垂直菜单选中
  const menuActive = ref('1-1');

  // 水平菜单选中
  const navActive = ref('1-1');

  // 垂直菜单数据
  const menuItems = shallowRef([]);

  // 水平菜单数据
  const navItems = shallowRef([]);

  /* 获取菜单数据 */
  const getMenuData = () => {
    return [
      {
        index: '1',
        title: '系统管理',
        icon: Setting,
        children: [
          {
            index: '1-1',
            title: '用户管理'
          },
          {
            index: '1-2',
            title: '角色管理',
            badge: { value: 1 }
          },
          {
            index: '1-3',
            title: '权限管理'
          }
        ]
      },
      {
        index: '2',
        title: '日志管理',
        icon: Calendar,
        iconStyle: { transform: 'scale(0.88)' },
        badge: { value: 'New', type: 'warning' },
        children: [
          {
            index: '2-1',
            title: '登录日志',
            icon: Link
          },
          {
            index: '2-2',
            title: '操作日志',
            icon: Link,
            badge: { isDot: true, type: 'success' }
          }
        ]
      },
      {
        index: '3',
        title: '订单管理',
        icon: Goods,
        iconStyle: { transform: 'scale(0.92)' },
        children: [
          {
            index: '3-1',
            title: '订单查询',
            icon: Link
          },
          {
            index: '3-2',
            title: '退款记录',
            icon: Link
          },
          {
            index: '3-3',
            title: '订单报表',
            icon: Link,
            children: [
              {
                index: '3-3-1',
                title: '日报表',
                icon: Link
              },
              {
                index: '3-3-2',
                title: '周报表',
                icon: Link,
                disabled: true
              },
              {
                index: '3-3-3',
                title: '月报表',
                icon: Link
              }
            ]
          },
          {
            index: '3-4',
            title: '账单统计',
            group: true,
            children: [
              {
                index: '3-4-1',
                title: '销售统计',
                icon: Link
              },
              {
                index: '3-4-2',
                title: '退款统计',
                icon: Link
              }
            ]
          }
        ]
      },
      {
        index: '4',
        title: '个人中心',
        icon: User,
        badge: { value: 100 }
      }
    ];
  };

  /* 一级菜单改为分组形式 */
  const changeData = () => {
    menuItems.value = getMenuData().map((d) => {
      const t = { ...d };
      if (t.children) {
        t.group = true;
        t.icon = void 0;
        if (t.title) {
          t.title = t.title.replace('管理', '');
        }
        t.children = t.children.map((c) => {
          return { ...c, group: false, icon: c.icon ?? Link };
        });
      }
      return t;
    });
  };

  /* 自定义图标背景颜色 */
  const changeColor = () => {
    const colors = {
      1: 'linear-gradient(-225deg, #231557 0%, #44107A 29%, #FF1361 67%, #FFF800 100%)',
      2: 'linear-gradient( 135deg, #FFF3B0 10%, #CA26FF 100%)',
      3: 'linear-gradient(-225deg, #69EACB 0%, #EACCF8 48%, #6654F1 100%)',
      4: '#faad14',
      '1-1': '#f5222d',
      '1-2': '#fa541c',
      '1-3': '#fa8c16',
      '2-1': '#2f54eb',
      '2-2': '#722ed1',
      '3-1': '#eb2f96',
      '3-2':
        'linear-gradient(135deg, rgb(67, 203, 255) 10%, rgb(151, 8, 204) 100%)',
      '3-3':
        'linear-gradient(135deg, rgb(160, 254, 101) 10%, rgb(250, 1, 109) 100%)',
      '3-4': 'linear-gradient(to right, #f83600 0%, #f9d423 100%)'
    };
    menuItems.value = menuItems.value.map((d) => {
      const t = { ...d };
      if (!t.group) {
        if (t.index && colors[t.index]) {
          if (colors[t.index].startsWith('linear-gradient(')) {
            t.iconProps = { style: { backgroundImage: colors[t.index] } };
          } else {
            t.iconProps = { style: { backgroundColor: colors[t.index] } };
          }
        }
      } else if (t.children) {
        t.children = t.children.map((c) => {
          const m = { ...c };
          if (m.index && colors[m.index]) {
            if (colors[m.index].startsWith('linear-gradient(')) {
              m.iconProps = { style: { backgroundImage: colors[m.index] } };
            } else {
              m.iconProps = { style: { backgroundColor: colors[m.index] } };
            }
          }
          return m;
        });
      }
      return t;
    });
  };

  //
  menuItems.value = getMenuData();
  navItems.value = getMenuData();
</script>

<script>
  export default {
    name: 'ExtensionMenu'
  };
</script>
