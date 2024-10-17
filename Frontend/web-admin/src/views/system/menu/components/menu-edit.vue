<!-- 编辑弹窗 -->
<template>
  <ele-modal
    form
    :width="740"
    :model-value="modelValue"
    :title="isUpdate ? '修改菜单' : '新建菜单'"
    @update:modelValue="updateModelValue"
  >
    <el-form ref="formRef" :model="form" :rules="rules" label-width="92px">
      <el-row :gutter="16">
        <el-col :sm="12" :xs="24">
          <el-form-item label="上级菜单" prop="parentId">
            <el-tree-select
              clearable
              :data="menus"
              check-strictly
              default-expand-all
              node-key="menuId"
              :props="{ label: 'title' }"
              placeholder="请选择上级菜单"
              :model-value="form.parentId || void 0"
              class="ele-fluid"
              @update:modelValue="(val) => (form.parentId = val)"
            />
          </el-form-item>
          <el-form-item label="菜单名称" prop="title">
            <el-input
              clearable
              :maxlength="20"
              v-model="form.title"
              placeholder="请输入菜单名称"
            />
          </el-form-item>
        </el-col>
        <el-col :sm="12" :xs="24">
          <el-form-item label="菜单类型" prop="menuType">
            <el-radio-group v-model="form.menuType" @change="onMenuTypeChange">
              <el-radio :label="0">目录</el-radio>
              <el-radio :label="1">菜单</el-radio>
              <el-radio :label="2">按钮</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="打开方式">
            <el-radio-group
              v-model="form.openType"
              :disabled="form.menuType === 0 || form.menuType === 2"
              @change="onOpenTypeChange"
            >
              <el-radio :label="0">组件</el-radio>
              <el-radio :label="1">内链</el-radio>
              <el-radio :label="2">外链</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-col>
      </el-row>
      <el-divider style="margin: 8px 0 22px 0; opacity: 0.6" />
      <el-row :gutter="16">
        <el-col :sm="12" :xs="24">
          <el-form-item label="菜单图标" prop="icon">
            <ele-icon-select
              clearable
              :data="iconData"
              :tooltip="false"
              v-model="form.icon"
              placeholder="请输入菜单图标"
              :disabled="form.menuType === 2"
              :popper-width="420"
              :popper-height="280"
              :grid-style="{ gridTemplateColumns: 'repeat(6, 1fr)' }"
              :item-style="{ height: '52px' }"
            >
              <template #icon="{ icon }">
                <el-icon>
                  <component :is="icon" />
                </el-icon>
              </template>
            </ele-icon-select>
          </el-form-item>
          <el-form-item prop="path">
            <template #label>
              <ele-tooltip
                v-if="form.openType === 2"
                content="需要以`http://`、`https://`、`//`开头"
              >
                <el-icon
                  :size="16"
                  style="align-self: center; margin-right: 4px; cursor: help"
                >
                  <warning style="opacity: 0.6" />
                </el-icon>
              </ele-tooltip>
              <span>{{ form.openType === 2 ? '外链地址' : '路由地址' }}</span>
            </template>
            <el-input
              clearable
              :maxlength="100"
              v-model="form.path"
              :disabled="form.menuType === 2"
              :placeholder="
                form.openType === 2 ? '请输入外链地址' : '请输入路由地址'
              "
            />
          </el-form-item>
          <el-form-item prop="component">
            <template #label>
              <ele-tooltip
                v-if="form.openType === 1"
                content="需要以`http://`、`https://`、`//`开头"
              >
                <el-icon
                  :size="16"
                  style="align-self: center; margin-right: 4px; cursor: help"
                >
                  <warning style="opacity: 0.6" />
                </el-icon>
              </ele-tooltip>
              <span>{{ form.openType === 1 ? '内链地址' : '组件路径' }}</span>
            </template>
            <el-input
              clearable
              :maxlength="100"
              v-model="form.component"
              :disabled="
                form.menuType === 0 ||
                form.menuType === 2 ||
                form.openType === 2
              "
              :placeholder="
                form.openType === 1 ? '请输入内链地址' : '请输入组件路径'
              "
            />
          </el-form-item>
        </el-col>
        <el-col :sm="12" :xs="24">
          <el-form-item label="权限标识" prop="authority">
            <el-input
              clearable
              v-model="form.authority"
              placeholder="请输入权限标识"
              :disabled="
                form.menuType === 0 ||
                (form.menuType === 1 && form.openType === 2)
              "
            />
          </el-form-item>
          <el-form-item label="排序号" prop="sortNumber">
            <el-input-number
              :min="0"
              :max="99999"
              v-model="form.sortNumber"
              placeholder="请输入排序号"
              controls-position="right"
              class="ele-fluid"
            />
          </el-form-item>
          <el-form-item label="是否展示">
            <el-switch
              inline-prompt
              active-text="是"
              inactive-text="否"
              :model-value="form.hide === 0"
              :disabled="form.menuType === 2"
              @change="updateHideValue"
            />
            <ele-tooltip
              content="选择不展示只注册路由不展示在侧边栏, 比如添加页面应该选择不展示"
              :popper-style="{ maxWidth: '240px' }"
            >
              <el-icon :size="16" style="margin-left: 16px; cursor: help">
                <warning style="opacity: 0.6" />
              </el-icon>
            </ele-tooltip>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="路由元数据" prop="meta">
        <el-input
          :rows="4"
          type="textarea"
          :maxlength="200"
          v-model="form.meta"
          placeholder="请输入JSON格式的路由元数据"
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="updateModelValue(false)">取消</el-button>
      <el-button type="primary" :loading="loading" @click="save">
        保存
      </el-button>
    </template>
  </ele-modal>
