<template>
  <div class="post">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>用户信息</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/staff' }">员工管理</el-breadcrumb-item>
      <el-breadcrumb-item>新增</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>新增职工信息</span>
      </div>
      <div>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="姓名" prop="staffName">
            <el-input v-model="ruleForm.staffName"></el-input>
          </el-form-item>
          <el-form-item label="角色"  prop="staffJob">
            <el-select v-model="ruleForm.staffJob" placeholder="请选择角色类型">
              <el-option label="系统管理员" value="系统管理员"></el-option>
              <el-option label="医生" value="医生"></el-option>
              <el-option label="护士" value="护士"></el-option>
              <el-option label="护工" value="护工"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="staffAge" label="年龄">
            <el-input v-model="ruleForm.staffAge"></el-input>
          </el-form-item>
          <el-form-item label="性别" width="180" prop="staffSex">
            <el-select v-model="ruleForm.staffSex" placeholder="请选择">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="staffPhone" label="电话">
            <el-input v-model="ruleForm.staffPhone"></el-input>
          </el-form-item>
          <el-form-item prop="staffTitle" label="职称">
            <el-input v-model="ruleForm.staffTitle"></el-input>
          </el-form-item>
          <el-form-item label="照片" prop="staffImg">
            <el-upload
                list-type="picture-card"
                class="avatar-uploader"
                action="http://localhost:8080/common/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
              <img v-if="ruleForm.staffImg" :src="`http://localhost:8080/header/${ruleForm.staffImg}`" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
          <el-form-item label="个人简介" prop="staffBriefintroduction">
            <el-input type="textarea" rows="5" v-model="ruleForm.staffBriefintroduction"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
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
        staffName:'',
        staffAge:'',
        staffSex:'',
        staffPhone:'',
        staffImg:'',
        staffJob:'',
        staffTitle:'',
        staffBriefintroduction:'',
      },
      rules:{
        staffName: [
          { required: true, message: '请输入职工姓名', trigger: 'blur' },
        ],
        staffAge:[
          { required: true, message: '请填写年龄', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字' }
        ],
        staffPhone:[
          { required: true, message: '请填写电话', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字' }
        ],
        foodPhoto: [
          { required: true, message: '请上传图片', trigger: 'blur' }
        ],
      },
    }
  },
  created(){

  },
  methods:{
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
      this.ruleForm.staffImg = res;
    },
    submitForm(formName){
      this.$refs[formName].validate((valid) => {
        if(valid){
          let path = 'http://localhost:8080/staff/insert';
          let postData = this.$qs.stringify({
            staffName:this.ruleForm.staffName,
            staffAge:this.ruleForm.staffAge,
            staffSex:this.ruleForm.staffSex,
            staffPhone:this.ruleForm.staffPhone,
            staffImg:this.ruleForm.staffImg,
            staffJob:this.ruleForm.staffJob,
            staffTitle:this.ruleForm.staffTitle,
            staffBriefintroduction:this.ruleForm.staffBriefintroduction,
          });
          console.log(postData);
          this.$ajax.post(path,postData).then(res=>{
            console.log(res.data);
              this.$message({
                message:"添加成功",
                type: 'success'
              });//弹出成功信息
          })
          this.$router.push({path: '/staff'})
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