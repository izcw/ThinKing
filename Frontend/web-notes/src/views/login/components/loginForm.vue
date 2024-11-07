<template>
    <el-form ref="ruleFormRef" class="input-box" :model="ruleForm" :rules="rules" label-width="auto" inline-message>
        <el-form-item prop="email" class="item">
            <el-input v-model="ruleForm.email" size="large" placeholder="请输入手机号 / 邮箱" clearable />
        </el-form-item>
        <el-form-item prop="password" class="item">
            <el-input v-model="ruleForm.password" size="large" placeholder="请输入密码" clearable />
        </el-form-item>
        <el-form-item>
            <el-button class="item submit" color="#112BBA" size="large" @click="submitForm(ruleFormRef)">登录</el-button>
        </el-form-item>
        <div class="otherMethods">
            <router-link to="/login" class="issue">账号常见问题</router-link>
            <div>
                <router-link to="/register">立即注册</router-link>
                <span>|</span>
                <router-link to="/login">忘记密码</router-link>
            </div>
        </div>
    </el-form>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router';
import { getVerifyCode, postlogin } from '@/api/login';
import { debounce } from 'lodash';  // 防抖
import loading from '@icon/loading.png';

const router = useRouter();



// 引入正则表达式用于手机号和邮箱的验证
const phoneRegEx = /^[1][3-9][0-9]{9}$/ // 手机号正则
const emailRegEx = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(?:\.[a-zA-Z0-9_-]+)+$/ // 邮箱正则

const ruleFormRef = ref()
const ruleForm = reactive({
    email: '2405824084@qq.com',
    password: "",
    code: '4141',
})

const rules = reactive({
    email: [
        { required: true, message: '请输入手机号或邮箱', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('请输入手机号或邮箱'))
                }
                // 判断是手机号还是邮箱
                if (phoneRegEx.test(value)) {
                    return callback() // 手机号验证通过
                }
                if (emailRegEx.test(value)) {
                    return callback() // 邮箱验证通过
                }
                callback(new Error('请输入有效的手机号或邮箱')) // 验证失败
            },
            trigger: 'blur'
        }
    ],
    code: [
        { required: true, message: '请输入正确的验证码', trigger: 'blur' },
        { min: 4, max: 4, message: '请输入6位验证码', trigger: 'blur' },
    ]
})

// 提交
const submitForm = async (formEl) => {
    postlogin(ruleForm).then((msg) => {
        console.log(msg);
    })
        .catch((e) => {
            console.error('登录失败', e);
        });
    // if (!formEl) return
    // await formEl.validate((valid, fields) => {
    //     if (valid) {

    //     } else {
    //         console.log('error submit!', fields)
    //     }
    // })
}

// 获取图片验证码
let captchaUrl = ref(loading); // 验证码图片
// 点击时防抖
const VerificationClick = debounce(() => {
    VerificationGet()
}, 500);  // 防抖时间为 1000 毫秒（1秒）


let VerificationGet = () => {
    getVerifyCode()
        .then((msg) => {
            captchaUrl.value = msg;
            console.log('获取验证码成功', captchaUrl.value);
        })
        .catch((e) => {
            console.error('获取验证码失败', e);
            // 这里处理失败的逻辑
        });
}
VerificationGet();
</script>
<style scoped lang='scss'>
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

    // 隐私政策
    .PrivacyPolicy {
        font-size: 12px;
        color: #666;

        a {
            color: #666;
            text-decoration: underline;
        }
    }

    .PrivacyPolicy.is-checked a {
        color: var(--el-checkbox-checked-text-color);
    }

    // 验证码
    .Verification {
        display: flex;
        cursor: pointer;

        .code {
            margin-left: 4px;
            width: 100px;
            min-width: 100px;
            height: 40px;
            border-radius: 4px;
            box-sizing: border-box;
            box-shadow: 0 0 0 1px var(--el-input-border-color, var(--el-border-color));
            position: relative;
            overflow: hidden;

            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
            }
        }
    }

    .otherMethods {
        display: flex;
        align-items: center;
        justify-content: space-between;

        a {
            font-size: 14px;
            color: #409EFF;
        }

        .issue {
            color: #999;
        }

        span {
            font-size: 14px;
            color: #eee;
            margin: 0 4px;
        }
    }
}
</style>
