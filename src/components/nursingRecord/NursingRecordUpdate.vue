<template>
    <div class="update-nursingRecord">
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item>护理管理</el-breadcrumb-item>
            <el-breadcrumb-item :to="{ path: '/main/nursingRecord' }">护理记录信息维护</el-breadcrumb-item>
            <el-breadcrumb-item>修改护理记录</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card class="box-card">
            <div slot="header">
                <span>修改护理记录</span>
            </div>
            <div>
                <el-form :model="ruleForm" ref="ruleForm" :rules="rules" label-width="100px" class="demo-ruleForm">
                    <el-form-item label="用户id" prop="customerId">
                        <el-input v-model="ruleForm.customerId"></el-input>
                    </el-form-item>
                    <el-form-item label="员工id" prop="staffinfoId">
                        <el-input v-model="ruleForm.staffinfoId"></el-input>
                    </el-form-item>
                    <el-form-item label="逻辑删除标记" prop="delFlag">
                        <el-select v-model="ruleForm.delFlag" placeholder="显示 / 隐藏">
                            <el-option label="显示" value="0"></el-option>
                            <el-option label="隐藏" value="1"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="护理名称" prop="nursingContent">
                        <template>
                            <el-select v-model="ruleForm.nursingContent" clearable="clearable" placeholder="请选择护理名称">
                                <el-option
                                        v-for="item in distinctNursingName"
                                        :key="item.nursingName"
                                        :label="item.nursingName"
                                        :value="item.id">
                                </el-option>
                            </el-select>
                        </template>
                    </el-form-item>
                    <el-form-item label="护理数量" prop="nursingCount">
                        <el-input v-model.number="ruleForm.nursingCount"></el-input>
                    </el-form-item>
                    <el-form-item label="备注" prop="remarks" >
                        <el-input type="textarea" :rows="8" v-model="ruleForm.remarks"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="submitForm('ruleForm')">确认修改</el-button>
                        <el-button @click="resetForm('ruleForm')">重置</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </el-card>
    </div>
</template>

<script>
    export default {
        data() {
            return{
                ruleForm: {
                    id: '',
                    customerId: '',
                    staffinfoId: '',
                    delFlag: '',
                    nursingContent: '',
                    nursingCount: '',
                    remarks: ''
                },
                distinctNursingName: {},
                rules: {
                    nursingCount: [
                        { type: 'number', message: '护理数量必须为数字'}
                    ]
                },
            }
        },
        created() {
            this.ruleForm.id = this.$route.params.id;
            this.getData();
            this.getDistinctNursingName();
        },
        methods: {
            getDistinctNursingName(){
                let path = 'http://localhost:8080/nursingContent/selDistinctName'
                this.$ajax.get(path).then(res=>{
                    this.distinctNursingName = res.data;
                    console.log(this.distinctNursingName)
                })
            },
            getData(){
                let path = `http://localhost:8080/nursingRecord/selById/${this.ruleForm.id}`;
                this.$ajax.get(path).then(res=>{
                    this.ruleForm = res.data;
                    console.log(this.ruleForm)
                })
            },
            submitForm(formName){
                this.$refs[formName].validate((valid)=>{
                    if(valid){
                        let path = 'http://localhost:8080/nursingRecord/update'
                        this.$ajax.post(path,this.ruleForm).then(res=>{
                            if(res.data.status === 200){
                                this.$message({
                                    message: '修改成功',
                                    type: 'success'
                                })
                            }
                        })
                    }
                })
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            }
        }
    }
</script>

<style scoped>
    .el-input {
        width: 90%;
    }
    .el-breadcrumb {
        margin: -1px 0 5px;
    }
    .update-nursingRecord {
        padding: 10px;
    }
</style>