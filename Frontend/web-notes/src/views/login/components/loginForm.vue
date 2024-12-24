<template>
    <h2>ThinKing ｜ 登录</h2>
    <el-form ref="ruleFormRef" class="input-box" :model="ruleForm" :rules="rules" label-width="auto" inline-message>
        <el-form-item prop="email" class="item">
            <el-input v-model="ruleForm.email" size="large" placeholder="请输入邮箱" clearable />
        </el-form-item>
        <el-form-item prop="password" class="item">
            <el-input v-model="ruleForm.password" size="large" type="password" show-password placeholder="请输入密码"
                clearable />
        </el-form-item>
        <el-form-item>
            <el-button class="item submit" color="#000" size="large" @click="submitForm(ruleFormRef)">登录</el-button>
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
import { getVerifyCode, Userlogin } from '@/api/login';

import { debounce } from 'lodash';  // 防抖
import { ElMessage } from 'element-plus'
import loading from '@icon/loading.png';
import { useUserStore } from '@/stores/modules/user'
const store = useUserStore()

const router = useRouter();

const emailRegEx = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/ // 邮箱正则

const ruleFormRef = ref()
const ruleForm = reactive({
    email: 'xiaoli@qq.com',
    password: "123456",
})

const rules = reactive({
    email: [
        { required: true, message: '请输入邮箱', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('请输入邮箱'))
                }
                if (emailRegEx.test(value)) {
                    return callback() // 邮箱验证通过
                }
                callback(new Error('请输入有效的邮箱')) // 验证失败
            },
            trigger: 'blur'
        }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, max: 30, message: '密码长度需在6至30位', trigger: 'blur' }
    ]
})

// 提交
const submitForm = async (formEl) => {

    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            Userlogin(ruleForm).then((res) => {
                if (res.code === 200) {
                    ElMessage.success(res.message)
                    store.getDefaultSpaceFun()
                    return
                }
                ElMessage.warning(res.message)
            }).catch((e) => {
                console.log(e);

                console.error('登录失败?', e);
            });
        } else {
            console.log('error submit!', fields)
        }
    })
}



// // 获取图片验证码
// let captchaUrl = ref(loading); // 验证码图片
// // 点击时防抖
// const VerificationClick = debounce(() => {
//     VerificationGet()
// }, 500);  // 防抖时间为 1000 毫秒（1秒）


// let VerificationGet = () => {
//     getVerifyCode()
//         .then((msg) => {
//             captchaUrl.value = msg;
//             console.log('获取验证码成功', captchaUrl.value);
//         })
//         .catch((e) => {
//             console.error('获取验证码失败', e);
//             // 这里处理失败的逻辑
//         });
// }
// VerificationGet();
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
        width: 100%;
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
            color: #000;
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
