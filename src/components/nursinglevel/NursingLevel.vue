<template>
  <div>
    <div class="nursingLevel-list">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item>护理管理</el-breadcrumb-item>
        <el-breadcrumb-item>护理级别信息维护</el-breadcrumb-item>
        <!--                <el-breadcrumb-item :to="{ path: '/main/companyAdd' }">新增</el-breadcrumb-item>-->
      </el-breadcrumb>
      <el-form :inline="true" :model="formInline" ref="formInline" class="demo-form-inline">
        <el-form-item label="护理级别id" prop="id">
          <el-input v-model="formInline.id" placeholder="请输入护理级别id"></el-input>
        </el-form-item>
        <el-form-item label="护理级别" prop="levelName">
          <template>
            <el-select v-model="formInline.levelName" clearable="clearable" placeholder="请选择级别名称">
              <el-option
                  v-for="item in distinctNursingLevelName"
                  :key="item.levelName"
                  :label="item.levelName"
                  :value="item.levelName">
              </el-option>
            </el-select>
          </template>
        </el-form-item>
        <el-form-item label="逻辑删除标记" prop="delFlag">
          <el-select v-model="formInline.delFlag" placeholder="显示 / 隐藏">
            <el-option label="显示" value="0"></el-option>
            <el-option label="隐藏" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="是否已启用" prop="levelStatus">
          <el-select v-model="formInline.levelStatus" placeholder="是否启用">
            <el-option label="停用" value="2"></el-option>
            <el-option label="启用" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit">查询</el-button>
          <el-button type="primary" @click="resetForm('formInline')">重置</el-button>
          <el-button type="primary" @click="handleAdd">新增</el-button>
        </el-form-item>
      </el-form>
      <el-table class="tab"
                :data="pageInfo.list"
                stripe
                :border="true"
                :cell-style="rowClass"
                :header-cell-style="HeadRowClass"
                style="width: 100%">
        <el-table-column
            prop="id"
            label="级别id"
            width="150%">
        </el-table-column>
        <el-table-column
            prop="levelName"
            label="级别名称"
            width="300%">
        </el-table-column>
        <el-table-column
            prop="delFlag"
            label="逻辑删除标记"
            width="300%">
          <template slot-scope="scope">
            {{scope.row.delFlag|formatDelFlag}}
          </template>
        </el-table-column>
        <el-table-column
            prop="levelStatus"
            label="是否已启用"
            width="300%">
          <template slot-scope="scope">
            {{scope.row.levelStatus|formatStatus}}
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
                size="small"
                @click="handleEdit(scope.row.id)">编辑</el-button>
            <el-button
                size="small"
                type="danger"
                @click="handleDelete(scope.row.id)">删除</el-button>
            <!--                        <el-button-->
            <!--                                size="mini"-->
            <!--                                type="danger"-->
            <!--                                @click="handleShowPost(scope.row.id)">查看所有职位</el-button>-->
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
  </div>
</template>

<script>
export default {
  data(){
    return {
      currPage: 1,
      pageInfo: {},
      formInline: {
        id: '',
        delFlag: '',
        levelName: '',
        levelStatus: ''
      },
      distinctNursingLevelName: {},
    }
  },
  created() {         //数据初始化
    this.getData();
    this.getDistinctNursingLevelName();
  },
  methods: {
    getData(){
      console.log(this.formInline)
      let path = `http://localhost:8080/nursingLevel/queryAll/${this.currPage}`;
      this.$ajax.post(path,this.formInline).then(res=>{
        this.pageInfo = res.data;
        console.log(this.pageInfo)
      })
    },
    getDistinctNursingLevelName(){
      let path = 'http://localhost:8080/nursingLevel/selDistinctLevelName'
      this.$ajax.get(path).then(res=>{
        this.distinctNursingLevelName = res.data;
        console.log(this.distinctNursingLevelName)
      })
    },
    onSubmit() {    //提交查询内容
      this.getData()
    },
    handleCurrentChange(val) {
      this.currPage = val;
      this.getData();
    },
    rowClass({row,column}) {    //设置表格样式
      if(column.label==="是否已启用")      //指定列
        if(row.levelStatus=="2")       //指定行元素
          return "text-align: center;color :#ff4949";
        else
          return "text-align: center;color: #13ce66";
      else
        return "text-align: center";
    },
    HeadRowClass() {    //设置表头样式
      return "text-align: center";
    },
    resetForm(formInline) {   //重置查询条件
      this.currPage = 1;
      this.$refs[formInline].resetFields();
      this.getData();
    },
    handleAdd(){
      this.$router.push("/main/NursingLevelAdd");
    },
    handleEdit(id){
      this.$router.push(`/main/NursingLevelUpdate/${id}`)
    },
    handleDelete(id){
      let path = `http://localhost:8080/nursingLevel/del/${id}`;
      this.$ajax.get(path).then(res=>{
        if(res.data.status === 200){
          this.$message({
            message: '删除成功',
            type: 'success'
          })
        }
        this.getData();
      });
    },
  },
  filters: {
    formatStatus(val){
      switch (val) {
        case 2:
          val = '停用'
          break;
        case 1:
          val = '启用'
          break;
      }
      return val;
    },
    formatDelFlag(val){
      switch (val) {
        case "0":
          val = '显示'
          break;
        case "1":
          val = '隐藏'
          break;
      }
      return val;
    },
  }
}
</script>

<style scoped>
.nursingLevel-list {
  padding: 10px;
}
.tab {
  border-radius: 5px;
}
.el-breadcrumb {
  margin: -1px 0 5px;
}
.demo-form-inline {
  padding: 10px;
}
</style>
