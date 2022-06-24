<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>膳食信息</el-breadcrumb-item>
      <el-breadcrumb-item >膳食管理</el-breadcrumb-item>
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
            <el-button type="primary" @click="handleAdd">新增</el-button>
            <el-button type="primary" @click="handleSupply">上架</el-button>
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
              <el-switch v-model="scope.row.isSteam" active-color="#13ce66" inactive-color="#ff4949"
                         active-value="1" inactive-value="0" @change="handleIsSteam(scope.row)">
                <!--active-value="1"   1为真，清蒸
                  inactive-value="0"   0为假，不清蒸-->
              </el-switch>
            </template>
          </el-table-column>

          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleEdit(scope.row.foodId)">编辑</el-button>
              <el-button size="mini" type="danger" @click="handleDelete(scope.row.foodId)">删除</el-button>
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
      </div>
    </el-card>
  </div>
</template>

<script>

export default {
  data(){
    return{
      stripe:true,
      border:true,

      loading: false,
      currPage: 1,
      pageInfo: {},

      formInline:{//查找数据
        foodName:'',
        foodType:'',
      },
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
        // companyInfo:this.formInline.companyInfo
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
    handleSupply(){
      this.$router.push("/supply");
    },
    handleAdd(){//新增按钮
      this.$router.push("/foodAdd");
    },
    handleEdit(id){
      this.$router.push({path:"/foodUpdate",query:{foodId:id}})
    },
    handleDelete(id){
      let path = `http://localhost:8080/food/delete/${id}`
      this.$ajax.get(path).then(res=>{
        if(res.data.status === 200){
          this.$message({
            message: res.data.message,
            type: 'success'
          });
        }
        this.currPage = 1
        this.getData();
      })
    },
    handleIsSteam(row){//是否热门选择框的更改
      console.log(row)
      let postData = this.$qs.stringify({
        foodId:row.foodId,
        isSteam:row.isSteam,
      });
      let path = 'http://localhost:8080/food/updateByCondition'
      this.$ajax.post(path,postData).then(res=>{
        console.log(res)
        if(res.data.status === 200){
          this.$message({
            message: res.data.message,
            type: 'success'
          });//弹出成功信息
        }
      })
    },
    handleQuery(){//查询
      this.currPage = 1
      this.getData();
    }
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