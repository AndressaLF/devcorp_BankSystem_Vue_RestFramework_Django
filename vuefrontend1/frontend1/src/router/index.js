import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import Correntistas from '../views/Correntistas.vue'
import Movimentacoes from '../views/Movimentacoes.vue'
import LogIn from '../views/LogIn.vue'
import SingUp from '../views/SingUp.vue'



const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/correntistas',
    name: 'correntistas',
    component: Correntistas
  },
  {
    path: '/movimentacoes',
    name: 'movimentacoes',
    component: Movimentacoes
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

export default router
