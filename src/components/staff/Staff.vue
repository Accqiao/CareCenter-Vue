<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>用户信息</el-breadcrumb-item>
      <el-breadcrumb-item >员工管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <el-form :inline="true" :model="formInline" class="demo-form-inline">
          <el-form-item label="姓名">
            <el-input v-model="formInline.staffName" placeholder="用户名"></el-input>
          </el-form-item>
          <el-form-item label="职务">
            <el-select v-model="formInline.staffJob" placeholder="请选择职务">
              <el-option label="系统管理员" value="系统管理员"></el-option>
              <el-option label="医生" value="医生"></el-option>
              <el-option label="护士" value="护士"></el-option>
              <el-option label="护工" value="护工"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleQuery">查询</el-button>
            <el-button type="primary" @click="handleAdd">新增</el-button>
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
                <el-form-item label="个人简介:"><span>{{ props.row.staffBriefintroduction }}</span></el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column label="姓名" width="180">
            <template slot-scope="scope">
              <div class="wrap">
                <div>{{scope.row.staffName}}</div>
                <div v-if="scope.row.staffImg">
                  <img :src="`http://localhost:8080/${scope.row.staffImg}`" class="image"/>
                </div>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="staffAge" label="年龄" width="80"></el-table-column>
          <el-table-column prop="staffSex" label="性别" width="80"></el-table-column>
          <el-table-column prop="staffPhone" label="电话" width="120"></el-table-column>
          <el-table-column label="入职时间" width="180">
            <template slot-scope="scope">{{scope.row.staffEntrytime|convertDate}}</template>
          </el-table-column>
          <el-table-column prop="staffJob" label="角色" width="120"></el-table-column>
          <el-table-column prop="staffTitle" label="职称" width="80"></el-table-column>



          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleEdit(scope.row.staffId)">编辑</el-button>
              <el-button size="mini" type="danger" @click="handleDelete(scope.row.staffId)">删除</el-button>
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
        staffName:'',
        staffJob:'',
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
        staffName: this.formInline.staffName,
        staffJob: this.formInline.staffJob,
      })
      let path = `http://localhost:8080/staff/findByCondition/${this.currPage}`
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
    handleAdd() {//新增按钮
      this.$router.push("/staffAdd");
    },
    handleEdit(id) {
      this.$router.push({path: "/staffUpdate", query: {staffId: id}})
    },
    handleDelete(id) {
      let path = `http://localhost:8080/staff/delete/${id}`
      this.$ajax.get(path).then(res => {
        console.log(res);
        this.$message({
          message: "删除成功",
          type: 'success'
        });
        this.currPage = 1
        this.getData();
      })
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