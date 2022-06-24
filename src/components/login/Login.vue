<template>
  <el-card class="box-card">
    <h2>登录</h2>
    <br><br>
    <el-form :model="loginForm" :rules="rules" ref="loginForm" label-width="65px"  class="demo-ruleForm">
      <el-form-item label="用户名" prop="username">
        <el-input v-model="loginForm.username"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="loginForm.password"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="submitForm('loginForm')">登录</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
export default {
  name: 'Login',
  data () {
    return {
      loginForm: {
        userName: '',
        password: ''
      },
      rules: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 3, max: 12, message: '长度在 3 到 12 个字符', trigger: 'blur' }
        ],
      }
    }
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let path = 'http://localhost:8080/customer/login';
          let postData = this.$qs.stringify({
            name: this.loginForm.userName,
            phone: this.loginForm.password,
          })
          this.$ajax.post(path,postData).then(res=>{
            console.log(res.data)
            switch (res.data.status){
              case 200:
                this.$message({
                  message: res.data.message,
                  type: 'success'
                });//弹出成功信息
                //json对象res.data.obj转字符串，传入sessionStorage
                sessionStorage.setItem("user",JSON.stringify(res.data.obj));

                //使用vuex,调用action中setUser方法,存储登录用户对象信息
                //this.$store.dispatch('setUser',res.data.obj)

                this.$router.push("/main/overview");
                break;
              case 500:
                this.$message.error(res.data.message);//弹出错误信息
                break;
            }
          })
        }
      });
    }

  }

}
</script>

<style scoped>
  .box-card {
    width: 600px;
    margin: 185px auto;
    text-align: center;
  }
</style>
