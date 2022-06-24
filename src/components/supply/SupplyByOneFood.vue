<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item>膳食信息</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/food' }">膳食管理</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/supply' }">上架</el-breadcrumb-item>
      <el-breadcrumb-item>{{food.foodName}}的上架信息</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <h2>{{food.foodName}}</h2>
        <span>{{food.foodType}}  |  {{food.foodSign}} </span>
        <span>  |  {{food.isSteam|formatIsSteam}}   |  价格：{{food.foodPrice}} 元 </span>
        <div class="remark">
          {{food.description}}
        </div>
      </div>

      <div>
        <h3>本周该膳食的所有供应信息</h3>
        <div v-if="food.supplyList !== undefined && food.supplyList.length > 0 ">
          <ul >
            <li class="title">
              <span>供应类型</span>
              <span>供应时间</span>
              <span>上架时间</span>
            </li>

            <li v-for="item in food.supplyList" :key="item.id">
              <span>{{item.supplyType}}</span>
              <span>{{item.supplyWeek}} </span>
              <span>{{item.addDate|convertDate}}</span>
            </li>
          </ul>
        </div>
        <div v-else>
          暂无供应信息
        </div>

      </div>
    </el-card>
  </div>
</template>

<script>
import {makeDate} from "@/common/js/dateformat";

export default {
  data(){
    return{
      food:{
        foodId:"",
        supplyList:[],
      }
    }
  },
  created() {
    this.food.foodId = this.$route.query.foodId;
    console.log(this.food.foodId);
    this.getData();
  },
  methods:{
    getData(){
      let path = `http://localhost:8080/food/findAllSupplyByFood/${this.food.foodId}`
      this.$ajax.get(path).then(res=>{
        this.food = res.data;
        console.log(this.food)
      })
    }
  },
  filters:{//过滤器
    //格式化
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
  h2 {
    margin-bottom: 10px;
  }
  .remark {
    margin-top: 10px;
    padding-top: 10px;
    border-top: 1px solid #dbdbdb;
    font-size: 14px;
    color: #666;
  }
  .title {
    margin-top: 10px;
    padding-top: 10px;
    border-bottom: 1px solid #dbdbdb;
    font-size: 16px;
    font-weight: bold;
  }
  h3 {
    margin-bottom: 10px;
  }
  ul {
    list-style: none;
  }
  li {
    height: 50px;
    line-height: 50px;
    font-size: 14px;
  }
  ul span {
    display: inline-block;
    width: 18%;
  }
  li span {
    display: inline-block;
    width: 18%;
  }
  .post-list {
    padding: 10px;
  }
  .header {
    margin-bottom: 10px;
  }
</style>