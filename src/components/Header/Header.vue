<template>
  <div class="top">
      <div class="menu">
        <ul>
          <li><a @click="toHome">首页</a></li>
          <li><a @click="toOverView">平面图</a></li>
          <li><a @click="toRecord">入退管理</a></li>
        </ul>
      </div>

  </div>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
      activeIndex: '1',
    };
  },
  methods: {
    toHome:function (){
      this.$router.push("/home")
    },
    toOverView:function (){
      this.$router.push("/overView")
    },
    toRecord:function (){
      this.$router.push("/record")
    },
  }
}
</script>

<style scoped>
.top{
  position: relative;
  top: 50%;
}
.menu{
  overflow: hidden;
  line-height:65px;
  font-size:20px;
  background-color:#233c4f80;
  border-radius:5px;
  /*font-weight:bold;*/
  font-family: "Helvetica Neue"
}
div.menu ul
{
  list-style:none;
  margin: 0;
  padding: 0 20px;
}
div.menu ul li
{
  float:left;
  width:100px;
  height: 65px;
}
div.menu ul li a, div.menu ul li a:visited
{
  color: #c2d5f3;
  text-decoration: none;
  white-space: nowrap;
  margin:0 15px;
  text-align: center;
}
div.menu ul li a:hover
{
  color: #6cc5ed;
}
</style>