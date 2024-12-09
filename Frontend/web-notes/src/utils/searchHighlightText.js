export function highlightText(val) {
    // 获取搜索框中的内容
    const searchQuery = val;
    // 获取编辑器区域的所有文本内容
    const editorBox = document.querySelector('.ThinKing-Editor-Box');
    const paragraphs = editorBox.getElementsByTagName('p');

    // 清除之前的高亮
    for (let p of paragraphs) {
        p.innerHTML = p.textContent;
    }

    // 如果没有搜索内容，则直接返回
    if (!searchQuery) return;

    // 正则表达式，用于匹配搜索内容
    const regex = new RegExp(`(${searchQuery})`, 'gi');

    // 遍历每个段落进行高亮处理
    for (let p of paragraphs) {
        // 获取段落的原始文本
        const originalText = p.textContent;
        // 替换匹配的部分并使用 <mark> 标签包裹高亮
        p.innerHTML = originalText.replace(regex, '<mark>$1</mark>');
    }
}