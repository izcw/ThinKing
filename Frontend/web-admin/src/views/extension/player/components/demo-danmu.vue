<template>
  <ele-card header="显示弹幕">
    <!-- 操作按钮 -->
    <el-space style="margin-bottom: 16px">
      <el-input
        style="width: 160px"
        v-model="text"
        placeholder="请输入弹幕内容"
        :disabled="!ready"
      />
      <el-button
        type="primary"
        :disabled="!ready"
        class="ele-btn-icon"
        @click="shoot"
      >
        发射
      </el-button>
    </el-space>
    <!-- 播放器 -->
    <ele-xg-player :config="config" @player="onPlayer" />
  </ele-card>
</template>

<script setup>
  import { ref, reactive } from 'vue';
  import { EleMessage } from 'ele-admin-plus/es';
  import Danmu from 'xgplayer/es/plugins/danmu';
  import 'xgplayer/es/plugins/danmu/index.css';

  // 视频播放器配置
  const config = reactive({
    lang: 'zh-cn',
    fluid: true,
    volume: 1,
    url: 'https://n.v.netease.com/2017/1212_erce/xjy_1080p.mp4',
    poster:
      'https://imgcache.qq.com/open_proj/proj_qcloud_v2/gateway/solution/general-video/css/img/scene/6.png',
    plugins: [Danmu],
    danmu: {
      comments: [
        {
          id: '1',
          start: 2500,
          txt: '空降',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '2',
          start: 3500,
          txt: '空降',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '3',
          start: 4500,
          txt: '简直碉堡了',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '4',
          start: 5000,
          txt: '弹幕护体',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '5',
          start: 6500,
          txt: '前方高能',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '6',
          start: 9000,
          txt: '弹幕护体',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '7',
          start: 11000,
          txt: '666666666',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '8',
          start: 12500,
          txt: '简直碉堡了',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '9',
          start: 15500,
          txt: '弹幕护体',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '10',
          start: 16500,
          txt: '666666666',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '11',
          start: 18000,
          txt: '画面太美不敢看',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '12',
          start: 20500,
          txt: '666666666',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '13',
          start: 22000,
          txt: '画面太美不敢看',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '14',
          start: 25500,
          txt: '666666666',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        },
        {
          id: '15',
          start: 26000,
          txt: '前方高能666',
          duration: 15000,
          color: true,
          style: {
            color: '#ffcd08',
            fontSize: '20px'
          }
        }
      ]
    }
  });

  // 视频播放器是否实例化完成
  const ready = ref(false);

  // 弹幕输入内容
  const text = ref('');

  // 视频播放器实例
  let player;

  /* 播放器二渲染完成 */
  const onPlayer = (e) => {
    player = e;
    player.on('play', () => {
      ready.value = true;
    });
  };

  /* 发射弹幕 */
  const shoot = () => {
    if (!player) {
      return;
    }
    if (!text.value) {
      EleMessage.error('请输入弹幕内容');
      return;
    }
    const danmuIns = player.getPlugin('danmu');
    danmuIns.sendComment({
      id: new Date().getTime(),
      duration: 15000,
      color: true,
      start: player.currentTime * 1000,
      txt: text.value,
      style: {
        color: '#fa1f41',
        fontSize: '20px',
        border: 'solid 1px #fa1f41'
      }
    });
    text.value = '';
  };
</script>
