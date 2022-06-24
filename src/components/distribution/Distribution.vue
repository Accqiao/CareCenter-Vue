<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item >客户膳食</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="姓名">
            <el-input v-model="formInline.name" placeholder="输入姓名"></el-input>
          </el-form-item>
          <el-form-item label="年龄">
            <el-input v-model="formInline.age" placeholder="输入年龄"></el-input>
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
                <el-form-item label="注意事项:"><span>{{ props.row.notes }}</span></el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column prop="name" label="姓名" width="180" ></el-table-column>
          <el-table-column prop="age" label="年龄" width="180"></el-table-column>
          <el-table-column prop="sex" label="性别" width="180"></el-table-column>
          <el-table-column prop="phone" label="电话" width="180"></el-table-column>
          <el-table-column prop="illness" label="健康状况" width="180"></el-table-column>

          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleShow(scope.row.cid)">查看膳食</el-button>
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
import {makeDate} from "../../common/js/dateformat";

export default {
  data(){
    return{
      stripe:true,
      border:true,

      loading: false,
      currPage: 1,
      pageInfo: {},

      formInline:{//查找数据
        name:'',
        age:'',
      },
    }
  },
  created() {
    this.getData()
  },
  methods: {
    getData() {
      this.loading = true
      let postData = this.$qs.stringify({
        name: this.formInline.name,
        age: this.formInline.age,
      })
      let path = `http://localhost:8080/customer/findByCondition/${this.currPage}`
      this.$ajax.post(path, postData).then(res => {
        this.pageInfo = res.data
        this.loading = false
        console.log(this.pageInfo)
      })
    },
    handleCurrentChange(val) {
      this.currPage = val
      this.getData()
    },
    handleShow(id){
      this.$router.push({path:"/distributionByOneUser",query:{cid:id}})
    },
    handleQuery() {//查询
      this.currPage = 1
      this.getData();
    }
  },
  filters:{//过滤器
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