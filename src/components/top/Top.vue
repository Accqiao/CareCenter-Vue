<template>
  <div class="home">
    <div class="con">
      <span class="title">颐养中心</span>
      <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
      <span class="operate">{{user.name}}</span>
      <el-button type="info" icon="el-icon-switch-button" circle @click="exit" ></el-button>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      user:{}
    }
  },
  created() {
    this.user = JSON.parse(sessionStorage.getItem("user"));//字符串sessionStorage.getItem("user")转json
    console.log(this.user);
  },

  methods: {
    exit(){
      this.$router.push('/');
    }
  }
}
</script>

<style scoped>

  .el-avatar--circle {
    border-radius: 50%;
    /* display: inline-block; */
    position: absolute;
    right: 150px;
    top: 25px;
  }
  .el-button{
    position: absolute;
    right: 80px;
    top: 25px;
  }
  .operate{
    color: #fff;
    position: absolute;
    right: 200px;
    font-size: 0.8em;
    font-weight: bold;
  }
  .con .title{
    font-weight: bold;
    font-size: 2.5em;
    color: #fff;
  }

</style>