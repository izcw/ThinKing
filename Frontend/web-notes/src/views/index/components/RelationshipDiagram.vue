<template>
  <div class="RelationshipDiagramBox card text-select">
    <p><el-text class="mx-1" type="primary">笔记关系谱</el-text></p>
    <div style="width: 100%;height: calc(100% - 40px);margin-top: 1rem;">
      <RelationGraph ref="graphRef" :options="graphOptions" @node-click="onNodeClick" @line-click="onLineClick" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import RelationGraph from 'relation-graph-vue3';
import type { RGJsonData, RGNode, RGLine, RGLink, RGUserEvent, RGOptions, RelationGraphComponent } from 'relation-graph-vue3';

// 定义 graphRef 引用
const graphRef = ref<RelationGraphComponent>();

// 配置图谱选项
const graphOptions: RGOptions = {
  debug: false,
  allowSwitchLineShape: true,
  allowSwitchJunctionPoint: true,
  allowShowDownloadButton: true,
  defaultJunctionPoint: 'border',
  defaultLineWidth: 2,
  defaultLineColor: '#333333',
  layout: {
    layoutName: 'force',
  },
};

// 初始化图谱数据
const showGraph = () => {
  const __graph_json_data: RGJsonData = {
    rootId: '',
    nodes: [
      { id: 'a', text: 'a' },
      { id: 'b', text: 'b' },
      { id: 'b1', text: 'b1' },
      { id: 'b2', text: 'b2' },
      { id: 'b3', text: 'b3' },
      { id: 'b4', text: '探索java' },
      { id: 'b5', text: 'b5' },
      { id: 'b6', text: 'b6' },
      { id: 'c', text: 'c' },
      { id: 'c1', text: 'c1' },
      { id: 'c2', text: 'c2' },
      { id: 'c3', text: 'c3' },
      { id: 'd', text: 'd' },
      { id: 'd1', text: 'd1' },
      { id: 'd2', text: 'd2' },
      { id: 'd3', text: '文学的力量' },
      { id: 'd4', text: 'd4' },
      { id: 'e', text: 'e' },
      { id: 'e1', text: 'e1' },
      { id: 'e2', text: 'java' },
    ],
    lines: [
      { from: 'b', to: 'b1' },
      { from: 'b', to: 'b2' },
      { from: 'd', to: 'd1' },
      { from: 'd', to: 'd2' },
      { from: 'SpringBoot', to: 'e2' },
    ],
  };

  // 设置根节点 ID
  const rootId = __graph_json_data.nodes[0].id;
  __graph_json_data.rootId = rootId;

  // 添加连接根节点的透明线
  __graph_json_data.nodes.forEach((n) => {
    if (n.id !== rootId) {
      __graph_json_data.lines.push({ from: rootId, to: n.id, opacity: 0 });
    }
  });

  // 加载图谱数据
  graphRef.value?.setJsonData(__graph_json_data, async (graphInstance) => {
    await graphInstance.moveToCenter();
    await graphInstance.zoomToFit();
  });
};

// 节点点击事件处理
const onNodeClick = (nodeObject: RGNode, $event: RGUserEvent) => {
  console.log('onNodeClick:', nodeObject);
};

// 线条点击事件处理
const onLineClick = (lineObject: RGLine, linkObject: RGLink, $event: RGUserEvent) => {
  console.log('onLineClick:', lineObject);
};

// 挂载后初始化图谱
onMounted(() => {
  showGraph();
});
</script>

<style scoped lang="scss">
.RelationshipDiagramBox {
  width: 100%;
  height:400px;
  // margin-top: 500px;
}


</style>