<template>
  <div class="RelationshipDiagramBox card text-select">
    <p><el-text class="mx-1" type="primary">笔记关系谱</el-text></p>
    <div style="width: 100%;height: calc(100% - 40px);margin-top: 1rem;">
      <RelationGraph ref="graphRef" :options="graphOptions" @node-click="onNodeClick" @line-click="onLineClick" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted, watch } from 'vue';
import RelationGraph from 'relation-graph-vue3';
import type { RGJsonData, RGNode, RGLine, RGLink, RGUserEvent, RGOptions, RelationGraphComponent } from 'relation-graph-vue3';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore();
import { useRouter } from 'vue-router'
const router = useRouter()

const nodes = ref([])
const lines = ref([])

watch(() => store.spacePageData, (newVal) => {
  console.log("hhh");
  showGraph();
})


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
  nodes.value = store.spacePageData.map(page => ({
    id: page.pageId,
    text: page.title
  }));
  lines.value = store.spacePageData.filter(page => page.parentId !== '0').map(page => ({
    from: page.pageId,
    to: page.parentId
  }));
  const __graph_json_data: RGJsonData = {
    rootId: '',
    nodes: nodes.value,
    lines: lines.value,
  };

  if (nodes.value.length > 0) {
    // 设置根节点 ID
    const rootId = __graph_json_data.nodes[0].id;
    __graph_json_data.rootId = rootId;

    // 添加连接根节点的透明线
    __graph_json_data.nodes.forEach((n) => {
      if (n.id !== rootId) {
        __graph_json_data.lines.push({ from: rootId, to: n.id, opacity: 0 });
      }
    });

  }
  // 加载图谱数据
  graphRef.value?.setJsonData(__graph_json_data, async (graphInstance) => {
    await graphInstance.moveToCenter();
    await graphInstance.zoomToFit();
  });


};

onMounted(() => {
  if (store.spacePageData) {
    showGraph();
  }
})

// 节点点击事件处理
const onNodeClick = (nodeObject: RGNode, $event: RGUserEvent) => {
  console.log('onNodeClick:', nodeObject);
  router.push('/space/' + store.routerParamsId.spaceId + '/' + nodeObject.id);
};

// 线条点击事件处理
const onLineClick = (lineObject: RGLine, linkObject: RGLink, $event: RGUserEvent) => {
  console.log('onLineClick:', lineObject);
};


</script>

<style lang="scss">
.RelationshipDiagramBox {
  width: 100%;
  height: 400px;
  // margin-top: 500px;
}

.c-node-text span {
  font-size: 14px !important;
}
</style>