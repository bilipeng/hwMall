import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './assets/main.css' // 确保这个文件存在，如果不存在可以创建或删除这行

const app = createApp(App)

// 使用路由
app.use(router)

app.mount('#app')
