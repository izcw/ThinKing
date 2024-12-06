import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useEditorPageStore = defineStore('useEditorPageStore', () => {
    // 笔记设置
    const setting = ref({
        limit: 100000, // 允许的最大字符数
        history: 20, // 允许最大的撤销数量
    });

    // 编辑器实例
    const editor = ref({});

    // 笔记内容
    const content = ref({
        "type": "doc",
        "content": [
            {
                "type": "heading",
                "attrs": {
                    "id": "9402c6fa-0a6e-47b6-a2ef-f765fe480ba0",
                    "data-toc-id": "9402c6fa-0a6e-47b6-a2ef-f765fe480ba0",
                    "level": 1
                },
                "content": [
                    {
                        "type": "text",
                        "text": "欢迎使用ThinKing🎈"
                    }
                ]
            },
            {
                "type": "paragraph",
                "content": [
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(6, 6, 7)"
                                }
                            }
                        ],
                        "text": "ThinKing 是一个"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(6, 6, 7)"
                                }
                            },
                            {
                                "type": "highlight",
                                "attrs": {
                                    "color": "#BBDEFB"
                                }
                            }
                        ],
                        "text": "创新"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(6, 6, 7)"
                                }
                            }
                        ],
                        "text": "的在线笔记应用"
                    },
                    {
                        "type": "text",
                        "text": "，"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(6, 6, 7)"
                                }
                            }
                        ],
                        "text": "旨在帮助用户以更高效、更有组织的方式记录和管理他们的想法、笔记和任务。无论您是一名学生、专业人士还是自由职业者，"
                    },
                    {
                        "type": "text",
                        "text": "ThinKing 都能为您提供一个"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(67, 160, 71)"
                                }
                            }
                        ],
                        "text": "灵活且功能强大的平台，以支持您的日常笔记需求"
                    },
                    {
                        "type": "text",
                        "text": "。"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "46be5aa6-0eba-4661-a07c-2a71f7f5b3ec",
                    "data-toc-id": "46be5aa6-0eba-4661-a07c-2a71f7f5b3ec",
                    "level": 4
                },
                "content": [
                    {
                        "type": "text",
                        "text": "高效记录，"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "highlight",
                                "attrs": {
                                    "color": "#F8BBD0"
                                }
                            }
                        ],
                        "text": "灵感不丢失"
                    }
                ]
            },
            {
                "type": "paragraph",
                "content": [
                    {
                        "type": "text",
                        "text": "在快节奏的现代生活中，"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(233, 30, 99)"
                                }
                            }
                        ],
                        "text": "灵感和想法"
                    },
                    {
                        "type": "text",
                        "text": "常常在一瞬间涌现。ThinKing 提供了一个快速记录的环境，让用户能够随时随地捕捉这些宝贵的想法。无论是会议中的灵感、学习时的笔记，还是日常生活中的待办事项，ThinKing 都能确保您的每一个想法都被妥善保存。"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "1a28ad93-fb58-415e-9dae-ba2d22820491",
                    "data-toc-id": "1a28ad93-fb58-415e-9dae-ba2d22820491",
                    "level": 4
                },
                "content": [
                    {
                        "type": "text",
                        "text": "有组织的管理，"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "highlight",
                                "attrs": {
                                    "color": "#BBDEFB"
                                }
                            }
                        ],
                        "text": "轻松检索"
                    }
                ]
            },
            {
                "type": "paragraph",
                "content": [
                    {
                        "type": "text",
                        "text": "ThinKing 的核心优势在于其强大的组织和管理功能。用户可以通过创建不同的空间来对笔记进行分类，例如工作、学习、个人等。每个空间都可以包含"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(255, 160, 0)"
                                }
                            }
                        ],
                        "text": "无限数量的笔记"
                    },
                    {
                        "type": "text",
                        "text": "，而每篇笔记都可以通过标签进行进一步的细分和标记。这种灵活的组织方式使得用户能够轻松地管理和检索他们的笔记，即使是在拥有大量笔记的情况下。"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "4e20f7c8-c8e1-4800-ad34-5625b4ace296",
                    "data-toc-id": "4e20f7c8-c8e1-4800-ad34-5625b4ace296",
                    "level": 4
                },
                "content": [
                    {
                        "type": "text",
                        "text": "多功能笔记，"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "highlight",
                                "attrs": {
                                    "color": "#FFAB91"
                                }
                            }
                        ],
                        "text": "满足多样化需求"
                    }
                ]
            },
            {
                "type": "paragraph",
                "content": [
                    {
                        "type": "text",
                        "text": "ThinKing 支持多种笔记类型，包括但不限于文本、图片、链接和代码片段。用户可以根据自己的需求选择最适合的笔记格式。例如，学生可以使用文本和图片笔记来记录课堂内容，开发者可以使用代码片段笔记来保存重要的代码示例。这种多功能性确保了 ThinKing 能够满足不同用户群体的"
                    },
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "textStyle",
                                "attrs": {
                                    "color": "rgb(81, 45, 168)"
                                }
                            }
                        ],
                        "text": "多样化需求"
                    },
                    {
                        "type": "text",
                        "text": "。"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "8deccccc-8e14-4640-9ddb-041661409f62",
                    "data-toc-id": "8deccccc-8e14-4640-9ddb-041661409f62",
                    "level": 1
                },
                "content": [
                    {
                        "type": "text",
                        "text": "支持以下格式"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "1881c0db-1fdf-491e-8f39-df38c10ef958",
                    "data-toc-id": "1881c0db-1fdf-491e-8f39-df38c10ef958",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "89e823f8-c85c-4dac-b814-4ea8d398c0f0",
                    "data-toc-id": "89e823f8-c85c-4dac-b814-4ea8d398c0f0",
                    "level": 1
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题一"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "47859c05-b893-468e-b3c7-d2a24d0d8a84",
                    "data-toc-id": "47859c05-b893-468e-b3c7-d2a24d0d8a84",
                    "level": 2
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题二"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "685af503-3bc1-4926-9bb1-7d32122c2396",
                    "data-toc-id": "685af503-3bc1-4926-9bb1-7d32122c2396",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题三"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "e4e71418-50fd-4f15-8808-42e3af5f267e",
                    "data-toc-id": "e4e71418-50fd-4f15-8808-42e3af5f267e",
                    "level": 4
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题四"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "2f37247b-b79a-4f8d-80f3-81bb6ab13451",
                    "data-toc-id": "2f37247b-b79a-4f8d-80f3-81bb6ab13451",
                    "level": 4
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题五"
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "f024f6f6-8f95-4c3e-93c4-7159de4ee7d0",
                    "data-toc-id": "f024f6f6-8f95-4c3e-93c4-7159de4ee7d0",
                    "level": 6
                },
                "content": [
                    {
                        "type": "text",
                        "text": "标题六"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "405cac26-cfed-4fd5-a91e-0d898aa98806",
                    "data-toc-id": "405cac26-cfed-4fd5-a91e-0d898aa98806",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "表格"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "table",
                "content": [
                    {
                        "type": "tableRow",
                        "content": [
                            {
                                "type": "tableHeader",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "姓名"
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "tableHeader",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "年龄"
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "tableHeader",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "性别"
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "tableRow",
                        "content": [
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "张三"
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "李四"
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph",
                                        "content": [
                                            {
                                                "type": "text",
                                                "text": "男"
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "tableRow",
                        "content": [
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph"
                                    }
                                ]
                            },
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph"
                                    }
                                ]
                            },
                            {
                                "type": "tableCell",
                                "attrs": {
                                    "colspan": 1,
                                    "rowspan": 1,
                                    "colwidth": null
                                },
                                "content": [
                                    {
                                        "type": "paragraph"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "ab0b009a-e000-47c1-8eaf-211b7b38f77b",
                    "data-toc-id": "ab0b009a-e000-47c1-8eaf-211b7b38f77b",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "清单"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "taskList",
                "content": [
                    {
                        "type": "taskItem",
                        "attrs": {
                            "checked": true
                        },
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "阅读10本书"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "taskItem",
                        "attrs": {
                            "checked": false
                        },
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "12点前睡"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "taskItem",
                        "attrs": {
                            "checked": false
                        },
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "完成毕业设计"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "328fcf06-e73b-46a5-a43c-f04d61a2a5a7",
                    "data-toc-id": "328fcf06-e73b-46a5-a43c-f04d61a2a5a7",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "列表"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "bulletList",
                "content": [
                    {
                        "type": "listItem",
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "无序列表"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "listItem",
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "无序列表"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "type": "orderedList",
                "attrs": {
                    "start": 1
                },
                "content": [
                    {
                        "type": "listItem",
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "有序列表"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "type": "listItem",
                        "content": [
                            {
                                "type": "paragraph",
                                "content": [
                                    {
                                        "type": "text",
                                        "text": "有序列表"
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "97bb0b39-e480-4de9-bc3c-1d3aebc70b56",
                    "data-toc-id": "97bb0b39-e480-4de9-bc3c-1d3aebc70b56",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "代码"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "codeBlock",
                "attrs": {
                    "language": null
                },
                "content": [
                    {
                        "type": "text",
                        "text": "export async function addSpace(data) {\n    const res = await service.post('/note/space/add', data);\n    if (res.code === 200) {\n        return res.data;\n    }\n    return Promise.reject(new Error(res.message));\n}"
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "3fce4cfd-3686-4026-acac-50487336d682",
                    "data-toc-id": "3fce4cfd-3686-4026-acac-50487336d682",
                    "level": 3
                },
                "content": [
                    {
                        "type": "text",
                        "text": "引用"
                    }
                ]
            },
            {
                "type": "horizontalRule"
            },
            {
                "type": "blockquote",
                "content": [
                    {
                        "type": "paragraph",
                        "content": [
                            {
                                "type": "text",
                                "text": "这是一个引用"
                            }
                        ]
                    },
                    {
                        "type": "paragraph",
                        "content": [
                            {
                                "type": "text",
                                "text": "哈哈哈"
                            }
                        ]
                    }
                ]
            },
            {
                "type": "heading",
                "attrs": {
                    "id": "382d172d-46de-4ded-aa15-52eb21ba18fe",
                    "data-toc-id": "382d172d-46de-4ded-aa15-52eb21ba18fe",
                    "level": 3
                }
            },
            {
                "type": "paragraph",
                "content": [
                    {
                        "type": "text",
                        "marks": [
                            {
                                "type": "highlight",
                                "attrs": {
                                    "color": "#D1C4E9"
                                }
                            }
                        ],
                        "text": "等等还有许多功能开发中..."
                    }
                ]
            },
            {
                "type": "paragraph"
            },
            {
                "type": "paragraph"
            }
        ]
    });

    // 目录
    const catalog = ref([]);
    // 目录转换的树形结构
    const treeData = ref([]);

    return {
        setting,
        editor,
        content,
        catalog,
        treeData
    };
});