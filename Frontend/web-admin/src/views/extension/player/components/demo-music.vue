<template>
  <ele-card header="音乐播放功能演示">
    <div
      :key="current.vid"
      class="music-body"
      :style="{ backgroundImage: `url('${current.poster}')` }"
    >
      <div ref="lrcRef" class="lrc-wrap" style="height: 100%"></div>
      <canvas ref="analyzeRef" class="analyze-wrap"></canvas>
    </div>
    <div class="music-footer">
      <div class="music-controls">
        <el-icon>
          <step-backward-filled @click="playPrev" />
        </el-icon>
        <el-icon @click="playOrPause">
          <pause-filled v-if="playing" style="transform: scale(1.4)" />
          <play-filled v-else style="transform: scale(1.4)" />
        </el-icon>
        <el-icon>
          <step-forward-filled @click="playNext" />
        </el-icon>
      </div>
      <ele-xg-player
        :key="current.vid"
        :config="config"
        @player="onPlayer"
        style="flex: 1; overflow: visible"
      />
    </div>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import MusicPreset, { Analyze, Lyric } from 'xgplayer-music';
  import {
    PlayFilled,
    PauseFilled,
    StepForwardFilled,
    StepBackwardFilled
  } from '@/components/icons';
  // 歌词
  const lyrics = [
    {
      vid: '000001',
      lrc: `[00:00.00] 脆弱一分钟\n[00:00.00] 作曲 : 林家谦\n[00:00.00] 作词 : 徐世珍/吴辉福\n[00:00.000]编曲：林家谦\n[00:00.000]时钟不要走\n[00:04.220]让我脆弱一分钟\n[00:07.440]要多久才能习惯被放手\n[00:15.800]马克杯空了 暖暖的温热\n[00:22.660]却还在我手中停留\n[00:27.960]\n[00:29.790]勇气不要走\n[00:32.200]给我理由再冲动\n[00:35.690]去相信爱情 就算还在痛\n[00:43.960]如果我不说不会有人懂\n[00:50.720]失去你我有多寂寞\n[00:55.610]还是愿意\n[00:57.580]付出一切仅仅为了一个好梦\n[01:03.980]梦里有人真心爱我 陪我快乐也陪我沉默\n[01:11.260]没有无缘无故的痛承受越多越成熟\n[01:18.630]能让你拥抱更好的我\n[01:25.030] 谁也不要走\n[01:28.270]应该是一种奢求\n[01:31.900]可是我只想 握紧你的手\n[01:39.780]我宁愿等候 也不愿错过\n[01:46.630]你对我微笑的时候\n[01:56.780]\n[02:18.910]还是愿意\n[02:21.320]用尽全力仅仅为了一个以后\n[02:27.870]哪怕生命并不温柔哪怕被幸福一再反驳\n[02:34.870]也要相信伤痕累累 其实只是在琢磨\n[02:42.070]能让你为之一亮 的我\n[02:53.910]\n[02:56.350]制作人：林宥嘉\n[02:57.750]制作助理：张婕汝\n[02:59.010]录音师：陈文骏、叶育轩\n[03:00.410]录音室：白金录音室\n[03:01.740]混音师：SimonLi @ nOiz\n[03:03.000]OP: Terence Lam Production & Co. (Warner/Chappell Music, HK Ltd.)\n[03:04.050]SP: Warner/Chappell Music Taiwan Ltd.\n[03:04.910]OP：Universal Ms Publ Ltd Taiwan\n`
    },
    {
      vid: '000002',
      lrc: `[00:00.000]Westlife-My Love\n[00:08.800]An empty street\n[00:10.510]An empty house\n[00:12.200]A hole inside my heart\n[00:15.470]I am all alone\n[00:17.270]The rooms are getting smaller\n[00:22.440]I wonder how\n[00:23.850]I wonder why\n[00:25.460]I wonder where they are\n[00:28.870]The days we had\n[00:30.500]The songs we sang together\n[00:33.320]Oh yeah\n[00:35.480]And oh my love\n[00:38.710]I am holding on forever\n[00:42.200]Reaching for a love that seems so far\n[00:48.070]So i say a little prayer\n[00:51.100]And hope my dreams will take me there\n[00:54.520]Where the skies are blue to see you once again, my love\n[01:01.230]Over seas and coast to coast\n[01:04.430]To find a place i love the most\n[01:07.830]Where the fields are green to see you once again, my love\n[01:18.730]I try to read\n[01:20.210]I go to work\n[01:21.900]I am laughing with my friends\n[01:25.180]But i cannot stop to keep myself from thinking\n[01:29.710]Oh no I wonder how\n[01:33.420]I wonder why\n[01:34.960]I wonder where they are\n[01:38.470]The days we had\n[01:40.150]The songs we sang together\n[01:42.900]Oh yeah And oh my love\n[01:48.300]I am holding on forever\n[01:51.760]Reaching for a love that seems so far Mark:\n[01:58.070]So i say a little prayer\n[02:01.400]And hope my dreams will take me there\n[02:04.800]Where the skies are blue to see you once again, my love\n[02:11.400]Over seas and coast to coast\n[02:14.720]To find a place i love the most\n[02:18.080]Where the fields are green to see you once again, my love\n[02:24.040]To hold you in my arms\n[02:27.290]To promise you my love\n[02:30.610]To tell you from the heart\n[02:33.870]You are all i am thinking of\n[02:45.460]I am reaching for a love that seems so far\n[02:51.940]So i say a little prayer\n[02:54.820]And hope my dreams will take me there\n[02:58.080]Where the skies are blue to see you once again, my love\n[03:04.700]Over seas and coast to coast\n[03:07.980]To find a place i love the most\n[03:11.520]Where the fields are green to see you once again,my love\n[03:19.000]Where the fields are green to see you once again,my love\n[03:31.580]Over seas and coast to coast\n[03:34.670]To find a place i love the most\n[03:38.110]Where the fields are green to see you once again,my love\n[03:19.020]say a little prayer\n[03:22.300]dreams will take me there\n[03:24.770]Where the skies are blue to see you once again\n`
    }
  ];
  // 歌曲
  const songs = [
    {
      vid: '000001',
      src: '//sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/music/audio.mp3',
      poster:
        'https://imgcache.qq.com/open_proj/proj_qcloud_v2/gateway/solution/general-video/css/img/scene/1.png'
    },
    {
      vid: '000002',
      src: '//sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/music/audio-en.mp3',
      poster:
        'https://imgcache.qq.com/open_proj/proj_qcloud_v2/gateway/solution/general-video/css/img/scene/6.png'
    }
  ];

  // 播放器配置
  const config = ref({
    url: songs[0].src,
    volume: 1,
    height: 54,
    width: '100%',
    autoplay: false,
    mediaType: 'audio',
    marginControls: true,
    controls: { initShow: true, mode: 'flex' },
    ignores: [
      'play',
      'mobile',
      'playbackrate',
      'musicbackword',
      'musicforward',
      'musiccover',
      'musicmeta',
      'musicnext',
      'musicprev'
    ],
    presets: ['default', MusicPreset],
    videoConfig: { crossOrigin: 'anonymous' }
  });

  // 频谱容器
  const analyzeRef = ref(null);

  // 歌词容器
  const lrcRef = ref(null);

  // 当前歌曲
  const current = ref(songs[0]);

  // 是否播放状态
  const playing = ref(false);

  const state = {
    // 视频播放器实例
    player: null,
    // 频谱实例
    analyze: null
  };

  /* 播放器渲染完成 */
  const onPlayer = (ins) => {
    state.player = ins;
    state.player.crossOrigin = 'anonymous';
    state.player.on('pause', () => {
      playing.value = false;
    });
    state.player.on('ended', () => {
      playing.value = false;
      playNext();
    });
    state.player.on('play', () => {
      playing.value = true;
      // 初始化频谱
      if (!state.analyze && analyzeRef.value) {
        state.analyze = new Analyze(state.player, analyzeRef.value, {
          stroke: 1,
          mode: 'vertLines',
          bgColor: 'rgba(0, 0, 0, 0)'
        });
      }
    });
    // 初始化歌词
    const lyric = new Lyric(
      [lyrics.find((d) => d.vid == current.value.vid)?.lrc],
      lrcRef.value
    );
    lyric.bind(state.player);
    lyric.show();
  };

  /* 播放/暂停 */
  const playOrPause = () => {
    if (state.player) {
      if (state.player.paused) {
        state.player.play();
      } else {
        state.player.pause();
      }
    }
  };

  /* 播放下一曲 */
  const playNext = () => {
    const index = songs.findIndex((d) => d.vid === current.value.vid);
    if (index === songs.length - 1) {
      current.value = songs[0];
    } else {
      current.value = songs[index + 1];
    }
    if (state.analyze) {
      state.analyze.stop();
      state.analyze = null;
    }
    config.value = { ...config.value, url: current.value.src, autoplay: true };
  };

  /* 播放上一曲 */
  const playPrev = () => {
    const index = songs.findIndex((d) => d.vid === current.value.vid);
    if (index === 0) {
      current.value = songs[songs.length - 1];
    } else {
      current.value = songs[index - 1];
    }
    if (state.analyze) {
      state.analyze.stop();
      state.analyze = null;
    }
    config.value = { ...config.value, url: current.value.src, autoplay: true };
  };
