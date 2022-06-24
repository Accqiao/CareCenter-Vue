<template>
  <div class="post">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>用户信息</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/customer' }">客户管理</el-breadcrumb-item>
      <el-breadcrumb-item>修改</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>修改客户信息</span>
      </div>
      <div>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="姓名" prop="name">
            <el-input v-model="ruleForm.name"></el-input>
          </el-form-item>
          <el-form-item prop="age" label="年龄">
            <el-input v-model="ruleForm.age"></el-input>
          </el-form-item>
          <el-form-item label="性别" width="180" prop="sex">
            <el-select v-model="ruleForm.sex" placeholder="请选择">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="phone" label="电话">
            <el-input v-model="ruleForm.phone"></el-input>
          </el-form-item>
          <el-form-item prop="illness" label="健康状况">
            <el-input v-model="ruleForm.illness"></el-input>
          </el-form-item>
          <el-form-item label="照片" prop="photo">
            <el-upload
                list-type="picture-card"
                class="avatar-uploader"
                action="http://localhost:8080/common/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
              <img v-if="ruleForm.photo" :src="`http://localhost:8080/${ruleForm.photo}`" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
          <el-form-item label="注意事项" prop="notes">
            <el-input type="textarea" rows="5" v-model="ruleForm.notes"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">确认修改</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script>

export default {
  data(){
    return{
      ruleForm:{
        cid:'',
        name:'',
        age:'',
        sex:'',
        phone:'',
        illness:'',
        notes:'',
        photo:'',
      },
      rules:{
        name: [
          { required: true, message: '请输入客户姓名', trigger: 'blur' },
        ],
        age:[
          { required: true, message: '请填写年龄', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字' }
        ],
        phone:[
          { required: true, message: '请填写电话', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字' }
        ],
        photo: [
          { required: true, message: '请上传图片', trigger: 'blur' }
        ],
        illness: [
          { required: true, message: '请填写健康状况', trigger: 'blur' }
        ],
        notes: [
          { required: true, message: '请填写注意事项', trigger: 'blur' }
        ],
      },
    }
  },
  created(){
    this.ruleForm.cid = this.$route.query.cid;
    console.log(this.$route.query.cid)
    console.log(this.ruleForm.cid)
    this.getData();
  },
  methods:{
    getData(){
      let path = `http://localhost:8080/customer/findById/${this.ruleForm.cid}`
      this.$ajax.get(path).then(res=>{
        this.ruleForm = res.data;
      })
    },
    beforeAvatarUpload(file){//图片上传之前触发的方法
      console.log(file.type);
      //规定上传文件类型与大小
      const isJPG = file.type === 'image/jpeg' || file.type === 'image/webp' || file.type === 'image/png';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传图片只能是 JPG、WEBP、PNG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
    handleAvatarSuccess(res){//上传成功回调的方法
      console.log(res);
      this.ruleForm.photo = res;
    },
    submitForm(formName){
      this.$refs[formName].validate((valid) => {
        if(valid){
          let path = 'http://localhost:8080/customer/updateByCondition';
          let postData = this.$qs.stringify({
            cid:this.ruleForm.cid,
            name:this.ruleForm.name,
            age:this.ruleForm.age,
            sex:this.ruleForm.sex,
            phone:this.ruleForm.phone,
            illness:this.ruleForm.illness,
            notes:this.ruleForm.notes,
            photo:this.ruleForm.photo,
          });
          console.log(postData);
          this.$ajax.post(path,postData).then(res=>{
            console.log(res.data);
            this.$message({
              message:"修改成功",
              type: 'success'
            });//弹出成功信息
          })
          this.$router.push({path: '/customer'})
        }
      })
    },
    resetForm(formName){
      this.$refs[formName].resetFields();
    },
  }
}
</script>

<style scoped>
.post {
  padding: 10px;
}
.header {
  margin-bottom: 10px;
}
.el-input {
  width: 90% !important;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 146px;
  height: 146px;
  line-height: 146px;
  text-align: center;
}
.avatar {
  width: 146px;
  height: 146px;
  display: block;
}
.el-breadcrumb {
  margin-bottom: 10px;
}
</style>