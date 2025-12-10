import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('@/views/HomeView.vue')
  },
  {
    path: '/cart',
    name: 'Cart',
    component: () => import('@/views/Cart/CartView.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/User/LoginView.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/User/RegisterView.vue')
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/User/ProfileView.vue')
  },
  // 可以在这里添加更多路由
  {
    path: '/:pathMatch(.*)*',
    redirect: '/'
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL || '/'),
  routes,
  scrollBehavior(to, from, savedPosition) {
    // 返回期望滚动到的位置
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  }
})

export default router
