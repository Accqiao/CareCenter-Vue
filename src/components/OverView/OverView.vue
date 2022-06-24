<template>

  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item >入退记录</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card" >
      <div slot="header" class="clearfix">
        <el-form :inline="true" :model="formbuding" class="demo-form-inline">
          <el-form-item label="楼号">
            <el-select v-model="formbuding.build" placeholder="A">
              <el-option v-for="(it,index) in builds" :key="index" :label="it" :value="it"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </div>
      <div  style="">
<!--        //房间列表-->
  <ul  style=";width: fit-content">
    <li style="; " v-for="(item,index) in buildings" :key="index" >
      <ul  style="background: #f4f8f6;white-space: nowrap;width: fit-content">
        <li style=";display: inline-block;" v-for="it in item" :key="it.rid" >
          <el-popover
              placement="bottom-start"
              :title="nameById(it.rid)"
              width="150"
              trigger="hover"
              :content="contentById(it.rid)">
            <el-button slot="reference" style="margin: 0;padding: 0;" @click="checkOp(it.rid,it.status)">
              <div class="room" :id="it.rid">
                <img class="tou" :src="photoById(it.rid)">
                <div style="margin:0;text-align: left;font-size: 10px;width: fit-content;padding: 0">{{ it.rid }}</div>
                <p style="margin:0;font-size: 18px;padding-top: 3px">{{ nameById(it.rid) }}</p>
              </div>
            </el-button>
          </el-popover>
        </li>
<!--        <li style="background: #f4f8f6;display: inline-block;">-->
<!--          <div class="room" >-->
<!--            <img class="tou" >-->
<!--            <div style="margin:0;text-align: left;font-size: 10px;width: fit-content;padding: 0">A??</div>-->
<!--            <p style="margin:0;font-size: 18px;padding-top: 3px">添加</p>-->
<!--          </div>-->
<!--        </li>-->
      </ul>
    </li>
    <li>
      <ul style="background: #f4f8f6;width: fit-content">
        <li>
          <el-popover
              placement="right-start"
              width="200"
              trigger="hover"
              content="点击添加新的房间！">
            <el-button slot="reference" style="margin: 0;padding: 0;" @click="clickRoom">
              <div class="room" >
                <img class="tou" >
                <div style="margin:0;text-align: left;font-size: 10px;width: fit-content;padding: 0">{{ formbuding.build }}</div>
                <p style="margin:0;font-size: 18px;padding-top: 3px">添加</p>
              </div>
            </el-button>

          </el-popover>
        </li>
      </ul>

    </li>
  </ul>

<!--        //入住房间用户的详细信息-->
  <el-drawer
      :title="details.rid"
      :visible.sync="drawer"
      :direction="direction"
      :with-header="false"
      :before-close="handleClose">
    <span>
      <div style="margin:auto;width: fit-content;margin-top: 20px">
        <img :src="`http://localhost:8080/${details.photo}`" style="width: 150px;border-radius: 50%;">
      </div>
      <div STYLE="padding: 15px">
        <el-descriptions class="margin-top" title="详细信息" :column="1"  border>
           <template slot="extra">
