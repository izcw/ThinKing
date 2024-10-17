<template>
  <ele-page>
    <ele-card header="状态文本">
      <option-item label="默认效果">
        <el-space size="large">
          <ele-dot :ripple="ripple" text="运行中" :size="dotSize" />
          <ele-dot
            type="success"
            :ripple="ripple"
            text="已上线"
            :size="dotSize"
          />
          <ele-dot type="danger" :ripple="ripple" text="异常" :size="dotSize" />
          <ele-dot type="info" :ripple="ripple" text="关闭" :size="dotSize" />
        </el-space>
      </option-item>
      <option-item label="显示动画">
        <el-radio-group v-model="ripple">
          <el-radio :label="true">是</el-radio>
          <el-radio :label="false">否</el-radio>
        </el-radio-group>
      </option-item>
      <option-item label="尺寸选择">
        <el-radio-group v-model="dotSize">
          <el-radio label="7px">7px</el-radio>
          <el-radio label="11px">11px</el-radio>
          <el-radio label="15px">15px</el-radio>
        </el-radio-group>
      </option-item>
    </ele-card>
    <ele-card header="水波仪表">
      <ele-dashboard type="success" style="margin-right: 18px">
        <div style="line-height: 1">
          <span style="font-size: 48px">100</span>
          <span style="font-size: 12px; margin-left: 4px">分</span>
        </div>
        <div style="margin-top: 4px">安全</div>
      </ele-dashboard>
      <ele-dashboard type="warning" style="margin-right: 18px">
        <div style="line-height: 1">
          <span style="font-size: 48px">70</span>
          <span style="font-size: 12px; margin-left: 4px">分</span>
        </div>
        <div style="margin-top: 4px">待优化</div>
      </ele-dashboard>
      <ele-dashboard type="danger">
        <div style="line-height: 1">
          <span style="font-size: 48px">40</span>
          <span style="font-size: 12px; margin-left: 4px">分</span>
        </div>
        <div style="margin-top: 4px">高风险</div>
      </ele-dashboard>
    </ele-card>
    <ele-card header="自定义颜色和尺寸">
      <ele-dashboard color="#722ED1" style="margin-right: 18px">
        <div style="font-size: 48px">100</div>
      </ele-dashboard>
      <ele-dashboard size="108px" space="14px">
        <div style="font-size: 38px">100</div>
      </ele-dashboard>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref } from 'vue';
  import OptionItem from '../avatar/components/option-item.vue';

  // 状态圆点是否显示动画
  const ripple = ref(true);

  // 状态圆点尺寸
  const dotSize = ref('11px');
</script>

<script>
  export default {
    name: 'ExtensionCircleWave'
  };
</script>
