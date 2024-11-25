<template>
    <footer>
        <div class="more">
            <el-row :gutter="20">
                <el-col :xs="24" :md="6">
                    <div class="logo">
                        <img src="@/assets/images/logo-grey.png" alt="">
                        <p>广西农业职业技术大学</p>
                        <p>信息工程学院</p>
                        <p>计算机应用工程（专升本）</p>
                    </div>
                </el-col>
                <el-col :xs="24" :md="18">
                    <div class="link">
                        <ul>
                            <li>产品</li>
                            <li><router-link to="/login">NexNote主页</router-link></li>
                            <li><router-link to="/login">登录</router-link></li>
                            <li><router-link to="/login">注册</router-link></li>
                        </ul>
                        <ul>
                            <li>帮助和支持</li>
                            <li><router-link to="/login">帮助中心</router-link></li>
                            <li><router-link to="/login">更新日志</router-link></li>
                            <li><router-link to="/login">问题反馈</router-link></li>
                            <li><router-link to="/login">常见问题</router-link></li>
                        </ul>
                        <ul>
                            <li>NexNote</li>
                            <li><router-link to="/login">关于NexNote</router-link></li>
                            <li><router-link to="/login">NexNote故事</router-link></li>
                            <li><router-link to="/login">联系我们</router-link></li>
                        </ul>
                    </div>
                </el-col>
            </el-row>
        </div>
        <div class="info">
            <el-row :gutter="20">
                <el-col :sm="24" :md="8">
                    <a href="">开发者：©2024 张成威 2331020120242</a>
                </el-col>
                <el-col :sm="24" :md="8">
                    <a href="">桂公网安备 45098102000465号桂公网安备 45098102000465号</a>
                </el-col>
                <el-col :sm="24" :md="8">
                    <a href="">桂ICP备2022009640号-1</a>
                </el-col>
            </el-row>
        </div>
    </footer>
</template>
<script setup>

</script>
<style scoped lang='scss'>
footer {
    border-top: 1px solid #eee;
    margin-top: 60px;

    .more {
        padding: 30px 0;

        .logo {
            p {
                font-size: 12px;
                color: #999;
                padding: 6px 0;
            }

            img {
                width: 40px;
            }
        }

        .link {
            width: 100%;
            display: flex;
            justify-content: flex-end;

            ul {
                margin-left: 100px;

                li {
                    list-style-type: none;
                    padding-bottom: 6px;

                    a {
                        font-size: 12px;
                        color: #666;
                    }
                }
            }
        }


    }

    .info {
        width: 100%;
        border-top: 1px solid #eee;
        padding: 1.5rem 0;

        a,
        p {
            font-size: 12px;
            color: #999;
        }
    }
}

@media (max-width: 992px) {
    .logo {
        margin-bottom: 30px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .link {
        justify-content: center !important;

        ul {
            padding: 0 1rem;
            margin: 0 !important;
        }
    }
}
</style>
