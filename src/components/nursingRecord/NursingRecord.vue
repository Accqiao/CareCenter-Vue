<template>
    <div>
        <div class="nursingRecord-list">
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>护理管理</el-breadcrumb-item>
                <el-breadcrumb-item>护理记录信息维护</el-breadcrumb-item>
                <!--                <el-breadcrumb-item :to="{ path: '/main/companyAdd' }">新增</el-breadcrumb-item>-->
            </el-breadcrumb>
            <div class="search">
            <el-form :inline="true" :model="formInline" ref="formInline" class="demo-form-inline">
                <el-form-item label="用户id" prop="customerId">
                    <el-input v-model="formInline.customerId" placeholder="请输入用户id"></el-input>
                </el-form-item>
                <el-form-item label="员工id" prop="staffinfoId">
                    <el-input v-model="formInline.staffinfoId" placeholder="请输入员工id"></el-input>
                </el-form-item>
                <el-form-item label="护理名称" prop="nursingContent">
                    <template>
                        <el-select v-model="formInline.nursingContent" clearable="clearable" placeholder="请选择护理名称">
                            <el-option
                                    v-for="item in distinctNursingName"
                                    :key="item.nursingName"
                                    :label="item.nursingName"
                                    :value="item.id">
                            </el-option>
                        </el-select>
                    </template>
                </el-form-item>
<!--                <el-form-item label="护理时间" prop="nursingTime">-->
<!--                    <template>-->
<!--                        <el-date-picker-->
<!--                                v-model="formInline.nursingTime"-->
<!--                                type="date"-->
<!--                                placeholder="选择日期"-->
<!--                                format="yyyy-MM-dd">-->
<!--                        </el-date-picker>-->
<!--                    </template>-->
<!--                </el-form-item>-->
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">查询</el-button>
                    <el-button type="primary" @click="resetForm('formInline')">重置</el-button>
                    <el-button type="primary" @click="handleAdd">新增</el-button>
                </el-form-item>
            </el-form>
            </div>
        </div>
        <el-table class="tab"
                  :data="pageInfo.list"
                  stripe
                  :border="true"
                  :cell-style="rowClass"
                  :header-cell-style="rowClass"
                  style="width: 100%">
            <el-table-column type="expand">
                <template slot-scope="props">
                    <el-form label-position="left" inline class="demo-table-expand">
                        <el-form-item>
                            <label>护理内容&emsp;</label>
                            <span>{{ props.row.content.describe }}</span>
                        </el-form-item>
                        <el-form-item>
                            <label>护理级别&emsp;</label>
                            <span>{{ props.row.level.levelName }}</span>
                        </el-form-item>
                        <el-form-item>
                            <label>价&emsp;&emsp;格&emsp;</label>
                            <span>{{ props.row.content.serialPrice }}</span>元
                        </el-form-item>
                        <el-form-item>
                            <label>备&emsp;&emsp;注&emsp;</label>
                            <span>{{ props.row.remarks }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column
                    prop="customerId"
                    label="用户id"
                    width="300%">
            </el-table-column>
            <el-table-column
                    prop="staffinfoId"
                    label="员工id"
                    width="300%">
            </el-table-column>
            <el-table-column
                    prop="content.nursingName"
                    label="护理名称"
                    width="300%">
            </el-table-column>
            <el-table-column
                    prop="nursingTime"
                    label="护理时间"
                    width="350%">
                <template slot-scope="scope">
                    {{scope.row.nursingTime|formatDate}}
                </template>
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            disabled
                            @click="handleEdit(scope.row.id)">编辑</el-button>
                    <el-button
                            size="mini"
                            type="danger"
                            @click="handleDelete(scope.row.id)">删除</el-button>
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
</template>

<script>
    import {makeDate} from '../../common/js/dateformat'
    export default {
        data() {
            return {
                currPage: 1,
                formInline: {
                    customerId: '',
                    staffinfoId: '',
                    nursingContent: '',
                    nursingTime: '',
                },
                pageInfo: {},
                distinctNursingName: {},
            }
        },
        created() {
            this.getData();
            this.getDistinctNursingName();
        },
        methods: {
            getData(){
                console.log(this.formInline)
                let path = `http://localhost:8080/nursingRecord/queryAll/${this.currPage}`
                this.$ajax.post(path,this.formInline).then(res=>{
                    this.pageInfo = res.data;
                    console.log(this.pageInfo)
                })
            },
            getDistinctNursingName(){
                let path = 'http://localhost:8080/nursingContent/selDistinctName'
                this.$ajax.get(path).then(res=>{
                    this.distinctNursingName = res.data;
                    console.log(this.distinctNursingName)
                })
            },
            onSubmit() {    //提交查询内容
                this.getData()
            },
            resetForm(formInline) {   //重置查询条件
                this.currPage = 1;
                this.$refs[formInline].resetFields();
                this.getData();
                this.getDistinctNursingName();
            },
            handleAdd(){
                this.$router.push('/main/NursingRecordAdd')
            },
            handleCurrentChange(val) {
                this.currPage = val;
                this.getData();
                this.getDistinctNursingName();
            },
            handleEdit(id) {
                this.$router.push(`/main/nursingRecordUpdate/${id}`);
            },
            handleDelete(id) {
                let path = `http://localhost:8080/nursingRecord/del/${id}`;
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
            rowClass() {    //设置表头样式
                return "text-align: center";
            },
        },
        filters: {
            formatDate(val){
                return makeDate(val);
            },
        }
    }
</script>

<style scoped>
    .nursingRecord-list{
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
    .search {
        margin-left: 5%;
    }
    .demo-table-expand .el-form-item {
        margin-left: 5%;
        margin-right: 0;
        margin-bottom: 0;
        width: 100%;
    }
    .demo-table-expand label {
        color: #1989fa;
    }
</style>