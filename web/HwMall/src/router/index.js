// 路由配置
import { createRouter, createWebHistory } from 'vue-router'
import CartView from '@/views/Cart/CartView.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/App.vue')
  },
  {
    path: '/cart',
    name: 'Cart',
    component: CartView
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router


