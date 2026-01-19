<template>
  <div class="login-container">
    <el-card class="login-card">
      <template #header>
        <div class="card-header">
          <h2>{{ isLogin ? 'Login' : 'Register' }}</h2>
        </div>
      </template>
      
      <el-form :model="form" label-width="80px" v-if="isLogin">
        <el-form-item label="Username">
          <el-input v-model="form.username" />
        </el-form-item>
        <el-form-item label="Password">
          <el-input v-model="form.password" type="password" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleLogin" :loading="loading" style="width: 100%">Login</el-button>
        </el-form-item>
        <div class="actions">
          <el-button link @click="isLogin = false">No account? Register</el-button>
        </div>
      </el-form>

      <el-form :model="registerForm" label-width="80px" v-else>
        <el-form-item label="Username">
          <el-input v-model="registerForm.username" />
        </el-form-item>
        <el-form-item label="Password">
          <el-input v-model="registerForm.password" type="password" />
        </el-form-item>
        <el-form-item label="Name">
          <el-input v-model="registerForm.name" />
        </el-form-item>
        <el-form-item label="Phone">
          <el-input v-model="registerForm.phone" />
        </el-form-item>
        <el-form-item label="Code">
          <div class="code-container">
            <el-input v-model="registerForm.code" style="width: 120px" />
            <el-button 
              type="primary" 
              :disabled="countdown > 0" 
              @click="handleGetCode"
            >
              {{ countdown > 0 ? `${countdown}s` : 'Get Code' }}
            </el-button>
          </div>
        </el-form-item>
        <el-form-item label="College">
          <el-input v-model="registerForm.college" />
        </el-form-item>
        <el-form-item label="Major">
          <el-input v-model="registerForm.major" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRegister" :loading="loading" style="width: 100%">Register</el-button>
        </el-form-item>
        <div class="actions">
          <el-button link @click="isLogin = true">Back to Login</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import request from '../utils/request'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()
const loading = ref(false)
const isLogin = ref(true)
const countdown = ref(0)

const form = ref({
  username: '',
  password: ''
})

const registerForm = ref({
  username: '',
  password: '',
  name: '',
  phone: '',
  email: '', // Optional in UI for now, reusing phone logic
  code: '',
  college: '',
  major: ''
})

const handleLogin = async () => {
  loading.value = true
  try {
    const res: any = await request.post('/auth/login', form.value)
    userStore.setToken(res.token)
    userStore.setUserInfo(res.user)
    ElMessage.success('Login success')
    router.push('/')
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}

const handleGetCode = async () => {
  if (!registerForm.value.phone) {
    ElMessage.warning('Please enter phone number')
    return
  }
  try {
    const res: any = await request.get('/auth/code', { params: { target: registerForm.value.phone } })
    ElMessage.success(`Code sent: ${res.code}`) // Display code for testing
    countdown.value = 60
    const timer = setInterval(() => {
      countdown.value--
      if (countdown.value <= 0) {
        clearInterval(timer)
      }
    }, 1000)
  } catch (error) {
    console.error(error)
  }
}

const handleRegister = async () => {
  loading.value = true
  try {
    await request.post('/auth/register', registerForm.value)
    ElMessage.success('Register success, please login')
    isLogin.value = true
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f0f2f5;
}
.login-card {
  width: 400px;
}
.card-header {
  text-align: center;
}
.actions {
  text-align: right;
  margin-top: 10px;
}
.code-container {
  display: flex;
  gap: 10px;
}
</style>
