<template>
    <div class="add-nursingLevel">
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item>护理管理</el-breadcrumb-item>
            <el-breadcrumb-item :to="{ path: '/main/nursingLevel' }">护理级别信息维护</el-breadcrumb-item>
            <el-breadcrumb-item>新增护理级别</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card class="box-card">
            <div slot="header">
                <span>新增护理级别</span>
            </div>
            <div>
                <el-form :model="ruleForm" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                    <el-form-item label="级别名称" prop="levelName">
                        <el-input v-model="ruleForm.levelName"></el-input>
                    </el-form-item>
                    <el-form-item label="逻辑删除标记" prop="delFlag">
                        <el-select v-model="ruleForm.delFlag" placeholder="显示 / 隐藏">
                            <el-option label="显示" value="0"></el-option>
                            <el-option label="隐藏" value="1"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="级别状态" prop="levelStatus">
                        <el-select v-model="ruleForm.levelStatus" placeholder="是否启用">
                            <el-option label="启用" value="1"></el-option>
                            <el-option label="停用" value="2"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="备注" prop="remarks" >
                        <el-input type="textarea" :rows="8" v-model="ruleForm.remarks"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
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
            return {
                ruleForm: {
                    delFlag: '',
                    levelName: '',
                    levelStatus: '',
                    remarks: ''
                }
            }
        },
        methods: {
            submitForm(formName){
                this.$refs[formName].validate((valid)=>{
                    if(valid){
                        let path = 'http://localhost:8080/nursingLevel/add'
                        this.$ajax.post(path,this.ruleForm).then(res=>{
                            if(res.data.status === 200){
                                this.$message({
                                    message: '添加成功',
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
    .add-nursingLevel {
        padding: 10px;
    }
</style>