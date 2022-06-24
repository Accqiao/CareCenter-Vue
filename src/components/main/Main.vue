<template>
    <div>
        <el-container>
            <el-header><Top/></el-header>
            <el-container>
                <el-aside width="200px"><Menu/></el-aside>
                <el-main class="el-main">
                    <router-view></router-view>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script>
    import Top from "../top/Top";
    import Menu from "../menu/Menu";
    export default {

        components: {
            Top: Top,
            Menu: Menu
        }
    }
</script>

<style scoped>
    .el-header {
      background-color: #EFCAC3;
      line-height: 85px;
      height: 85px !important;
    }
    el-aside{
        width: 220px !important;
        height: 600vh;
        background-color: #545c64;
    }
    .el-main{
        margin: 0;
        padding: 0;
    }

</style>