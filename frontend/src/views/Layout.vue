<template>
  <el-container class="layout-container">
    <el-header class="header">
      <div class="logo">Graduation Platform</div>
      <div class="user-info">
        <span>{{ userStore.userInfo.name }} ({{ userStore.userInfo.role }})</span>
        <el-button type="text" @click="handleLogout">Logout</el-button>
      </div>
    </el-header>
    <el-container>
      <el-aside width="200px">
        <el-menu router :default-active="$route.path">
          <el-menu-item index="/">Home</el-menu-item>
          <el-menu-item index="/documents">Documents</el-menu-item>
          <el-menu-item index="/questions">Q&A</el-menu-item>
          <el-menu-item index="/evaluation">Evaluation</el-menu-item>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup lang="ts">
import { useUserStore } from '../stores/user'
import { useRouter } from 'vue-router'

const userStore = useUserStore()
const router = useRouter()

const handleLogout = () => {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.layout-container {
  height: 100vh;
}
.header {
  background-color: #409EFF;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.logo {
  font-size: 20px;
  font-weight: bold;
}
.user-info {
  display: flex;
  gap: 10px;
  align-items: center;
}
.user-info .el-button {
  color: white;
}
</style>
