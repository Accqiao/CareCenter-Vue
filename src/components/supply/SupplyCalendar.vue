<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>膳食信息</el-breadcrumb-item>
      <el-breadcrumb-item>本周膳食</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="供应类型" :label-width="formLabelWidth">
            <el-select v-model="formInline.supplyType" placeholder="请选择">
              <el-option label="早餐" value="早餐"></el-option>
              <el-option label="午餐" value="午餐"></el-option>
              <el-option label="下午茶" value="下午茶"></el-option>
              <el-option label="晚餐" value="晚餐"></el-option>
              <el-option label="夜宵" value="夜宵"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="供应时间" :label-width="formLabelWidth">
            <el-select v-model="formInline.supplyWeek" placeholder="请选择">
              <el-option label="星期一" value="星期一"></el-option>
              <el-option label="星期二" value="星期二"></el-option>
              <el-option label="星期三" value="星期三"></el-option>
              <el-option label="星期四" value="星期四"></el-option>
              <el-option label="星期五" value="星期五"></el-option>
              <el-option label="星期六" value="星期六"></el-option>
              <el-option label="星期天" value="星期天"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleQuery">查询</el-button>
          </el-form-item>
        </el-form>
      </div>

      <div>
        <el-table
            v-loading="loading"
            :data="pageInfo.list"
            :stripe=stripe
            :border=border
            style="width: 100%"
            class="tab">
          <el-table-column type="expand">
            <template slot-scope="props">
              <el-form label-position="left" inline class="demo-table-expand">
                <el-form-item label="食品描述:"><span>{{ props.row.food.description }}</span></el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column prop="supplyWeek" label="供应时间" width="145"></el-table-column>
          <el-table-column prop="supplyType" label="供应类型" width="145"></el-table-column>
          <el-table-column prop="food.foodName" label="食品名称" width="150"></el-table-column>
          <el-table-column prop="food.foodType" label="类型" width="145"></el-table-column>
          <el-table-column prop="food.foodSign" label="标签" width="145"></el-table-column>
          <el-table-column label="是否清蒸" width="145">
            <template slot-scope="scope">
              {{scope.row.food.isSteam|formatIsSteam}}
            </template>
          </el-table-column>
          <el-table-column label="上架时间" width="180">
            <template slot-scope="scope">{{scope.row.addDate|convertDate}}</template>
          </el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleDistribution(scope.row.supplyId)">膳食分配</el-button>
            </template>
          </el-table-column>

        </el-table>
        <el-pagination
            background
            layout="total,prev, pager, next"
            :total="pageInfo.total"
            :page-size="pageInfo.pageSize"
            @current-change="handleCurrentChange">
        </el-pagination>

        <el-dialog title="膳食分配" :visible.sync="dialogFormVisible">
          <el-form :model="form">
            <el-form-item label="客户名" :label-width="formLabelWidth">
              <el-select v-model="form.cid" placeholder="请选择">
                <el-option v-for="item in userOpts" :key="item.cid" :label="item.name" :value="item.cid"/>
              </el-select>
            </el-form-item>

          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="submitSupply">确 定</el-button>
          </div>
        </el-dialog>
      </div>
    </el-card>
  </div>
</template>

<script>
import {makeDate} from "@/common/js/dateformat";

export default {
  data(){
    return{
      formLabelWidth: '120px',
      dialogFormVisible: false,
      stripe:true,
      border:true,

      loading: false,
      currPage: 1,
      pageInfo: {},

      formInline:{//查找数据
        supplyType:'',
        supplyWeek:'',
      },
      userOpts:[],

      form:{
        supplyId:'',
        cid:''
      }
    }
  },
  created() {
    this.getUserInfo();
    this.getData();
  },
  methods: {
    getUserInfo(){
      let path = 'http://localhost:8080/customer/selAll'
      this.$ajax.get(path).then(res=>{
        console.log(res.data)
        this.userOpts = res.data
      })
    },
    getData() {
      this.loading = true
      let postData = this.$qs.stringify({
        supplyType: this.formInline.supplyType,
        supplyWeek: this.formInline.supplyWeek,
      })
      let path = `http://localhost:8080/supply/findAllSupplyAndFood/${this.currPage}`
      this.$ajax.post(path, postData).then(res => {
        this.pageInfo = res.data
        this.loading = false
        console.log(this.pageInfo)
      })
    },
    handleDistribution(id){//打开上架模态框,处理膳食供应时间
      console.log(id)
      this.dialogFormVisible = true//打开弹出框
      this.form.supplyId = id
    },
    submitSupply(row){
      console.log(row)
      this.dialogFormVisible = false//关闭弹出框
      let postData = this.$qs.stringify({
        supplyId:this.form.supplyId,
        cid:this.form.cid
      });
      let path = 'http://localhost:8080/distribution/add'
      this.$ajax.post(path,postData).then(res=>{
        console.log(res)
        if(res.data.status === 200){
          this.$message({
            message: res.data.message,
            type: 'success'
          });//弹出成功信息
          this.currPage = 1
          this.getData()
        }
      })
    },
    handleQuery(){
      this.currPage = 1
      this.getData();
    },
    handleCurrentChange(val) {
      this.currPage = val
      this.getData()
    },
  },
  filters: {//过滤器
    formatIsSteam(val) {
      let isSteam;
      if (val === "0") {
        isSteam = "不清蒸";
      } else {
        isSteam = "清蒸";
      }
      return isSteam;
    },
    convertDate(val){
      return makeDate(val)
    }
  }
}
</script>

<style scoped>
  .post-list {
    padding: 10px;
  }
  .header {
    margin-bottom: 10px;
  }
</style>