<template>
    <h2>NexNote ｜ 注册</h2>
    <el-form ref="ruleFormRef" class="input-box" :model="ruleForm" :rules="rules" label-width="auto" inline-message>
        <!-- 邮箱输入项 -->
        <el-form-item prop="email" class="item" v-if="!nextCorrect">
            <el-input type="email" v-model="ruleForm.email" size="large" placeholder="请输入邮箱" clearable />
        </el-form-item>

        <!-- 密码输入项 -->
        <el-form-item prop="password" class="item" v-if="nextCorrect">
            <el-input type="password" show-password v-model="ruleForm.password" size="large" placeholder="请输入密码" />
        </el-form-item>

        <!-- 确认密码输入项 -->
        <el-form-item prop="passwordrepeat" class="item" v-if="nextCorrect">
            <el-input type="password" show-password v-model="ruleForm.passwordrepeat" size="large"
                placeholder="请再次输入密码" />
        </el-form-item>

        <!-- 验证码输入项 -->
        <el-form-item prop="code" class="item" v-if="!nextCorrect">
            <div class="Verification">
                <el-input v-model="ruleForm.code" minlength="6" maxlength="6" size="large" placeholder="验证码"
                    clearable />
                <el-button class="code" type="primary" plain size="large" :disabled="countdown > 0" @click="EmailCode">
                    {{ countdown > 0 ? `${countdown}s` : '获取验证码' }}
                </el-button>
            </div>
        </el-form-item>

        <!-- 提交按钮 -->
        <el-form-item>
            <el-button class="item submit" color="#000" size="large" v-if="!nextCorrect"
                :disabled="!isValidCode || !isValidEmail" @click="nextSubmitForm">下一步</el-button>
            <el-button class="item submit" color="#000" size="large" v-else @click="submitForm">注册</el-button>
        </el-form-item>

        <!-- 其他操作 -->
        <div class="otherMethods">
            <p @click="previousStep" v-if="nextCorrect">上一步</p>
            <div>
                <router-link to="/login">已有账号！立即登录</router-link>
            </div>
        </div>
    </el-form>
</template>

<script setup>
import { reactive, ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { getEmailCode, postVerifyEmailCode, postRegister } from '@/api/login'
import { debounce } from 'lodash'
import { ElMessage } from 'element-plus'

const router = useRouter()
let nextCorrect = ref(false) // 填入邮箱和验证码，可以下一步

// 回退上一步
let previousStep = () => {
    nextCorrect.value = false
}

// 表单数据与验证规则
const ruleFormRef = ref()
const ruleForm = reactive({
    email: '',
    password: '',
    passwordrepeat: '',
    code: ''
})

// 倒计时相关
let countdown = ref(0) // 倒计时

// 验证码是否有效（6位数字）
let isValidCode = computed(() => /^\d{6}$/.test(ruleForm.code))
// 验证邮箱格式的正则
const emailRegEx = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

// 邮箱格式是否有效
let isValidEmail = computed(() => emailRegEx.test(ruleForm.email))


// 获取验证码，防抖处理
const EmailCode = debounce(() => {
    if (!isValidEmail.value) {
        ElMessage.warning('请输入有效的邮箱')
        return
    }

    getEmailCode({ email: ruleForm.email })
        .then((msg) => {
            ElMessage.success(msg.message)
            startCountdown()
        })
        .catch(() => {
            ElMessage.error('获取验证码失败')
        })
}, 500)

// 启动倒计时
const startCountdown = () => {
    countdown.value = 60
    const timer = setInterval(() => {
        if (countdown.value <= 0) {
            clearInterval(timer)
        } else {
            countdown.value--
        }
    }, 1000)
}

// 验证邮箱和验证码
const nextSubmitForm = () => {
    const { email, code } = ruleForm
    postVerifyEmailCode({ email, code })
        .then((msg) => {
            if (msg.code == 200) {
                nextCorrect.value = true
            } else {
                ElMessage.warning(msg.message)
            }
        })
        .catch(() => {
            ElMessage.error('验证码错误，请重新获取')
        })
}

// 提交表单，注册用户
const submitForm = async () => {
    // 密码不能为空的检查
    if (!ruleForm.password || !ruleForm.passwordrepeat) {
        ElMessage.warning("密码不能为空，请填写密码！")
        return
    }

    // 密码长度检查（6到30位）
    if (ruleForm.password.length < 6 || ruleForm.password.length > 30) {
        ElMessage.warning("密码长度必须在6到30位之间！")
        return
    }

    // 两次密码不一致的检查
    if (ruleForm.password !== ruleForm.passwordrepeat) {
        ElMessage.warning("两次密码不一致，请检查！")
        return
    }

    // 验证表单
    await ruleFormRef.value.validate(async (valid) => {
        if (valid) {
            postRegister(ruleForm)
                .then((msg) => {
                    if (msg.code == 200) {
                        router.push({ name: 'login' })
                    }
                    ElMessage.success(msg.message)
                })
                .catch(() => {
                    ElMessage.error('注册失败')
                })
        }
    })
}

</script>


<style scoped lang="scss">
.input-box {
    width: 100%;
    padding: 2rem 0;

    .item {
        margin-bottom: 1rem;
    }

    .submit {
        color: #fff;
        width: 100% !important;
        width: 100px;
        margin-top: 1rem;
    }

    .Verification {
        width: 100%;
        display: flex;
        cursor: pointer;

        .code {
            margin-left: 4px;
            width: 100px;
            max-width: 100px;
            min-width: 100px;
            height: 40px;
            border-radius: 4px;
            box-sizing: border-box;
            box-shadow: 0 0 0 1px var(--el-input-border-color, var(--el-border-color));
            position: relative;

            .el-button {
                width: 100px;
            }
        }
    }


    .otherMethods {
        display: flex;
        align-items: center;
        justify-content: space-between;

        a,
        p {
            cursor: pointer;
            font-size: 14px;
            color: #000;
        }
    }
}
</style>
