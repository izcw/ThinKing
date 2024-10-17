<template>
  <ele-card header="导入 Excel">
    <!-- 操作按钮 -->
    <el-space>
      <el-upload
        action=""
        accept=".xls,.xlsx"
        :show-upload-list="false"
        :before-upload="importFile"
      >
        <el-button type="primary" class="ele-btn-icon">导入</el-button>
      </el-upload>
      <el-upload
        action=""
        accept=".xls,.xlsx"
        :show-upload-list="false"
        :before-upload="importFile2"
      >
        <el-button type="primary" class="ele-btn-icon">
          导入拆分合并
        </el-button>
      </el-upload>
      <el-upload
        action=""
        accept=".xls,.xlsx"
        :show-upload-list="false"
        :before-upload="importFile3"
      >
        <el-button type="primary" class="ele-btn-icon">
          导入保持合并
        </el-button>
      </el-upload>
    </el-space>
    <div style="overflow: auto">
      <ele-table :border="true" style="min-width: max-content">
        <thead>
          <tr>
            <th></th>
            <th
              v-for="item in importTitle"
              :key="item"
              style="text-align: center"
            >
              {{ item }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in importData" :key="index">
            <td style="text-align: center">{{ index + 1 }}</td>
            <template v-for="key in importTitle">
              <td
                v-if="
                  item['colspan' + key] !== 0 && item['rowspan' + key] !== 0
                "
                :key="key"
                :colspan="item['colspan' + key]"
                :rowspan="item['rowspan' + key]"
                style="text-align: center"
              >
                {{ item[key] }}
              </td>
            </template>
          </tr>
        </tbody>
      </ele-table>
    </div>
    <el-row :gutter="32">
      <el-col :sm="12" :xs="24">
        <div style="margin: 16px 0">二维数组格式数据:</div>
        <pre style="max-height: 300px; padding: 16px; overflow: auto">{{
          JSON.stringify(importDataAoa, null, 4)
        }}</pre>
      </el-col>
      <el-col :sm="12" :xs="24">
        <div style="margin: 16px 0">JSON格式数据:</div>
        <pre style="max-height: 300px; padding: 16px; overflow: auto">{{
          JSON.stringify(importData, null, 4)
        }}</pre>
      </el-col>
    </el-row>
  </ele-card>
</template>

<script setup>
  import { ref } from 'vue';
  import { utils, read } from 'xlsx';
  import { EleMessage } from 'ele-admin-plus/es';

  // 导入数据的列
  const importTitle = ref(['A', 'B', 'C', 'D', 'E', 'F', 'G']);

  // 导入的数据
  const importData = ref([]);

  // 导入数据二维数组形式
  const importDataAoa = ref([]);

  /* 导入本地excel文件 */
  const importFile = (file) => {
    if (
      ![
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      ].includes(file.type)
    ) {
      EleMessage.error('只能选择 excel 文件');
      return false;
    }
    if (file.size / 1024 / 1024 > 20) {
      EleMessage.error('大小不能超过 20MB');
      return false;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
      const data = new Uint8Array(e.target?.result);
      const workbook = read(data, { type: 'array' });
      const sheetNames = workbook.SheetNames;
      const worksheet = workbook.Sheets[sheetNames[0]];
      // 解析成二维数组
      const aoa = utils.sheet_to_json(worksheet, { header: 1 });
      // 生成表格需要的数据
      const list = [];
      const title = [];
      let maxCols = 0;
      aoa.forEach((d) => {
        if (d.length > maxCols) {
          maxCols = d.length;
        }
        const row = {};
        for (let i = 0; i < d.length; i++) {
          const key = getCharByIndex(i);
          row[key] = d[i];
          row['colspan' + key] = 1;
          row['rowspan' + key] = 1;
        }
        list.push(row);
      });
      for (let i = 0; i < maxCols; i++) {
        title.push(getCharByIndex(i));
      }
      importTitle.value = title;
      importData.value = list;
      importDataAoa.value = aoa;
    };
    reader.readAsArrayBuffer(file);
    return false;
  };

  /* 导入excel拆分合并单元格 */
  const importFile2 = (file) => {
    if (
      ![
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      ].includes(file.type)
    ) {
      EleMessage.error('只能选择 excel 文件');
      return false;
    }
    if (file.size / 1024 / 1024 > 20) {
      EleMessage.error('大小不能超过 20MB');
      return false;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
      const data = new Uint8Array(e.target?.result);
      const workbook = read(data, { type: 'array' });
      const sheetNames = workbook.SheetNames;
      const worksheet = workbook.Sheets[sheetNames[0]];
      // 解析成二维数组
      const aoa = utils.sheet_to_json(worksheet, { header: 1 });
      // 拆分合并单元格
      if (worksheet['!merges']) {
        worksheet['!merges'].forEach((m) => {
          for (let r = m.s.r; r <= m.e.r; r++) {
            for (let c = m.s.c; c <= m.e.c; c++) {
              aoa[r][c] = aoa[m.s.r][m.s.c];
            }
          }
        });
      }
      // 生成表格需要的数据
      const list = [];
      const title = [];
      let maxCols = 0;
      aoa.forEach((d) => {
        if (d.length > maxCols) {
          maxCols = d.length;
        }
        const row = {};
        for (let i = 0; i < d.length; i++) {
          row[getCharByIndex(i)] = d[i];
        }
        list.push(row);
      });
      for (let i = 0; i < maxCols; i++) {
        title.push(getCharByIndex(i));
      }
      importTitle.value = title;
      importData.value = list;
      importDataAoa.value = aoa;
    };
    reader.readAsArrayBuffer(file);
    return false;
  };

  /* 导入 excel 读取合并信息 */
  const importFile3 = (file) => {
    if (
      ![
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      ].includes(file.type)
    ) {
      EleMessage.error('只能选择 excel 文件');
      return false;
    }
    if (file.size / 1024 / 1024 > 20) {
      EleMessage.error('大小不能超过 20MB');
      return false;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
      const data = new Uint8Array(e.target?.result);
      const workbook = read(data, { type: 'array' });
      const sheetNames = workbook.SheetNames;
      const worksheet = workbook.Sheets[sheetNames[0]];
      // 解析成二维数组
      const aoa = utils.sheet_to_json(worksheet, { header: 1 });
      // 生成表格需要的数据
      const list = [];
      const title = [];
      let maxCols = 0;
      aoa.forEach((d) => {
        if (d.length > maxCols) {
          maxCols = d.length;
        }
        const row = {};
        for (let i = 0; i < d.length; i++) {
          row[getCharByIndex(i)] = d[i];
        }
        list.push(row);
      });
      for (let i = 0; i < maxCols; i++) {
        title.push(getCharByIndex(i));
      }
      // 记录合并单元格
      if (worksheet['!merges']) {
        worksheet['!merges'].forEach((m) => {
          for (let r = m.s.r; r <= m.e.r; r++) {
            for (let c = m.s.c; c <= m.e.c; c++) {
              const cc = getCharByIndex(c);
              list[r]['colspan' + cc] = 0;
              list[r]['rowspan' + cc] = 0;
            }
          }
          const char = getCharByIndex(m.s.c);
          list[m.s.r]['colspan' + char] = m.e.c - m.s.c + 1;
          list[m.s.r]['rowspan' + char] = m.e.r - m.s.r + 1;
        });
      }
      importTitle.value = title;
      importData.value = list;
      importDataAoa.value = aoa;
    };
    reader.readAsArrayBuffer(file);
    return false;
  };

  /* 生成Excel列字母序号 */
  const getCharByIndex = (index) => {
    const chars = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    if (index < chars.length) {
      return chars[index];
    }
    const n = parseInt(String(index / chars.length));
    const m = index % chars.length;
    return chars[n] + chars[m];
  };
</script>
