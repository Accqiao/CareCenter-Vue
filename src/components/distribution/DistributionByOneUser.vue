<template>
  <div class="post-list">
    <el-breadcrumb separator-class="el-icon-arrow-right" class="header">
      <el-breadcrumb-item :to="{ path: '/distribution' }">客户膳食</el-breadcrumb-item>
      <el-breadcrumb-item>{{user.name}}的上架信息</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <h2>{{user.name}}</h2>
        <span>年龄：{{user.age}}  |  性别：{{user.sex}} </span>
        <span>  |  电话：{{user.phone}}   |  疾病：{{user.illness}}  </span>
        <div class="remark">
          注意事项：{{user.notes}}
        </div>
      </div>

      <div>
        <h3>本周该用户的所有膳食信息</h3>
        <div v-if="user.distributions !== undefined && user.distributions.length > 0 ">
          <ul >
            <li class="title">
              <span>供应类型</span>
              <span>供应时间</span>
              <span>食品名称</span>
              <span>食品类型</span>
<!--              <span>食品标签</span>-->
              <span>上架时间</span>
            </li>

            <li v-for="item in user.distributions" :key="item.id">
              <span>{{item.supply.supplyType}}</span>
              <span>{{item.supply.supplyWeek}} </span>
              <span>{{item.supply.food.foodName}} </span>
              <span>{{item.supply.food.foodType}} </span>
<!--              <span>{{item.supply.food.foodSign}} </span>-->
              <span>{{item.supply.addDate|convertDate}}</span>
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
      user:{
        cid:"",
        distributions:[],
      }
    }
  },
  created() {
    this.user.cid = this.$route.query.cid;
    console.log(this.user.cid);
    this.getData();
  },
  methods:{
    getData(){
      let path = `http://localhost:8080/customer/findAllDistributionByUser/${this.user.cid}`
      this.$ajax.get(path).then(res=>{
        this.user = res.data;
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