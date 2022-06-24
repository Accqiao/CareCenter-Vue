<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item >入退记录</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card" >
      <div class="" >

    <template>
      <el-table
          :data="records"
          stripe
          style="width: 100%">
        <el-table-column
            prop="reid"
            label="入院记录"
        width="80">
        </el-table-column>

        <el-table-column type="expand" >
          <template slot-scope="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="身份证号">
                <span>{{ props.row.cid }}</span>
              </el-form-item>
              <el-form-item label="姓名">
                <span>{{ props.row.name }}</span>
              </el-form-item>
              <el-form-item label="性别">
                <span>{{ props.row.sex }}</span>
              </el-form-item>
              <el-form-item label="年龄">
                <span>{{ props.row.age }}</span>
              </el-form-item>
              <el-form-item label="联系电话">
                <span>{{ props.row.phone }}</span>
              </el-form-item>
              <el-form-item label="身体情况">
                <span>{{ props.row.illness }}</span>
              </el-form-item>
              <el-form-item label="注意事项">
                <span>{{ props.row.notes }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>

        <el-table-column
            prop="name"
            label="姓名"
            width="80">
        </el-table-column>
        <el-table-column
            prop="intime"
            label="入院时间"
            width="100">
        </el-table-column>
        <el-table-column
            prop="indescribe"
            label="入院描述">
        </el-table-column>
        <el-table-column
            prop="rid"
            label="房间号"
            width="80">
        </el-table-column>
        <el-table-column
            prop="status"
            label="状态"
            width="80">
        </el-table-column>
        <el-table-column
            prop="outtime"
            label="退住时间"
            width="100">
        </el-table-column>
        <el-table-column
            prop="outdescribe"
            label="退住描述">
        </el-table-column>
        <el-table-column width="160px">
          <template slot-scope="scope">
            <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)">Edit</el-button>

            <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
    </template>


    <el-dialog title="可修改信息" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item label="入住描述" :label-width="formLabelWidth">
          <el-input v-model="form.desc" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="入住房间" :label-width="formLabelWidth">
          <el-select v-model="form.rid" placeholder="请选择相应房间">
            <el-option v-for="it in rooms" :key="it.rid" :label="it.rid" :value="it.rid"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="toEdit">确 定</el-button>
      </div>
    </el-dialog>



  </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "Record",
  data() {
    return {
      reIn:'',
      rooms:{},
      records: [],
      dialogFormVisible: false,
      form: {
        reid:'',
        rid: '',
        desc: '',
        oldrid:''
      },
      formLabelWidth: '120px'
    }
  },
  created() {
    let cPath = `http://localhost:8080/userInfo/all`
    this.$ajax.get(cPath).then(res=>{
      this.records = res.data;
      console.log(this.records)
    })

    let rPath = `http://localhost:8080/room/no`
    this.$ajax.get(rPath).then(res=>{
      this.rooms = res.data;
      console.log(this.rooms)
    })

  },
  methods:{
    handleEdit(index, row) {
      console.log(index, row);
      if(row.status == "已退住"){
        this.$message({
          message: '该记录已完成，无法修改！',
          type: 'warning'
        });
      }else {
        this.form.desc = row.indescribe;
        this.form.rid = row.rid;
        this.form.reid = row.reid;
        this.form.oldrid = row.rid;
        this.dialogFormVisible = true
        this.reIn = index;
      }
    },
    handleDelete(index, row) {
      console.log(index, row);
      if(row.status == "仍入住中"){
        this.$message({
          message: '该用户仍然入住中，无法删除！',
          type: 'warning'
        })
      }else {
        console.log(row.reid)
        let path = `http://localhost:8080/record/del`
        this.$ajax.post(path,row.reid).then(res=>{
          if(res.status === 200){
            this.records = this.records.filter(t => t.reid != row.reid)
            this.$message({
              message:"删除成功！",
              type:'success'
            })
          }
        })
      }


    },
    toEdit(){
      this.dialogFormVisible = false

      let path = `http://localhost:8080/record/updes`
      this.$ajax.post(path,this.form).then(res=>{
        console.log(this.form)
        if(res.status === 200){
          this.records[this.reIn].indescribe = this.form.desc
          this.records[this.reIn].rid = this.form.rid
          this.$message({
            message:"修改成功！",
            type:'success'
          })
        }
      })

    }
  }
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
demo-table-expand {
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