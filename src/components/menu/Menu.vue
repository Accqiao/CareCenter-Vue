<template>
    <div>
        <el-menu
            :default-active="active"
            class="el-menu-vertical"
            background-color="#EFCAC3"
            text-color="#000"
            active-text-color="darkgoldenrod"
            @select="handleSelect">
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>首页</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="1-1" >入房管理</el-menu-item>
              <el-menu-item index="1-2" >入退记录</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-notebook-2"></i>
              <span>护理管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="2-1" >护理级别信息维护</el-menu-item>
              <el-menu-item index="2-2" >护理记录信息维护</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span>用户管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="3-1" >职工信息</el-menu-item>
              <el-menu-item index="3-2" >用户信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span>膳食管理</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="4-1">膳食管理</el-menu-item>
              <el-menu-item index="4-2">本周膳食</el-menu-item>
              <el-menu-item index="4-3">客户膳食</el-menu-item>
            </el-menu-item-group>
          </el-submenu>


        </el-menu>
    </div>
</template>

<script>
    export default {
        data(){
            return{
                active: "1",
            }
        },
        methods: {
            handleSelect(key){
                console.log(key)
                switch(key){
                  case "1-1":
                    this.$router.push('/main/overView')
                    break;
                  case "1-2":
                    this.$router.push('/main/record')
                    break;
                  case "2-1":
                    this.$router.push('/main/nursingLevel')
                    break;
                  case "2-2":
                    this.$router.push('/main/nursingRecord')
                    break;
                  case "3-1":
                    this.$router.push('/staff');
                    break;
                  case "3-2":
                    this.$router.push('/customer');
                    break;
                  case "4-1":
                    this.$router.push('/food');
                    break;
                  case "4-2":
                    this.$router.push('/supplyCalendar');
                    break;
                  case "4-3":
                    this.$router.push('/distribution');
                    break;

                }
            }

        }
    }
</script>

<style scoped>
    .el-menu-vertical {
        min-height: 780px;
    }
</style>