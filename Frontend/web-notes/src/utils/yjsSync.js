// yjsSync.js
import * as Y from 'yjs'
import { IndexeddbPersistence } from 'y-indexeddb'

// 创建 Yjs 文档实例
export function createYDoc() {
  return new Y.Doc()
}

// 初始化本地存储和同步
export function initYjsStore(doc, store) {
  const provider = new IndexeddbPersistence('ThinKing-Document', doc)

  provider.on('synced', () => {
    console.log('Yjs 数据同步完成')
  })

  const yText = doc.getText('content')  // 获取共享的文本对象

  // 在本地编辑时更新 Yjs 数据
  store.$subscribe(() => {
    if (store.content !== yText.toString()) {
      yText.delete(0, yText.length)  // 清空旧数据
      yText.insert(0, store.content)  // 插入新数据
    }
  })

  // 从 Yjs 获取同步的数据
  yText.observe(event => {
    store.content = yText.toString()  // 更新 store 中的内容
  })

  return provider
}

// 从服务器获取并同步数据
export async function fetchServerData() {
  try {
    const response = await fetch('/api/getDocument')
    if (response.ok) {
      return await response.json()
    }
    throw new Error('Failed to fetch server data')
  } catch (error) {
    console.error(error)
  }
}

// 上传数据到服务器
export async function updateServerData(content) {
  try {
    const response = await fetch('/api/updateDocument', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ content })
    })

    if (!response.ok) {
      throw new Error('Failed to update server data')
    }

    console.log('数据已成功同步到服务器')
  } catch (error) {
    console.error('同步数据时出错：', error)
  }
}
  