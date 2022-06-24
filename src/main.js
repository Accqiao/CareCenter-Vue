import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import axios from 'axios'
import router from './router'
import VueRouter from "vue-router";


import qs from 'qs';
Vue.prototype.$qs = qs
// import {HashMap} from '@/assets/js/HMap.js'


Vue.config.productionTip = false
Vue.prototype.$ajax = axios
Vue.use(ElementUI)
Vue.use(VueRouter)
new Vue({
  render: h => h(App),
  router,
}).$mount('#app')
