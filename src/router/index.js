import VueRouter from "vue-router";

import OverView from "@/components/OverView/OverView";
import Record from "@/components/Record/Record";
import Login from "@/components/login/Login";
import Main from "@/components/main/Main";
import NursingLevel from "@/components/nursinglevel/NursingLevel";
import NursingLevelAdd from "@/components/nursinglevel/NursingLevelAdd";
import NursingLevelUpdate from "@/components/nursinglevel/NursingLevelUpdate";
import NursingRecord from "@/components/nursingRecord/NursingRecord";
import NursingRecordAdd from "@/components/nursingRecord/NursingRecordAdd";
import NursingRecordUpdate from "@/components/nursingRecord/NursingRecordUpdate";
import Customer from "@/components/customer/Customer";
import CustomerAdd from "@/components/customer/CustomerAdd";
import CustomerUpdate from "@/components/customer/CustomerUpdate";
import Staff from "@/components/staff/Staff";
import StaffAdd from "@/components/staff/StaffAdd";
import StaffUpdate from "@/components/staff/StaffUpdate";
import Food from "../components/food/Food";
import FoodAdd from "../components/food/FoodAdd";
import FoodUpdate from "../components/food/FoodUpdate";
//import Login from "../components/login/Login";
import Supply from "../components/supply/Supply";
import SupplyByOneFood from "@/components/supply/SupplyByOneFood";
import SupplyCalendar from "@/components/supply/SupplyCalendar";
import Distribution from "@/components/distribution/Distribution";
import DistributionByOneUser from "@/components/distribution/DistributionByOneUser";


export default  new VueRouter({
    routes:[
        {
            path: '/',
            component: Login
        },
        {
            path: '/main',
            component: Main,
            children: [
                {
                    name:'overView',
                    path:'overView',
                    component:OverView
                },
                {
                    name:'record',
                    path:'record',
                    component:Record
                },
                {
                    path: 'nursingLevel',
                    component: NursingLevel
                },
                {
                    path: 'NursingLevelAdd',
                    component: NursingLevelAdd
                },
                {
                    path: 'NursingLevelUpdate/:id',
                    component: NursingLevelUpdate
                },
                {
                    path: 'NursingRecord',
                    component: NursingRecord
                },
                {
                    path: 'NursingRecordAdd',
                    component: NursingRecordAdd
                },
                {
                    path: 'NursingRecordUpdate/:id',
                    component: NursingRecordUpdate
                },
                {
                    path:"/customer",
                    component:Customer
                },
                {
                    path:"/customerAdd",
                    component:CustomerAdd
                },
                {
                    path:"/customerUpdate",
                    component:CustomerUpdate
                },
                {
                    path:"/staff",
                    component:Staff
                },
                {
                    path:"/staffAdd",
                    component:StaffAdd
                },
                {
                    path:"/staffUpdate",
                    component:StaffUpdate
                },
                {
                    path:'/food',
                    component:Food
                },
                {
                    path:'/foodAdd',
                    component:FoodAdd
                },
                {
                    path:'/foodUpdate',
                    component:FoodUpdate
                },
                {
                    path:'/login',
                    component:Login
                },
                {
                    path:'/supply',
                    component:Supply
                },
                {
                    path:'/supplyByOneFood',
                    component:SupplyByOneFood
                },
                {
                    path:'/supplyCalendar',
                    component:SupplyCalendar
                },
                {
                    path:'/distribution',
                    component:Distribution
                },
                {
                    path:'/distributionByOneUser',
                    component:DistributionByOneUser
                },
            ]
        }

    ]
})
