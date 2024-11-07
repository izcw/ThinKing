<template>
    <el-form ref="ruleFormRef" class="input-box" :model="ruleForm" :rules="rules" label-width="auto" inline-message>
        <el-form-item prop="email" class="item" v-if="!nextCorrect">
            <el-input v-model="ruleForm.email" size="large" placeholder="请输入邮箱" clearable />
        </el-form-item>

        <el-form-item prop="password" class="item" v-if="nextCorrect">
            <el-input v-model="ruleForm.password" size="large" placeholder="请输入密码" clearable />
        </el-form-item>

        <el-form-item prop="passwordrepeat" class="item" v-if="nextCorrect">
            <el-input v-model="ruleForm.passwordrepeat" size="large" placeholder="请再次输入密码" clearable />
        </el-form-item>

        <el-form-item prop="code" class="item" v-else>
            <div class="Verification">
                <el-input v-model="ruleForm.code" minlength="6" maxlength="6" size="large" placeholder="验证码"
                    clearable />
                <el-button class="code" type="primary" plain size="large" :disabled="isCountingDown" @click="EmailCode">
                    {{ isCountingDown ? `${countdown}s` : '获取验证码' }}
                </el-button>
            </div>
        </el-form-item>

        <el-form-item>
            <el-button class="item submit" color="#112BBA" size="large" v-if="!nextCorrect"
                :disabled="!isValidCode || !isValidEmail" @click="nextSubmitForm">下一步</el-button>
            <el-button class="item submit" color="#112BBA" size="large" v-else :disabled="nextCorrect"
                @click="submitForm">注册</el-button>
        </el-form-item>
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
let previousStep = ()=> {
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

// 验证邮箱格式的正则
const emailRegEx = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(?:\.[a-zA-Z0-9_-]+)+$/

// 倒计时相关
let countdown = ref(0)
let isCountingDown = ref(false)
const isValidCode = computed(() => /^\d{6}$/.test(ruleForm.code)) // 验证码不仅是6位，而且必须是数字
const isValidEmail = computed(() => emailRegEx.test(ruleForm.email)) // 邮箱是否正确


// 判断表单是否有效
const isValidForm = computed(() => {
    return emailRegEx.test(ruleForm.email) && isValidCode.value
})

// 获取验证码，防抖处理
const EmailCode = debounce(() => {
    if (!isValidEmail) {
        ElMessage.error('请输入有效的邮箱')
        return
    }

    getEmailCode({ email: ruleForm.email })
        .then((msg) => {
            ElMessage.success(msg.message)
            startCountdown()
        })
        .catch((error) => {
            ElMessage.error('获取验证码失败')
        })
}, 500)

// 启动倒计时
const startCountdown = () => {
    isCountingDown.value = true
    countdown.value = 60
    const timer = setInterval(() => {
        if (countdown.value <= 0) {
            clearInterval(timer)
            isCountingDown.value = false
        } else {
            countdown.value--
        }
    }, 500)
}

// 验证邮箱和验证码
const nextSubmitForm = () => {
    const { email, code } = ruleForm
    postVerifyEmailCode({ email, code })
        .then((msg) => {
            if (msg.code == 200) {
                ElMessage.success(msg.message)
                nextCorrect.value = true
            } else {
                ElMessage.warning(msg.message)
            }
        }).catch((error) => {
            ElMessage.error('验证码错误，请重新获取')
        })
}

// 提交表单，注册用户
const submitForm = async () => {
    await ruleFormRef.value.validate(async (valid) => {
        if (valid) {
            postRegister(ruleForm)
                .then((msg) => {
                    if (msg.code === 201) {
                        router.push({ name: 'login' })
                    }
                    ElMessage.success(msg.message)
                })
                .catch((error) => {
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
        margin-top: 1rem;
    }

    .Verification {
        display: flex;
        cursor: pointer;

        .code {
            margin-left: 4px;
            width: 100px;
            height: 40px;
            border-radius: 4px;
            box-sizing: border-box;
            box-shadow: 0 0 0 1px var(--el-input-border-color, var(--el-border-color));
            position: relative;
        }
    }


    .otherMethods {
        display: flex;
        align-items: center;
        justify-content: space-between;

        a,p {
            cursor: pointer;
            font-size: 14px;
            color: #409EFF;
        }
    }
}
</style>
