/**
 * 登录用户状态管理
 */
import { defineStore } from 'pinia';
import { toTree, mapTree, isExternalLink } from 'ele-admin-plus/es';
import { getUserInfo } from '@/api/layout';
// 直接指定菜单数据
const USER_MENUS = null;

export const useUserStore = defineStore({
  id: 'user',
  state: () => ({
    // 当前登录用户的信息
    info: null,
    // 当前登录用户的菜单
    menus: null,
    // 当前登录用户的权限
    authorities: [],
    // 当前登录用户的角色
    roles: []
  }),
  actions: {
    /**
     * 请求登录用户的个人信息/权限/角色/菜单
     */
    async fetchUserInfo() {
      const result = await getUserInfo().catch(() => void 0);
      if (!result) {
        return {};
      }
      // 用户信息
      this.setInfo(result);
      // 用户权限
      this.authorities =
        result.authorities?.map((d) => d.authority)?.filter((a) => !!a) ?? [];
      // 用户角色
      this.roles = result.roles?.map((d) => d.roleCode) ?? [];
      // 用户菜单, 过滤掉按钮类型并转为children形式
      const { menus, homePath } = formatMenus(
        USER_MENUS ??
          toTree({
            data: result.authorities?.filter((d) => d.menuType !== 1),
            idField: 'menuId',
            parentIdField: 'parentId'
          })
      );
      this.setMenus(menus);
      return { menus, homePath };
    },
    /**
     * 更新用户信息
     */
    setInfo(value) {
      this.info = value;
    },
    /**
     * 更新菜单数据
     */
    setMenus(menus) {
      this.menus = menus;
    },
    /**
     * 更新菜单的徽章
     * @param path 菜单地址
     * @param value 徽章值
     * @param type 徽章类型
     */
    setMenuBadge(path, value, type) {
      this.menus = mapTree(this.menus, (m) => {
        if (path === m.path) {
          const meta = m.meta || {};
          return {
            ...m,
            meta: {
              ...meta,
              props: {
                ...meta.props,
                badge: value == null ? void 0 : { value, type }
              }
            }
          };
        }
        return m;
      });
    }
  }
});

/**
 * 菜单数据处理为EleProLayout所需要的格式
 * @param data 菜单数据
 * @param childField 子级的字段名称
 */
export function formatMenus(data, childField = 'children') {
  let homePath;
  let homeTitle;
  const menus = mapTree(
    data,
    (item) => {
      const menu = {
        path: item.path,
        component: item.component,
        meta: {
          title: item.title,
          icon: item.icon,
          hide: !!item.hide,
          ...JSON.parse(item.meta || '{}')
        }
      };
      const children = item[childField]?.filter(
        (d) => !(d.meta?.hide ?? d.hide)
      );
      if (!children?.length) {
        if (!homePath && menu.path && !isExternalLink(menu.path)) {
          homePath = menu.path;
          homeTitle = menu.meta?.title;
        }
      } else {
        const childPath = children[0].path;
        if (childPath) {
          if (!menu.redirect) {
            menu.redirect = childPath;
          }
          if (!menu.path) {
            menu.path = childPath.substring(0, childPath.lastIndexOf('/'));
          }
        }
      }
      if (!menu.path) {
        console.error('菜单path不能为空且要唯一:', item);
        return;
      }
      return menu;
    },
    childField
  );
  return { menus, homePath, homeTitle };
}
