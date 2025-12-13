<template>
  <section class="banner-section">
    <div class="banner-container">
      <div class="banner-main" 
           @mouseenter="pauseAutoPlay" 
           @mouseleave="resumeAutoPlay"
           @touchstart="handleTouchStart"
           @touchmove="handleTouchMove"
           @touchend="handleTouchEnd">
        <div class="banner-slider" :style="{ transform: `translateX(-${currentIndex * 100}%)` }">
          <div
            v-for="(slide, index) in slides"
            :key="index"
            class="banner-slide"
            :style="slide.image ? { backgroundImage: `url(${slide.image})`, backgroundSize: 'cover', backgroundPosition: 'center' } : { backgroundImage: `linear-gradient(135deg, ${slide.color1}, ${slide.color2})` }"
          >
            <div class="slide-overlay" v-if="slide.image"></div>
            <div class="slide-content">
              <h2 class="slide-title">{{ slide.title }}</h2>
              <p class="slide-desc">{{ slide.description }}</p>
              <button class="slide-btn" @click="handleClick(slide)">立即查看</button>
            </div>
          </div>
        </div>
        <!-- 左右箭头导航 -->
        <button class="nav-arrow nav-arrow-left" @click="prevSlide" aria-label="上一张">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M15 18l-6-6 6-6"/>
          </svg>
        </button>
        <button class="nav-arrow nav-arrow-right" @click="nextSlide" aria-label="下一张">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M9 18l6-6-6-6"/>
          </svg>
        </button>
        <!-- 指示器 -->
        <div class="banner-dots">
          <span
            v-for="(slide, index) in slides"
            :key="index"
            class="dot"
            :class="{ active: currentIndex === index }"
            @click="goToSlide(index)"
            :aria-label="`切换到第${index + 1}张`"
          ></span>
        </div>
      </div>
      <div class="banner-side">
        <div class="side-item" v-for="(item, index) in sideItems" :key="index">
          <div class="side-icon">{{ item.icon }}</div>
          <div class="side-content">
            <div class="side-title">{{ item.title }}</div>
            <div class="side-desc">{{ item.desc }}</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const props = defineProps({
  slides: {
    type: Array,
    default: () => [
      {
        title: '新品上市',
        description: '精选好物，限时优惠',
        color1: '#2563eb',
        color2: '#4f46e5',
        link: '/products?tag=new'
      },
      {
        title: '限时抢购',
        description: '每日特价，不容错过',
        color1: '#ef4444',
        color2: '#dc2626',
        link: '/products?tag=flash'
      },
      {
        title: '品质生活',
        description: '精选商品，品质保证',
        color1: '#10b981',
        color2: '#059669',
        link: '/products?tag=quality'
      }
    ]
  },
  sideItems: {
    type: Array,
    default: () => [
      { icon: '🎁', title: '新人专享', desc: '注册即送优惠券' },
      { icon: '⚡', title: '限时秒杀', desc: '每日10点开抢' },
      { icon: '🏆', title: '品牌特卖', desc: '大牌低价' }
    ]
  },
  autoplay: {
    type: Boolean,
    default: true
  },
  interval: {
    type: Number,
    default: 4000
  }
})

const emit = defineEmits(['slide-click'])

const currentIndex = ref(0)
let timer = null
let touchStartX = 0
let touchEndX = 0
let isPaused = false

const handleClick = (slide) => {
  emit('slide-click', slide)
}

const nextSlide = () => {
  currentIndex.value = (currentIndex.value + 1) % props.slides.length
}

const prevSlide = () => {
  currentIndex.value = (currentIndex.value - 1 + props.slides.length) % props.slides.length
}

const goToSlide = (index) => {
  currentIndex.value = index
}

const autoPlay = () => {
  if (!props.autoplay || isPaused) return
  timer = setInterval(() => {
    nextSlide()
  }, props.interval)
}

const pauseAutoPlay = () => {
  isPaused = true
  if (timer) {
    clearInterval(timer)
    timer = null
  }
}

const resumeAutoPlay = () => {
  isPaused = false
  autoPlay()
}

// 触摸滑动支持
const handleTouchStart = (e) => {
  touchStartX = e.touches[0].clientX
  pauseAutoPlay()
}

const handleTouchMove = (e) => {
  // 阻止默认滚动行为
  e.preventDefault()
}

const handleTouchEnd = (e) => {
  touchEndX = e.changedTouches[0].clientX
  const diff = touchStartX - touchEndX
  
  // 滑动距离超过50px才切换
  if (Math.abs(diff) > 50) {
    if (diff > 0) {
      nextSlide()
    } else {
      prevSlide()
    }
  }
  
  resumeAutoPlay()
}

// 键盘导航支持
const handleKeyDown = (e) => {
  if (e.key === 'ArrowLeft') {
    prevSlide()
  } else if (e.key === 'ArrowRight') {
    nextSlide()
  }
}

onMounted(() => {
  autoPlay()
  window.addEventListener('keydown', handleKeyDown)
})

onUnmounted(() => {
  if (timer) {
    clearInterval(timer)
  }
  window.removeEventListener('keydown', handleKeyDown)
})
</script>

<style scoped>
.banner-section {
  background-color: #f5f5f5;
  padding: 20px 0;
}

.banner-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 16px;
  display: grid;
  grid-template-columns: 3fr 1fr;
  gap: 16px;
}

.banner-main {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  height: 400px;
}

.banner-slider {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.banner-slide {
  min-width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  flex-shrink: 0;
  position: relative;
}

.slide-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.3));
  z-index: 0;
}

.slide-content {
  position: relative;
  z-index: 1;
  text-align: center;
  padding: 20px;
  max-width: 80%;
}

.slide-content {
  text-align: center;
  z-index: 1;
  position: relative;
}

.slide-title {
  font-size: 36px;
  font-weight: 700;
  margin-bottom: 16px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.slide-desc {
  font-size: 18px;
  margin-bottom: 24px;
  opacity: 0.95;
}

.slide-btn {
  padding: 12px 32px;
  background-color: #fff;
  color: #2563eb;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.slide-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
}

.nav-arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 40px;
  height: 40px;
  background-color: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 3;
  transition: all 0.3s ease;
  backdrop-filter: blur(4px);
}

.nav-arrow:hover {
  background-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-50%) scale(1.1);
}

.nav-arrow:active {
  transform: translateY(-50%) scale(0.95);
}

.nav-arrow-left {
  left: 16px;
}

.nav-arrow-right {
  right: 16px;
}

.banner-dots {
  position: absolute;
  bottom: 16px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 8px;
  z-index: 2;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.5);
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.dot.active {
  background-color: #fff;
  width: 24px;
  border-radius: 4px;
}

.banner-side {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.side-item {
  background-color: #fff;
  border-radius: 8px;
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.side-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.side-icon {
  font-size: 32px;
  flex-shrink: 0;
}

.side-content {
  flex: 1;
}

.side-title {
  font-size: 16px;
  font-weight: 600;
  color: #111827;
  margin-bottom: 4px;
}

.side-desc {
  font-size: 12px;
  color: #6b7280;
}

@media (max-width: 960px) {
  .banner-container {
    grid-template-columns: 1fr;
  }

  .banner-main {
    height: 300px;
  }

  .slide-title {
    font-size: 28px;
  }

  .slide-desc {
    font-size: 16px;
  }
}
</style>