<!--            <el-button type="primary" size="small">操作</el-button>-->
             <el-button size="small" type="danger" @click="toTui(details.rid)">退住</el-button>
           </template>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>姓名
            </template>
            {{details.name}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>身份证号
            </template>
            {{details.cid}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>性别
            </template>
            {{details.sex}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>年龄
            </template>
            {{details.age}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-mobile-phone"></i>联系电话
            </template>
            {{details.phone}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-tickets"></i>身体情况
            </template>
            {{details.illness}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-tickets"></i>注意事项
            </template>
            {{details.notes}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-time"></i>入住时间
            </template>
            {{details.intime}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-tickets"></i>入住说明
            </template>
            {{details.indescribe}}
          </el-descriptions-item>
        </el-descriptions>

      </div>
    </span>
  </el-drawer>

<!--        //新增住户-->
  <el-dialog title="入住信息" :visible.sync="dialogFormVisible">
    <el-form :model="form" :rules="rules" ref="form">

        <el-form-item label="用户ID" prop="cid" :label-width="formLabelWidth">
          <el-input v-model="form.cid" autocomplete="off"></el-input>
        </el-form-item>
      <el-row>
      <el-col :span="7">
        <el-form-item label="姓名" prop="name" :label-width="formLabelWidth">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
      </el-col>
      <el-col :span="7">
        <el-form-item label="年龄" :label-width="formLabelWidth"
                      prop="age">
          <el-input v-model="form.age" autocomplete="off"></el-input>
        </el-form-item>
      </el-col>
       <el-col :span="7">
         <el-form-item label="性别" :label-width="formLabelWidth">
           <el-input v-model="form.sex" autocomplete="off"></el-input>
         </el-form-item>
      </el-col>
      </el-row>

      <el-form-item label="联系电话" :label-width="formLabelWidth"
                    prop="phone">
        <el-input v-model="form.phone" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="身体情况" :label-width="formLabelWidth">
        <el-input v-model="form.illness" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="注意事项" :label-width="formLabelWidth">
        <el-input v-model="form.notes" autocomplete="off"></el-input>
      </el-form-item>
<!--      <el-form-item label="头像" :label-width="formLabelWidth">-->
<!--        <el-input v-model="form.photo" autocomplete="off"></el-input>-->
<!--      </el-form-item>-->
      <el-form-item label="入住描述" :label-width="formLabelWidth">
        <el-input v-model="form.desc" autocomplete="off"></el-input>
      </el-form-item>

    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="toJoin('form')">确 定</el-button>
    </div>
  </el-dialog>

<!--        //新增房间-->
  <el-dialog title="新增房间" :visible.sync="newdialog">
    <el-form :model="formroom">
      <el-row>
        <el-col :span="8">
          <el-form-item label="楼层" :label-width="formLabelWidth">
            <el-input v-model="formroom.floor" autocomplete="off"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="编号" :label-width="formLabelWidth">
            <el-input v-model="formroom.rnum" autocomplete="off"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item>
            <h2 style="margin: 0px;left: 40px;position: relative;">{{RoomId}}</h2>
          </el-form-item>

        </el-col>
      </el-row>
      <el-form-item label="房间名称" :label-width="formLabelWidth">
        <el-input v-model="formroom.name" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="房间描述" :label-width="formLabelWidth">
        <el-input v-model="formroom.desc" autocomplete="off"></el-input>
      </el-form-item>

    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="newRoom">确 定</el-button>
    </div>
  </el-dialog>

</div>
    </el-card>
  </div>

</template>

<script>
export default {
name: "OverView",
  data(){
    return {
      size: '',
      drawer: false,
      formbuding: {
        build:'A'
      },
      builds:[],
      direction: 'rtl',
      imag:"http://localhost:8080/babala.jpg",
      thisBuilding:'A',
      buildings:{},
      roomData:{},
      details:{},
      newdialog: false,
      dialogFormVisible: false,
      formroom:{
        rnum:'',
        rid:'',
        floor:'',
        name:'',
        des:'',
      },
      form: {
        cid:'',
        name:'',
        age:'',
        sex:'',
        phone:'',
        illness:'',
        notes:'',
        photo:'',
        rid: '',
        desc: '',
      },
      formLabelWidth: '120px',
      rules: {
        name: [
          { required: true, message: '不能为空', trigger: 'blur' },
          { min: 2, max: 5, message: '长度为2-5 ', trigger: 'blur' }
        ],
        cid: [
          { required: true, message: '不能为空', trigger: 'blur' },
          { min: 18, max: 18, message: '长度为18字符', trigger: 'blur' }
        ],
        age:[
          { required: true, message: '不能为空',trigger: 'blur'},
          { type: 'number', message: '必须为数字', trigger: 'blur',transform: (value) => Number(value)},
        ],
        phone: [
          { required: true, message: '请输入手机号码', trigger: 'blur' },
          { min: 11, max: 11, message: '请输入11位手机号码', trigger: 'blur' },
          { type: 'number', message: '必须为数字', trigger: 'blur',transform: (value) => Number(value)},
        ],
      }
    }
  },
  created() {
    this.getRoom();
    this.getUser()
    this.getBuild()
  },
  computed:{
    RoomId(){
      return this.formbuding.build+this.formroom.floor+this.formroom.rnum
    }
  },
  watch: {
    'form.cid' (curVal, oldVal) {
      // 实现input连续输入，只发一次请求
      console.log(curVal,oldVal)
      clearTimeout(this.timeout)
      this.timeout = setTimeout(() => {
        this.checkUid()
      }, 500)
    },
    'formbuding.build'(){
      this.getRoom()
      this.getUser()
    }
  },
  methods: {
    getBuild(){
      let path = `http://localhost:8080/room/selbuild`
      this.$ajax.get(path).then(res=>{
        this.builds = res.data
        console.log(res.data)
      })
    },
    clickRoom:function (){
      this.newdialog = true
    },
    newRoom:function (){
      // this.resetForm(this.form)
      this.newdialog = false
      this.formroom.rid = this.formbuding.build+this.formroom.floor+this.formroom.rnum
      let path = `http://localhost:8080/room/insert`
      this.$ajax.post(path,this.formroom).then(res=>{
        console.log(this.form)
        if(res.status === 200){
          this.getRoom();
          this.$message({
            message:"添加成功！",
            type:'success'
          })
        }else{
          this.$message.error('异常状态！');
        }
      })
    },
    getRoom:function (){
      let path = `http://localhost:8080/overview/selBuild/${this.formbuding.build}`
      this.$ajax.get(path).then(res=>{
        this.buildings = this.groupBy(res.data,function (item) {
          return item.floor;
        })
        console.log(this.buildings)
      })
    },
    getUser:function (){
      let cPath = `http://localhost:8080/userInfo/little/${this.formbuding.build}`
      this.$ajax.get(cPath).then(res=>{
        this.roomData = res.data;
        console.log(this.roomData)
      })
    },
    toJoin:function (formName){
      this.$refs[formName].validate((valid) => {
        if (valid) {
          let path = `http://localhost:8080/userInfo/insert`
          this.$ajax.post(path,this.form).then(res=>{
            console.log(this.form)
            if(res.status === 200){
              this.getUser()
              this.setStatus(this.form.rid,"using")
              this.$message({
                message:"添加成功！",
                type:'success'
              })
            }
          })
          this.dialogFormVisible = false
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    checkUid:function (){
      let path = `http://localhost:8080/customer/selOne/${this.form.cid}`
      this.$ajax.get(path).then(res=>{
        console.log(res.data)
        this.form.name = res.data.name
        this.form.age = res.data.age
        this.form.sex = res.data.sex
        this.form.phone = res.data.phone
        this.form.illness = res.data.illness
        this.form.notes = res.data.notes
        this.form.photo = res.data.photo
        console.log("join",this.form)
      })
    },
    thisNo:function (rid){
      this.$confirm('该房间没有用户入住，是否添加新用户？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '删除房间！',
      }).then(() => {
        this.dialogFormVisible = true
        this.form.rid =rid
        this.$nextTick(() => {
          this.form.cid = null;
          this.form.name = null;
          this.form.age = null;
          this.form.sex = null;
          this.form.photo = null;
          this.form.illness = null;
          this.form.notes = null;
          this.form.photo = null;
          this.form.desc = null;
          this.$refs['form'].resetFields();
        })
      }).catch(() => {
        let path = `http://localhost:8080/room/del`
        this.$ajax.post(path,rid).then(res=>{
          if(res.status === 200){
            this.getRoom();
            this.$message({
              message:"删除成功！",
              type:'success'
            })
          }else{
            this.$message.error('异常状态！');
          }
        })

      });
    },
    checkOp:function(rid,status){
      console.log("open",rid,status)
      if(status == "using"){
        for (let i in this.roomData){
          if(this.roomData[i].rid == rid){
            this.details =  this.roomData[i];
            break;
          }
        }
        this.drawer = true
      }
      else {
        this.thisNo( rid )
      }
    },
    handleClose(done) {
      done();
    },
    nameById:function(id){
      // var da =  this.findDataById(id)
      // console.log("213",da.name)
      for (let i in this.roomData){
        if(this.roomData[i].rid == id){
          return this.roomData[i].name;
        }
      }
    },
    photoById:function(id){
      for (let i in this.roomData){
        if(this.roomData[i].rid == id){
          // return this.roomData[i].photo;
          return "http://localhost:8080/"+this.roomData[i].photo
        }
      }
    },
    contentById:function(id){
      for (let i in this.roomData){
        if(this.roomData[i].rid == id){
          var content = "性别："+this.roomData[i].sex+"   | 年龄："+this.roomData[i].age;
          return content;
        }
      }
      return "暂无入住信息";
    },
    toTuiDes:function (rid,str){
      console.log("传递：",str)
      let path = `http://localhost:8080/record/tui`
      this.$ajax.post(path,str).then(res=>{
        if(res.status === 200){
          this.roomData = this.roomData.filter(t => t.rid != rid)
          this.setStatus(rid,"no")
          this.$message({
            message:"退住成功！",
            type:'success'
          })
        }
      })
    },
    toTui:function (rid){
      this.$prompt('退住描述(选择输入)', '退住确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',

      }).then(({ value }) => {
        this.toTuiDes(rid,rid+value)
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消操作'
        });
      });
    },
    setId:function (rid){
      return "li_"+rid;
    },
    groupBy: function (array , f) {
      let groups = {};
      array.forEach( function( o ) {
        let group = JSON.stringify( f(o) );
        groups[group] = groups[group] || [];
        groups[group].push( o );
      });
      return Object.keys(groups).map( function( group ) {
        return groups[group];
      });

    },
    setStatus:function (rid,sta){
      let f = rid.substring(1,2)-1;
      for (let i in this.buildings[f]){
        if(this.buildings[f][i].rid == rid){
          this.buildings[f][i].status = sta;
          break
        }
      }
    }
  },
}
</script>

<style scoped>
.MainDiv{
  width: 80%;
  border-radius: 5px;
  margin: 0 auto;
  height: 100%;
  overflow: auto;
}
.tou{
  height:80px;
  float: right;
  margin-right: 10px;
  border-radius: 50%;
  /*margin-top: 18px;*/
}
.room{
  border-radius: 5px;
  width: 180px;
  height:80px;
  background: #eae2e2;
  margin: 0;
  background-image: url("../../assets/chuang.png");
  background-size:80px ;
  background-repeat: no-repeat;
  background-position-y: 32px;
}
ul{
  list-style:none;
  border-radius: 5px;
  height: 92%;
}
li{
  border-radius: 5px;
  padding: 3px 3px;
  overflow: hidden;
}

.post-list {
  padding: 10px;
}
.tab {
  margin: 10px 0;
}
.header {
  margin-bottom: 10px;
}
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
.wrap {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.image {
  width: 48px;
  height: 48px;
}
</style>