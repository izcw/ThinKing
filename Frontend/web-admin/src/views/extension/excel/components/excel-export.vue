<template>
  <ele-card header="导出 Excel">
    <!-- 表格 -->
    <ele-pro-table
      row-key="key"
      :columns="columns"
      :datasource="data"
      :pagination="false"
      v-model:selections="selections"
      :tools="['size', 'columns', 'maximized']"
      :toolbar="{ theme: 'default' }"
      :border="true"
    >
      <template #toolbar>
        <el-space>
          <el-button type="primary" class="ele-btn-icon" @click="exportBas">
            导出
          </el-button>
          <el-button type="primary" class="ele-btn-icon" @click="exportAdv">
            导出带表头合并
          </el-button>
          <el-button type="primary" class="ele-btn-icon" @click="exportSel">
            导出选中
          </el-button>
        </el-space>
      </template>
    </ele-pro-table>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { utils, writeFile } from 'xlsx';
  import { EleMessage } from 'ele-admin-plus/es';

  // 表格数据
  const data = ref([
    {
      key: 1,
      username: '张小三',
      amount: 18,
      province: '浙江',
      city: '杭州',
      zone: '西湖区',
      street: '西溪街道',
      address: '西溪花园30栋1单元'
    },
    {
      key: 2,
      username: '李小四',
      amount: 39,
      province: '江苏',
      city: '苏州',
      zone: '姑苏区',
      street: '丝绸路',
      address: '天墅之城9幢2单元'
    },
    {
      key: 3,
      username: '王小五',
      amount: 8,
      province: '江西',
      city: '南昌',
      zone: '青山湖区',
      street: '艾溪湖办事处',
      address: '中兴和园1幢3单元'
    },
    {
      key: 4,
      username: '赵小六',
      amount: 16,
      province: '福建',
      city: '泉州',
      zone: '丰泽区',
      street: '南洋街道',
      address: '南洋村6幢1单元'
    },
    {
      key: 5,
      username: '孙小七',
      amount: 12,
      province: '湖北',
      city: '武汉',
      zone: '武昌区',
      street: '武昌大道',
      address: '两湖花园16幢2单元'
    },
    {
      key: 6,
      username: '周小八',
      amount: 11,
      province: '安徽',
      city: '黄山',
      zone: '黄山区',
      street: '汤口镇',
      address: '温泉村21号'
    }
  ]);

  // 表格列配置
  const columns = ref([
    {
      type: 'selection',
      columnKey: 'selection',
      width: 48,
      align: 'center'
    },
    {
      type: 'index',
      columnKey: 'index',
      width: 48,
      align: 'center',
      showOverflowTooltip: true
    },
    {
      prop: 'username',
      label: '用户名',
      align: 'center'
    },
    {
      columnKey: 'cityAddress',
      label: '地址',
      align: 'center',
      children: [
        {
          prop: 'province',
          label: '省',
          align: 'center'
        },
        {
          prop: 'city',
          label: '市',
          align: 'center'
        },
        {
          prop: 'zone',
          label: '区',
          align: 'center'
        },
        {
          prop: 'street',
          label: '街道',
          align: 'center'
        },
        {
          prop: 'address',
          label: '详细地址',
          align: 'center'
        }
      ]
    },
    {
      prop: 'amount',
      label: '金额',
      align: 'center'
    }
  ]);

  // 选中数据
  const selections = ref([]);

  /* 导出excel */
  const exportBas = () => {
    const array = [['用户名', '省', '市', '区', '街道', '详细地址', '金额']];
    data.value.forEach((d) => {
      array.push([
        d.username,
        d.province,
        d.city,
        d.zone,
        d.street,
        d.address,
        d.amount
      ]);
    });
    const sheetName = 'Sheet1';
    const workbook = {
      SheetNames: [sheetName],
      Sheets: {}
    };
    const sheet = utils.aoa_to_sheet(array);
    workbook.Sheets[sheetName] = sheet;
    // 设置列宽
    sheet['!cols'] = [
      { wch: 10 },
      { wch: 10 },
      { wch: 10 },
      { wch: 10 },
      { wch: 20 },
      { wch: 40 },
      { wch: 10 }
    ];
    writeFile(workbook, '用户数据.xlsx');
  };

  /* 导出带单元格合并 */
  const exportAdv = () => {
    const array = [
      ['用户名', '地址', null, null, null, null, '金额'],
      [null, '省', '市', '区', '街道', '详细地址', null]
    ];
    data.value.forEach((d) => {
      array.push([
        d.username,
        d.province,
        d.city,
        d.zone,
        d.street,
        d.address,
        d.amount
      ]);
    });
    const sheet = utils.aoa_to_sheet(array);
    sheet['!merges'] = [
      { s: { r: 0, c: 1 }, e: { r: 0, c: 5 } }, // 合并第 0 行第 1 列到第 0 行第5列
      { s: { r: 0, c: 1 }, e: { r: 0, c: 5 } }, // 合并第 0 行第 1 列到第 0 行第 5 列
      { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } }, // 合并第 0 行第 0 列到第 1 行第 0 列
      { s: { r: 0, c: 6 }, e: { r: 1, c: 6 } } // 合并第 0 行第 6 列到第 1 行第 6 列
    ];
    const sheetName = 'Sheet1';
    const workbook = {
      SheetNames: [sheetName],
      Sheets: {}
    };
    workbook.Sheets[sheetName] = sheet;
    writeFile(workbook, '用户数据.xlsx');
  };

  /* 导出选中数据 */
  const exportSel = () => {
    if (selections.value.length === 0) {
      EleMessage.error('请至少选择一条数据');
      return;
    }
    const array = [['用户名', '省', '市', '区', '街道', '详细地址', '金额']];
    selections.value.forEach((d) => {
      array.push([
        d.username,
        d.province,
        d.city,
        d.zone,
        d.street,
        d.address,
        d.amount
      ]);
    });
    const sheetName = 'Sheet1';
    const workbook = {
      SheetNames: [sheetName],
      Sheets: {}
    };
    workbook.Sheets[sheetName] = utils.aoa_to_sheet(array);
    writeFile(workbook, '用户数据.xlsx');
  };
</script>
