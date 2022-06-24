<template>
  <div class="post">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>膳食信息</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/food' }">膳食管理</el-breadcrumb-item>
      <el-breadcrumb-item>新增</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>新增膳食信息</span>
      </div>
      <div>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <el-form-item label="食品名称" prop="foodName">
            <el-input v-model="ruleForm.foodName"></el-input>
          </el-form-item>
          <el-form-item label="食品类型"  prop="foodType">
            <el-select v-model="ruleForm.foodType" placeholder="请选择食品类型">
              <el-option label="大荤" value="大荤"></el-option>
              <el-option label="小荤" value="小荤"></el-option>
              <el-option label="素菜" value="素菜"></el-option>
              <el-option label="甜点" value="甜点"></el-option>
              <el-option label="水果" value="水果"></el-option>
              <el-option label="蛋制类" value="蛋制类"></el-option>
              <el-option label="饮品" value="饮品"></el-option>
              <el-option label="套餐" value="套餐"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="foodSign" label="标签">
            <el-input v-model="ruleForm.foodSign"></el-input>
          </el-form-item>
          <el-form-item prop="foodPrice" label="价格(元)">
            <el-input v-model="ruleForm.foodPrice"></el-input>
          </el-form-item>
          <el-form-item label="清蒸" width="180" prop="isSteam">
            <el-select v-model="ruleForm.isSteam" placeholder="请选择是否清蒸">
              <el-option label="清蒸" value="1"></el-option>
              <el-option label="不清蒸" value="0"></el-option>
            </el-select>
          </el-form-item>


          <el-form-item label="照片" prop="foodPhoto">
            <el-upload
                list-type="picture-card"
                class="avatar-uploader"
                action="http://localhost:8080/common/upload"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
              <img v-if="ruleForm.foodPhoto" :src="`http://localhost:8080/${ruleForm.foodPhoto}`" class="avatar">
              <i v-else class="el-icon-plus avatar-uploader-icon"></i>
            </el-upload>
          </el-form-item>
          <el-form-item label="食品描述" prop="description">
            <el-input type="textarea" rows="5" v-model="ruleForm.description"></el-input>
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
        foodName:'',//食品名
        foodType:'',//食品类型：甜点，水果等
        foodSign:'',//标签：少盐，多脂肪
        foodPrice:'',//价格
        isSteam:'',//是否清蒸
        foodPhoto:'',//图片
        description:''//描述
      },
      rules:{
        foodName: [
          { required: true, message: '请输入食品名称', trigger: 'blur' },
        ],
        foodType: [
          { required: true, message: '请选择食品类型', trigger: 'change' }
        ],
        foodPrice:[
          { required: true, message: '请填写价格', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '请输入数字' }
        ],
        isSteam: [
          { required: true, message: '请选择是否清蒸', trigger: 'change' }
        ],
        foodPhoto: [
          { required: true, message: '请上传图片', trigger: 'blur' }
        ],
        description: [
          { required: true, message: '请填写食品介绍', trigger: 'blur' }
        ]
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
      this.ruleForm.foodPhoto = res;
    },
    submitForm(formName){
      this.$refs[formName].validate((valid) => {
        if(valid){
          let path = 'http://localhost:8080/food/add';
          let postData = this.$qs.stringify({
            foodName:this.ruleForm.foodName,//食品名
            foodType:this.ruleForm.foodType,//食品类型：甜点，水果等
            foodSign:this.ruleForm.foodSign,//标签：少盐，多脂肪
            foodPrice:this.ruleForm.foodPrice,//价格
            isSteam:this.ruleForm.isSteam,//是否清蒸
            foodPhoto:this.ruleForm.foodPhoto,//图片
            description:this.ruleForm.description//描述
          });
          console.log(postData);
          this.$ajax.post(path,postData).then(res=>{
            console.log(res.data);
            if(res.data.status === 200){
              this.$message({
                message: res.data.message,
                type: 'success'
              });//弹出成功信息
            }
          })
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