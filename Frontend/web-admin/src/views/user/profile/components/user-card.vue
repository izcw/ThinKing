<template>
  <ele-card>
    <div class="info-user">
      <div class="info-user-avatar" @click="openCropper">
        <el-avatar :size="100" :src="data.avatar" />
        <el-icon class="info-user-avatar-icon">
          <upload />
        </el-icon>
      </div>
      <ele-text size="xxl" style="margin-top: 5px">
        {{ data.nickname }}
      </ele-text>
      <ele-text type="placeholder">{{ data.introduction }}</ele-text>
    </div>
    <div class="info-list">
      <div class="info-item">
        <el-icon>
          <user-icon />
        </el-icon>
        <div class="info-item-text">资深前端工程师</div>
      </div>
      <div class="info-item">
        <el-icon>
          <office-building />
        </el-icon>
        <div class="info-item-text">某某公司 - 研发部 - 某某组</div>
      </div>
      <div class="info-item">
        <el-icon>
          <location />
        </el-icon>
        <div class="info-item-text">中国 • 浙江省 • 杭州市</div>
      </div>
      <div class="info-item">
        <el-icon>
          <price-tag />
        </el-icon>
        <div class="info-item-text">JavaScript、HTML、CSS</div>
      </div>
    </div>
    <el-divider border-style="dashed" style="margin: 0" />
    <ele-text size="md" style="margin-top: 16px">标签</ele-text>
    <div class="info-tags" style="margin-top: 12px">
      <el-tag type="info" size="small" :disable-transitions="true">
        很有想法的
      </el-tag>
      <el-tag type="info" size="small" :disable-transitions="true">
        专注设计
      </el-tag>
      <el-tag type="info" size="small" :disable-transitions="true">辣~</el-tag>
      <el-tag type="info" size="small" :disable-transitions="true">
        大长腿
      </el-tag>
      <el-tag type="info" size="small" :disable-transitions="true">
        川妹子
      </el-tag>
      <el-tag type="info" size="small" :disable-transitions="true">
        海纳百川
      </el-tag>
    </div>
    <!-- 头像裁剪弹窗 -->
    <ele-cropper-modal
      v-model="visible"
      :src="data.avatar"
      :options="{
        aspectRatio: 1,
        autoCropArea: 1,
        viewMode: 1,
        dragMode: 'move'
      }"
      :modal-props="{ destroyOnClose: true }"
      @done="onCrop"
    />
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import {
    Upload,
    User as UserIcon,
    OfficeBuilding,
    Location,
    PriceTag
  } from '@element-plus/icons-vue';
  //import { EleMessage } from 'ele-admin-plus/es';
  //import { updateUserInfo } from '@/api/layout';

  defineProps({
    data: Object
  });

  const emit = defineEmits(['done']);

  // 是否显示裁剪弹窗
  const visible = ref(false);

  /* 打开图片裁剪 */
  const openCropper = () => {
    visible.value = true;
  };

  /* 头像裁剪完成回调 */
  const onCrop = (result) => {
    visible.value = false;
    emit('done', { avatar: result });
    /* const loading = EleMessage.loading('请求中..');
    updateUserInfo({ avatar: result })
      .then((data) => {
        loading.close();
        visible.value = false;
        EleMessage.success('修改成功');
        emit('done', data);
      })
      .catch((e) => {
        loading.close();
        EleMessage.error(e.message);
      }); */
  };
</script>

<style lang="scss" scoped>
  .info-user {
    padding-top: 8px;
    box-sizing: border-box;
    text-align: center;

    .info-user-avatar {
      display: inline-block;
      position: relative;
      cursor: pointer;
      line-height: 0;

      .info-user-avatar-icon {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: #fff;
        font-size: 30px;
        display: none;
        z-index: 2;
      }

      &::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background-color: transparent;
        transition: background-color 0.3s;
      }

      &:hover {
        .info-user-avatar-icon {
          display: block;
        }

        &::after {
          background-color: rgba(0, 0, 0, 0.4);
        }
      }
    }
  }

  .info-list {
    margin: 35px 0 24px 0;

    .info-item {
      display: flex;
      align-items: center;

      & > .el-icon {
        font-size: 16px;
      }

      .info-item-text {
        flex: 1;
        padding-left: 8px;
        box-sizing: border-box;
      }

      & + .info-item {
        margin-top: 10px;
      }
    }
  }

  .info-tags .el-tag {
    margin: 0 12px 8px 0;
  }
</style>
