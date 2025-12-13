<template>
  <div class="page-wrapper">
    <Navbar />
    <main class="main container">
      <div v-if="loading" class="loading">加载中...</div>
      <div v-else-if="error" class="error">{{ error }}</div>
      <ProductDetail v-else :product="product" />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
import ProductDetail from '@/components/Product/ProductDetail.vue'
import { getProductById } from '@/api/product.js'

const route = useRoute()
const product = ref({})
const loading = ref(false)
const error = ref('')

onMounted(async () => {
  const id = Number(route.params.id)
  if (!id) {
    error.value = '无效的商品ID'
    return
  }
  loading.value = true
  try {
    const res = await getProductById(id)
    // 兼容拦截器返回 data 或直接返回对象
    const data = res && (res.data || res)
    if (data) {
      product.value = data
    } else {
      error.value = '未找到商品'
    }
  } catch (e) {
    console.error(e)
    error.value = '获取商品详情失败'
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.page-wrapper { min-height: 100vh; }
.main { padding: 24px 16px; max-width: 1120px; margin: 0 auto }
.loading, .error { padding: 40px; text-align: center }
</style>