</script>

<style lang="scss" scoped>
  .music-body {
    height: 325px;
    position: relative;
    background-color: #000;
    background-repeat: no-repeat;
    background-size: cover;

    &::before,
    &::after {
      content: '';
      height: 80px;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      background-image: linear-gradient(
        to bottom,
        rgba(0, 0, 0, 0.6),
        rgba(0, 0, 0, 0)
      );
      z-index: 2;
    }

    &::after {
      top: auto;
      bottom: 0;
      background-image: linear-gradient(
        to bottom,
        rgba(0, 0, 0, 0),
        rgba(0, 0, 0, 0.6)
      );
    }
  }

  .lrc-wrap :deep(.xgplayer-lrcWrap) {
    height: 100%;
    padding: 80px 0;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    color: rgba(255, 255, 255, 0.8);
    font-size: 16px;
    line-height: 2;
    overflow: auto;

    .xgplayer-lyric-item-active {
      color: #e31106;
      font-weight: bold;
    }

    &::-webkit-scrollbar {
      display: none;
    }
  }

  .analyze-wrap {
    width: 100%;
    height: 60px;
    display: block;
    position: absolute;
    bottom: 0;
    left: 0;
    z-index: 3;
  }

  .music-footer {
    display: flex;
    align-items: center;
    background: #000;
    color: #fff;

    :deep(.xg-center-grid) {
      padding-left: 0;
    }
  }

  .music-controls {
    font-size: 26px;
    display: flex;
    align-items: center;

    .el-icon {
      cursor: pointer;
      margin-left: 10px;
    }
  }
</style>
