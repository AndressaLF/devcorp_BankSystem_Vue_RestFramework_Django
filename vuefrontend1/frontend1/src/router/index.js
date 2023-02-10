import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import Correntistas from '../views/Correntistas.vue'
import Movimentacoes from '../views/Movimentacoes.vue'
import LogIn from '../views/LogIn.vue'
import SingUp from '../views/SingUp.vue'

import store from '../store'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/correntistas',
    name: 'correntistas',
    component: Correntistas,
    //meta: {
     // requireLogin: true
    //}
  },
  {
    path: '/movimentacoes',
    name: 'movimentacoes',
    component: Movimentacoes,
    //meta: {
      //requireLogin: true
    //}
  },
  {
    path: '/log-in',
    name: 'LogIn',
    component: LogIn
  },
  {
    path: '/sing-up',
    name: 'SingUp',
    component: SingUp
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requireLogin) && !store.state.isAuthenticated) {
    next('/log-in')
  } else {
    next()
  }
})


export default router
