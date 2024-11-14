<template>
  <ele-page multi-card>
    <ele-card header="基础用法">
      <el-form label-width="80px" style="max-width: 320px">
        <el-form-item label="纸张方向">
          <el-select
            clearable
            class="ele-fluid"
            placeholder="不设置"
            v-model="option.direction"
          >
            <el-option value="landscape" label="横向" />
            <el-option value="portrait" label="纵向" />
          </el-select>
        </el-form-item>
        <el-form-item label="纸张旋转">
          <el-select
            clearable
            class="ele-fluid"
            placeholder="不旋转"
            v-model="option.orientation"
          >
            <el-option value="rotate-left" label="向左旋转" />
            <el-option value="rotate-right" label="向右旋转" />
          </el-select>
        </el-form-item>
        <el-form-item label="页面间距">
          <el-input clearable v-model="option.margin" placeholder="不设置" />
        </el-form-item>
        <el-form-item label="页面标题">
          <el-input clearable v-model="option.title" placeholder="默认" />
        </el-form-item>
        <el-form-item label="打印位置">
          <el-select class="ele-fluid" v-model="option.target">
            <el-option value="_iframe" label="子窗口" />
            <el-option value="_self" label="当前窗口" />
          </el-select>
        </el-form-item>
        <el-form-item label="始终显示">
          <el-radio-group v-model="option.static">
            <el-radio :label="false">否</el-radio>
            <el-radio :label="true">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onPrint">打印</el-button>
        </el-form-item>
      </el-form>
      <ele-printer
        v-model="printing"
        :direction="option.direction"
        :orientation="option.orientation"
        :margin="option.margin"
        :title="option.title"
        :target="option.target"
        :static="option.static"
        :body-style="{ overflow: 'hidden' }"
        @done="onPrintDone"
      >
        <ele-watermark content="Ele Admin Plus" :gap="[60, 40]">
          <div style="overflow: auto">
            <ele-table style="min-width: 600px" size="large">
              <colgroup>
                <col width="38px" />
                <col width="200px" />
                <col width="140px" />
                <col width="138px" />
                <col width="138px" />
                <col width="118px" />
                <col width="180px" />
              </colgroup>
              <thead>
                <tr>
                  <th></th>
                  <th>项目名称</th>
                  <th>金额(万元)</th>
                  <th>开始时间</th>
                  <th>结束时间</th>
                  <th>状态</th>
                  <th>进度</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(row, index) in projectList" :key="row.id">
                  <td style="text-align: center">{{ index + 1 }}</td>
                  <td>{{ row.projectName }}</td>
                  <td>
                    <el-input v-model="row.money" />
                  </td>
                  <td>{{ row.startDate }}</td>
                  <td>{{ row.endDate }}</td>
                  <td>
                    <ele-text v-if="row.status === 0" type="success">
                      进行中
                    </ele-text>
                    <ele-text v-else-if="row.status === 1" type="danger">
                      已延期
                    </ele-text>
                    <ele-text v-else-if="row.status === 2" type="warning">
                      未开始
                    </ele-text>
                    <ele-text v-else-if="row.status === 3" type="info">
                      已结束
                    </ele-text>
                  </td>
                  <td>
                    <el-progress :percentage="row.progress" />
                  </td>
                </tr>
              </tbody>
            </ele-table>
          </div>
        </ele-watermark>
        <div style="margin: 12px 0">更多表单组件演示：</div>
        <div>
          <el-radio-group v-model="status">
            <el-radio label="未完成">未完成</el-radio>
            <el-radio label="已完成">已完成</el-radio>
          </el-radio-group>
        </div>
        <div>
          <el-checkbox-group v-model="citys">
            <el-checkbox label="武汉">武汉</el-checkbox>
            <el-checkbox label="北京">北京</el-checkbox>
            <el-checkbox label="上海">上海</el-checkbox>
            <el-checkbox label="广州">广州</el-checkbox>
            <el-checkbox label="深圳">深圳</el-checkbox>
          </el-checkbox-group>
        </div>
        <div style="margin: 12px 0">自定义更加适合打印风格的复选框组件：</div>
        <div>
          <print-checkbox
            v-model="citys"
            :items="[
              { label: '武汉', value: '武汉' },
              { label: '北京', value: '北京' },
              { label: '上海', value: '上海' },
              { label: '广州', value: '广州' },
              { label: '深圳', value: '深圳' }
            ]"
          />
        </div>
      </ele-printer>
    </ele-card>
    <ele-card header="使用案例">
      <el-form label-width="80px" style="max-width: 320px">
        <el-form-item label="甲方">
          <el-input clearable v-model="form.partyA" />
        </el-form-item>
        <el-form-item label="乙方">
          <el-input clearable v-model="form.partyB" />
        </el-form-item>
        <el-form-item label="房屋地址">
          <el-input clearable v-model="form.address" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onPrint2">打印</el-button>
        </el-form-item>
      </el-form>
      <print-contract
        ref="contractRef"
        :data="contractData"
        :static="option.static"
      />
    </ele-card>
    <ele-card header="更多功能">
      <el-button type="primary" @click="onPrintPdf">打印pdf</el-button>
    </ele-card>
  </ele-page>
</template>

<script setup>
  import { ref, reactive, nextTick } from 'vue';
  import { printPdf } from 'ele-admin-plus/es/ele-printer/util';
  import { EleMessage } from 'ele-admin-plus/es';
  import { getProjectList } from '@/api/example';
  import PrintCheckbox from './components/print-checkbox.vue';
  import PrintContract from './components/print-contract.vue';
  import dayjs from 'dayjs';

  // 是否打印
  const printing = ref(false);

  // 打印参数
  const option = reactive({
    direction: void 0,
    orientation: void 0,
    margin: '',
    title: '',
    target: '_iframe',
    static: false
  });

  /* 打印 */
  const onPrint = () => {
    console.log('开始打印...');
    printing.value = true;
  };

  /* 打印结束事件 */
  const onPrintDone = () => {
    console.log('打印结束.');
  };

  // 是否完成
  const status = ref('未完成');

  // 城市
  const citys = ref(['武汉', '北京']);

  // 项目进度数据
  const projectList = ref([]);

  /* 查询项目进度 */
  const queryProjectList = () => {
    // getProjectList()
    //   .then((data) => {
    //     projectList.value = data;
    //   })
    //   .catch((e) => {
    //     console.error(e);
    //   });
  };

  queryProjectList();

  // 表单数据
  const form = reactive({
    partyA: 'XX房屋租赁有限公司',
    partyB: '张三',
    address: 'XX省XX市XX区XX街道XX小区18栋一单元1104室'
  });

  // 合同组件
  const contractRef = ref(null);

  // 合同数据
  const contractData = ref(null);

  /* 打印合同 */
  const onPrint2 = () => {
    contractData.value = {
      ...form,
      date: dayjs().format('YYYY-MM-DD'),
      projects: [
        ...projectList.value,
        ...projectList.value,
        ...projectList.value,
        ...projectList.value
      ].map((d, i) => {
        return { ...d, id: d.id + '_' + i, projectName: d.projectName + i };
      })
    };
    nextTick(() => {
      contractRef.value && contractRef.value.print();
    });
  };

  /* 打印pdf */
  const onPrintPdf = () => {
    const loading = EleMessage.loading({
      message: '正在加载中..',
      mask: true,
      centered: true
    });
    printPdf({
      url: 'https://cdn.eleadmin.com/20200610/20200708224450.pdf',
      done: () => {
        loading.close();
      }
    });
  };
</script>

<script>
  export default {
    name: 'ExtensionPrinter'
  };
</script>
