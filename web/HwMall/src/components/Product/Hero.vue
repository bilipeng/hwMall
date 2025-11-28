<template>
  <section class="hero">
    <div class="hero-inner">
      <div>
        <h1 class="hero-title">在线选购 · 轻松下单 · 一站式简易商城</h1>
        <p class="hero-subtitle">
          支持用户注册登录、购物车管理、订单创建与查询、商品搜索和分类筛选等核心功能。
          当前页面为基于需求文档实现的首页，后续可接入后端接口。
        </p>
        <div class="hero-actions">
          <button class="btn btn-primary" @click="scrollToProducts">开始逛逛</button>
          <button class="btn btn-ghost" @click="goToOrders">查看我的订单</button>
        </div>
        <div class="hero-stats">
          <div>
            <div class="hero-stat-number">50+</div>
            <div>热销商品示例</div>
          </div>
          <div>
            <div class="hero-stat-number">7</div>
            <div>核心业务模块</div>
          </div>
          <div>
            <div class="hero-stat-number">RESTful</div>
            <div>前后端分离架构</div>
          </div>
        </div>
      </div>
      <div class="hero-banner">
        <div>
          <div class="hero-banner-title">系统核心流程概览</div>
          <div class="hero-banner-desc">
            用户登录后，可浏览商品、加入购物车、创建订单并查看历史订单。支持搜索与分类筛选，后端采用 Spring Boot + MyBatis 提供接口。
          </div>
        </div>
        <div class="hero-banner-grid">
          <div class="hero-banner-card">
            <div class="hero-banner-card-title">用户 & 购物车</div>
            <div>注册 / 登录 · 购物车增删改 · 查看商品数量</div>
          </div>
          <div class="hero-banner-card">
            <div class="hero-banner-card-title">订单 & 支付流程</div>
            <div>确认收货地址 · 创建订单 · 查看订单列表与状态</div>
          </div>
          <div class="hero-banner-card">
            <div class="hero-banner-card-title">商品展示</div>
            <div>首页展示精选商品 · 查看详情 · 分页/列表展示</div>
          </div>
          <div class="hero-banner-card">
            <div class="hero-banner-card-title">搜索与筛选</div>
            <div>支持关键词搜索、分类筛选与价格区间过滤</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const scrollToProducts = () => {
  const section = document.getElementById('products')
  if (section) {
    section.scrollIntoView({ behavior: 'smooth' })
  }
}

const goToOrders = () => {
  router.push('/order')
}
</script>

<style scoped>
.hero {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
}

.hero-inner {
  max-width: 1120px;
  margin: 0 auto;
  padding: 32px 16px 28px;
  display: grid;
  grid-template-columns: minmax(0, 3fr) minmax(0, 2fr);
  gap: 32px;
  align-items: center;
}

.hero-title {
  font-size: 32px;
  line-height: 1.2;
  font-weight: 700;
  margin-bottom: 12px;
}

.hero-subtitle {
  font-size: 14px;
  line-height: 1.6;
  color: #e5e7eb;
  margin-bottom: 20px;
}

.hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  border: none;
  cursor: pointer;
  transition: background-color 0.15s ease, color 0.15s ease, box-shadow 0.15s ease;
}

.btn-primary {
  background-color: #fbbf24;
  color: #111827;
  font-weight: 600;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
}

.btn-primary:hover {
  background-color: #f59e0b;
}

.btn-ghost {
  background-color: transparent;
  border: 1px solid rgba(255, 255, 255, 0.6);
  color: #e5e7eb;
}

.btn-ghost:hover {
  background-color: rgba(15, 23, 42, 0.4);
}

.hero-stats {
  display: flex;
  gap: 24px;
  margin-top: 18px;
  font-size: 13px;
  color: #e5e7eb;
}

.hero-stat-number {
  font-size: 18px;
  font-weight: 600;
}

.hero-banner {
  background-color: rgba(15, 23, 42, 0.35);
  border-radius: 14px;
  padding: 18px 18px 16px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  box-shadow: 0 10px 25px rgba(15, 23, 42, 0.5);
}

.hero-banner-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 4px;
}

.hero-banner-desc {
  font-size: 13px;
  color: #e5e7eb;
}

.hero-banner-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 10px;
  font-size: 12px;
}

.hero-banner-card {
  background-color: rgba(15, 23, 42, 0.75);
  border-radius: 10px;
  padding: 10px 12px;
}

.hero-banner-card-title {
  font-weight: 600;
  margin-bottom: 4px;
  font-size: 12px;
}

@media (max-width: 960px) {
  .hero-inner {
    grid-template-columns: minmax(0, 1fr);
  }
}

@media (max-width: 720px) {
  .hero-inner {
    padding-top: 20px;
  }

  .hero-title {
    font-size: 24px;
  }
}
</style>

