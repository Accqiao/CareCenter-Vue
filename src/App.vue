<template>
  <div>
    <router-view></router-view>
  </div>
<!--  <div class="MaxDiv">-->
<!--    <div style="height: 19%;">-->
<!--      <Header/>-->
<!--    </div>-->

<!--    <div class="down">-->
<!--      <router-view></router-view>-->
<!--    </div>-->
<!--  </div>-->
</template>

<script>
// import Header from "@/components/Header/Header";

export default {
  name: 'App',
  components: {
    // Header,
  }
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
}

/*html,body{*/
/*  height: 100%;*/
/*  margin: 0;*/
/*  padding:0;*/
/*  !*text-align: center;*!*/
/*  background: #f4f8f6;*/
/*}*/
/*.MaxDiv{*/
/*  height: 100%;*/
/*  margin: 0; !* 需要清除body自带的外边距 *!*/
/*  padding:0;*/
/*  background-color:rgb(254 255 243);*/
/*}*/
/*.down{*/
/*  height: 78%;*/
/*  border-radius:5px;*/
/*  padding: 10px;*/
/*}*/
</style>