</template>

<script setup>
  import { ref, reactive, watch } from 'vue';
  import { Warning } from '@element-plus/icons-vue';
  import { EleMessage, isExternalLink, toTree } from 'ele-admin-plus/es';
  import { useFormData } from '@/utils/use-form-data';
  import { listMenus, addMenu, updateMenu } from '@/api/system/menu';

  const emit = defineEmits(['done', 'update:modelValue']);

  const props = defineProps({
    // 弹窗是否打开
    modelValue: Boolean,
    // 修改回显的数据
    data: Object,
    // 上级菜单id
    parentId: Number
  });

  // 菜单树选择数据
  const menus = ref([]);

  // 是否是修改
  const isUpdate = ref(false);

  // 提交状态
  const loading = ref(false);

  // 表单实例
  const formRef = ref(null);

  // 表单数据
  const { form, resetFields, assignFields } = useFormData({
    menuId: void 0,
    parentId: void 0,
    title: '',
    menuType: 0,
    openType: 0,
    icon: '',
    path: '',
    component: '',
    authority: '',
    sortNumber: void 0,
    hide: 0,
    meta: ''
  });

  // 表单验证规则
  const rules = reactive({
    title: [
      {
        required: true,
        type: 'string',
        message: '请输入菜单名称',
        trigger: 'blur'
      }
    ],
    sortNumber: [
      {
        required: true,
        type: 'number',
        message: '请输入排序号',
        trigger: 'blur'
      }
    ],
    meta: [
      {
        type: 'string',
        validator: (_rule, value, callback) => {
          if (value) {
            const msg = '请输入正确的JSON格式';
            try {
              const obj = JSON.parse(value);
              if (obj == null || typeof obj !== 'object') {
                return callback(msg);
              }
            } catch (_e) {
              return callback(msg);
            }
          }
          callback();
        },
        trigger: 'blur'
      }
    ]
  });

  /* 保存编辑 */
  const save = () => {
    formRef.value?.validate((valid) => {
      if (!valid) {
        return;
      }
      loading.value = true;
      const saveOrUpdate = isUpdate.value ? updateMenu : addMenu;
      saveOrUpdate({
        ...form,
        // menuType 对应的值与后端不一致在前端处理
        menuType: form.menuType === 2 ? 1 : 0,
        parentId: form.parentId || 0
      })
        .then((msg) => {
          loading.value = false;
          EleMessage.success(msg);
          updateModelValue(false);
          emit('done');
        })
        .catch((e) => {
          loading.value = false;
          EleMessage.error(e.message);
        });
    });
  };

  /* 更新modelValue */
  const updateModelValue = (value) => {
    emit('update:modelValue', value);
  };

  /* menuType选择改变 */
  const onMenuTypeChange = () => {
    if (form.menuType === 0) {
      form.authority = '';
      form.openType = 0;
      form.component = '';
    } else if (form.menuType === 1) {
      if (form.openType === 2) {
        form.authority = '';
      }
    } else {
      form.openType = 0;
      form.icon = '';
      form.path = '';
      form.component = '';
      form.hide = 0;
    }
  };

  /* openType选择改变 */
  const onOpenTypeChange = () => {
    if (form.openType === 2) {
      form.component = '';
      form.authority = '';
    }
  };

  /* hide选择改变 */
  const updateHideValue = (value) => {
    form.hide = value ? 0 : 1;
  };

  /* 判断是否是目录 */
  const isDirectory = (d) => {
    return !!d.children?.length && !d.component;
  };

  watch(
    () => props.modelValue,
    (modelValue) => {
      if (modelValue) {
        if (props.data) {
          const isExternal = isExternalLink(props.data.path);
          const isInner = isExternalLink(props.data.component);
          // menuType对应的值与后端不一致在前端处理
          const menuType =
            props.data.menuType === 1 ? 2 : isDirectory(props.data) ? 0 : 1;
          assignFields({
            ...props.data,
            menuType,
            openType: isExternal ? 2 : isInner ? 1 : 0,
            parentId: props.data.parentId === 0 ? void 0 : props.data.parentId
          });
          isUpdate.value = true;
        } else {
          form.parentId = props.parentId;
          isUpdate.value = false;
        }
        // 查询菜单树选择数据
        listMenus()
          .then((data) => {
            menus.value = toTree({
              data,
              idField: 'menuId',
              parentIdField: 'parentId'
            });
          })
          .catch((e) => {
            EleMessage.error(e.message);
          });
      } else {
        resetFields();
        formRef.value?.clearValidate();
      }
    }
  );
</script>

<script>
  import * as MenuIcons from '@/layout/menu-icons';

  export default {
    components: MenuIcons,
    data() {
      return {
        iconData: Object.keys(MenuIcons)
      };
    }
  };
</script>
