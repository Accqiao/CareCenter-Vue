<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>膳食信息</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/food' }">膳食管理</el-breadcrumb-item>
      <el-breadcrumb-item >上架</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="食品名称">
            <el-input v-model="formInline.foodName" placeholder="食品名"></el-input>
          </el-form-item>
          <el-form-item label="食品类型">
            <el-select v-model="formInline.foodType" placeholder="请选择食品类型">
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
                <el-form-item label="食品描述:"><span>{{ props.row.description }}</span></el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column label="食品名称" width="180">
            <template slot-scope="scope">
              <div class="wrap">
                <div>{{scope.row.foodName}}</div>
                <div v-if="scope.row.foodPhoto">
                  <img :src="`http://localhost:8080/${scope.row.foodPhoto}`" class="image"/>
                </div>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="foodType" label="类型" width="180"></el-table-column>
          <el-table-column prop="foodSign" label="标签" width="180"></el-table-column>
          <el-table-column prop="foodPrice" label="价格(元)" width="180"></el-table-column>
          <el-table-column label="是否清蒸" width="180">
            <template slot-scope="scope">
              {{scope.row.isSteam|formatIsSteam}}
            </template>
          </el-table-column>

          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleShow(scope.row.foodId)">查看供应时间</el-button>
              <el-button size="mini" type="danger" @click="handleSupply(scope.row.foodId)">上架</el-button>
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

        <el-dialog title="上架" :visible.sync="dialogFormVisible">
          <el-form :model="form">
            <el-form-item label="供应类型" :label-width="formLabelWidth">
              <el-select v-model="form.supplyType" placeholder="请选择">
                <el-option label="早餐" value="早餐"></el-option>
                <el-option label="午餐" value="午餐"></el-option>
                <el-option label="下午茶" value="下午茶"></el-option>
                <el-option label="晚餐" value="晚餐"></el-option>
                <el-option label="夜宵" value="夜宵"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="供应时间" :label-width="formLabelWidth">
              <el-select v-model="form.supplyWeek" placeholder="请选择">
                <el-option label="星期一" value="星期一"></el-option>
                <el-option label="星期二" value="星期二"></el-option>
                <el-option label="星期三" value="星期三"></el-option>
                <el-option label="星期四" value="星期四"></el-option>
                <el-option label="星期五" value="星期五"></el-option>
                <el-option label="星期六" value="星期六"></el-option>
                <el-option label="星期天" value="星期天"></el-option>
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

export default {
  data(){
    return{
      formLabelWidth: '120px',
      dialogFormVisible: false,
      stripe:true,
      border:true,
      //weeks:'',

      loading: false,
      currPage: 1,
      pageInfo: {},

      formInline:{//查找数据
        foodName:'',
        foodType:'',
      },

      form:{
        foodId: '',
        supplyType:'',
        supplyWeek:'',
      }
    }
  },
  created() {
    this.getData()
  },
  methods: {
    getData(){
      this.loading = true
      let postData = this.$qs.stringify({
        foodName:this.formInline.foodName,
        foodType:this.formInline.foodType,
      })
      let path = `http://localhost:8080/food/findByConditionAndPages/${this.currPage}`
      this.$ajax.post(path,postData).then(res=>{
        this.pageInfo = res.data
        this.loading = false
        console.log(this.pageInfo)
      })
    },
    handleCurrentChange(val) {
      this.currPage = val
      this.getData()
    },
    handleShow(id){//查看该膳食供应时间
      this.$router.push({path:"/supplyByOneFood",query:{foodId:id}})
    },
    handleSupply(id){//打开上架模态框,处理膳食供应时间
      console.log(id)
      this.dialogFormVisible = true//打开弹出框
      this.form.foodId = id
    },
    submitSupply(row){
      console.log(row)
      this.dialogFormVisible = false//关闭弹出框
      let postData = this.$qs.stringify({
        foodId: this.form.foodId,
        supplyType:this.form.supplyType,
        supplyWeek:this.form.supplyWeek,
      });
      let path = 'http://localhost:8080/supply/add'
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
    handleQuery(){//查询
      this.currPage = 1
      this.getData();
    }
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
  }
}
</script>

<style scoped>
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