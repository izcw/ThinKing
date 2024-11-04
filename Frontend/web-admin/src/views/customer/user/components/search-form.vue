<!-- 搜索表单 -->
<template>
  <ele-card :body-style="{ paddingBottom: '2px' }">
    <el-form label-width="72px">
      <el-row :gutter="8">
        <el-col :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label="邮箱">
            <el-input
              clearable
              v-model.trim="form.username"
              placeholder="请输入"
            />
          </el-form-item>
        </el-col>
        <el-col :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label="手机号">
            <el-input
              clearable
              v-model.trim="form.phone"
              placeholder="请输入"
            />
          </el-form-item>
        </el-col>
        <el-col v-if="searchExpand"  :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label="性别">
            <el-select
              clearable
              v-model="form.sex"
              placeholder="请选择"
              class="ele-fluid"
            >
              <el-option value="1" label="男" />
              <el-option value="2" label="女" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col v-if="searchExpand" :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label="客户名">
            <el-input
              clearable
              v-model.trim="form.nickname"
              placeholder="请输入"
            />
          </el-form-item>
        </el-col>

        <el-col v-if="searchExpand" :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label="状态">
            <el-select
              clearable
              v-model="form.status"
              placeholder="请选择"
              class="ele-fluid"
            >
              <el-option :value="0" label="正常" />
              <el-option :value="1" label="冻结" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :lg="8" :md="12" :sm="12" :xs="24">
          <el-form-item label-width="16px">
            <el-space>
              <el-button type="primary" @click="search">查询</el-button>
              <el-button @click="reset">重置</el-button>
              <el-link type="primary" :underline="false" @click="toggleExpand">
                <span v-if="searchExpand">
                  <span>收起</span>
                  <el-icon style="vertical-align: -1px">
                    <arrow-up />
                  </el-icon>
                </span>
                <span v-else>
                  <span>展开</span>
                  <el-icon style="vertical-align: -2px">
                    <arrow-down />
                  </el-icon>
                </span>
              </el-link>
            </el-space>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { ArrowDown, ArrowUp } from '@element-plus/icons-vue';
  import { useFormData } from '@/utils/use-form-data';

  const emit = defineEmits(['search']);

  // 表单数据
  const { form, resetFields } = useFormData({
    username: '',
    nickname: '',
    sex: void 0,
    phone: '',
    status: void 0
  });

  // 搜索表单是否展开
  const searchExpand = ref(false);

  /* 搜索 */
  const search = () => {
    emit('search', form);
  };

  /*  重置 */
  const reset = () => {
    resetFields();
    search();
  };

  /* 搜索展开/收起 */
  const toggleExpand = () => {
    searchExpand.value = !searchExpand.value;
  };
</script>
