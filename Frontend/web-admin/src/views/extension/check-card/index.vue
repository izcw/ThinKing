<template>
  <ele-page>
    <ele-card header="基本用法">
      <ele-check-card
        multiple
        v-model="checked"
        :items="items"
        :row="{ gutter: 12 }"
      >
        <template #item="{ item }">
          <div style="display: flex; padding: 18px 12px; height: 87px">
            <el-avatar :size="46" shape="square" :src="item.avatar" />
            <div style="flex: 1; overflow: hidden; padding-left: 12px">
              <ele-text size="md">{{ item.title }}</ele-text>
              <ele-ellipsis size="sm" type="secondary" :max-line="3">
                {{ item.content }}
              </ele-ellipsis>
            </div>
          </div>
        </template>
      </ele-check-card>
      <div>已选中：{{ JSON.stringify(checked) }}</div>
    </ele-card>
    <ele-card header="单选模式">
      <ele-check-card v-model="checked2" :items="items" :row="{ gutter: 12 }">
        <template #item="{ item }">
          <div style="display: flex; padding: 18px 12px; height: 87px">
            <el-avatar :size="46" shape="square" :src="item.avatar" />
            <div style="flex: 1; overflow: hidden; padding-left: 12px">
              <ele-text size="md">{{ item.title }}</ele-text>
              <ele-ellipsis size="sm" type="secondary" :max-line="3">
                {{ item.content }}
              </ele-ellipsis>
            </div>
          </div>
        </template>
      </ele-check-card>
      <div>已选中：{{ checked2 }}</div>
    </ele-card>
    <ele-card header="禁用">
      <ele-check-card
        :items="items2"
        v-model="checked2"
        :disabled="disabled"
        :row="{ gutter: 12 }"
      >
        <template #item="{ item }">
          <div style="display: flex; padding: 18px 12px; height: 87px">
            <el-avatar :size="46" shape="square" :src="item.avatar" />
            <div style="flex: 1; overflow: hidden; padding-left: 12px">
              <ele-text size="md">{{ item.title }}</ele-text>
              <ele-ellipsis size="sm" type="secondary" :max-line="3">
                {{ item.content }}
              </ele-ellipsis>
            </div>
          </div>
        </template>
      </ele-check-card>
      <div style="display: flex; align-items: center">
        <div>整体禁用：</div>
        <el-switch v-model="disabled" size="small" />
      </div>
    </ele-card>
    <ele-card header="标签风格">
      <div style="display: flex">
        <div style="flex-shrink: 0">个人爱好:</div>
        <ele-check-card
          :arrow="false"
          :bordered="false"
          v-model="checked3"
          :items="items4"
          class="check-tag"
        />
      </div>
      <div style="display: flex; margin-top: 12px">
        <div style="flex-shrink: 0">个人爱好:</div>
        <ele-check-card
          multiple
          :arrow="false"
          :bordered="false"
          v-model="checked4"
          :items="items4"
          class="check-tag"
        />
      </div>
    </ele-card>
    <ele-card header="自定义内容">
      <div style="display: flex">
        <div style="flex-shrink: 0; margin-top: 20px">支付方式:&emsp;</div>
        <ele-check-card
          v-model="checked5"
          :items="items5"
          :item-style="{ margin: '8px', padding: '8px 12px', display: 'flex' }"
          style="display: flex; flex-wrap: wrap"
        >
          <template #item="{ item }">
            <img
              :src="item.img"
              style="width: 98px; height: 28px; object-fit: contain"
            />
          </template>
        </ele-check-card>
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import { getDemoCardData } from '@/api/example';

  // 卡片选中
  const checked = ref([2]);

  // 卡片数据
  const items = ref([]);

  // 获取卡片数据
  // getDemoCardData()
  //   .then((data) => {
  //     items.value = data.map((d) => {
  //       return {
  //         ...d,
  //         col: { md: 6, sm: 12, xs: 24, style: { marginBottom: '12px' } }
  //       };
  //     });
  //     items2.value = items.value.map((d) => {
  //       return { ...d, disabled: d.value === 2 };
  //     });
  //   })
  //   .catch((e) => {
  //     console.error(e);
  //   });

  // 单选选中
  const checked2 = ref();

  // 有禁用的数据
  const items2 = ref([]);

  // 整体禁用
  const disabled = ref(false);

  // 标签风格单选
  const checked3 = ref('看电影');

  // 标签风格多选
  const checked4 = ref(['看电影']);

  // 个人爱好数据
  const items4 = ref([
    { value: '看电影' },
    { value: '听音乐' },
    { value: '打篮球' },
    { value: '阅读' }
  ]);

  // 支付方式
  const checked5 = ref();

  // 支付方式数据
  const items5 = ref([
    {
      value: 1,
      img: 'https://gw.alipayobjects.com/mdn/member_frontWeb/afts/img/A*oRlnSYAsgYQAAAAAAAAAAABkARQnAQ'
    },
    {
      value: 2,
      img: 'https://e.gitee.com/assets/images/wechatpay.png'
    },
    {
      value: 3,
      img: 'https://cn.unionpay.com/upowhtml/cn/resources/images/header/homepage-logo.png'
    }
  ]);
</script>

<script>
  export default {
    name: 'ExtensionCheckCard'
  };
</script>

<style lang="scss" scoped>
  /* 标签风格 */
  .check-tag {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    box-sizing: border-box;
    padding-left: 12px;

    :deep(.ele-check-card) {
      font-size: 13px;
      height: 23px;
      line-height: 23px;
      padding: 0 8px;
      margin: 0 8px 8px 0;
      border-radius: 4px;
      transition: (color 0.2s, background-color 0.2s);

      &:not(.is-disabled):not(.is-checked):hover {
        background: var(--el-fill-color-light);
      }

      &.is-checked {
        color: #fff;
        background: var(--el-color-primary);
      }

      &.is-disabled {
        background: none;
        opacity: 1;

        &.is-checked {
          color: var(--el-disabled-text-color);
          background: var(--el-disabled-bg-color);
        }
      }
    }
  }
</style>
