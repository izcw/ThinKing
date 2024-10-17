<template>
    <div class="layout">
        <div class="main-layout">
            <n-split direction="horizontal" max="550px" min="220px" default-size="270px">
                <template #1>
                    <div class="sidebar">
                        <!-- 顶部导航栏 -->
                        <Header />
                        <!-- 侧边栏 -->
                        <Sidebar />
                    </div>
                </template>
                <template #2>
                    <!-- 内容区域 -->
                    <main class="content">
                        <MainContent />
                    </main>
                </template>
            </n-split>



        </div>
    </div>
</template>

<script setup>
import Header from './components/Header.vue';
import Sidebar from './components/Sidebar.vue';
import MainContent from './components/MainContent.vue';
</script>

<style scoped>
.layout {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100vh;
}

.main-layout {
    display: flex;
    flex: 1;
    width: 100%;
    height: 100%;
}


.sidebar {
    width: 100%;
    height: 100%;
    background-color: #F7F7F5;
    padding: 1rem;
    box-sizing: border-box
}

.content {
    flex: 1;
    padding: 20px;
    background-color: #fff;
    overflow-y: auto;
    width: 100%;
    height: 100%;
}
</style>