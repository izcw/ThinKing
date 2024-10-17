<template>
  <ele-page>
    <ele-card header="省市区级联选择">
      <div style="max-width: 280px">
        <regions-select
          v-model="city"
          placeholder="请选择省市区"
          class="ele-fluid"
        />
      </div>
    </ele-card>
    <ele-card header="省市级联选择">
      <div style="max-width: 280px">
        <regions-select
          v-model="provinceCity"
          placeholder="请选择省市"
          type="provinceCity"
          class="ele-fluid"
        />
      </div>
    </ele-card>
    <ele-card header="省选择">
      <div style="max-width: 280px">
        <regions-select
          v-model="province"
          placeholder="请选择省"
          type="province"
          class="ele-fluid"
        />
      </div>
    </ele-card>
    <ele-card header="可多选">
      <div style="max-width: 280px">
        <regions-select
          v-model="citys"
          :filterable="false"
          placeholder="请选择省市区"
          :cascader-props="{ multiple: true }"
          class="ele-fluid"
        />
      </div>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import RegionsSelect from '@/components/RegionsSelect/index.vue';

  // 选中的省市区
  const city = ref([]);

  // 选中的省市
  const provinceCity = ref([]);

  // 选中的省
  const province = ref([]);

  // 选中的省市区
  const citys = ref([]);
</script>

<script>
  export default {
    name: 'ExtensionRegions'
  };
</script>
