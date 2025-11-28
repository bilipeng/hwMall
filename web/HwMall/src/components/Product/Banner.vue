<template>
  <section class="banner-section">
    <div class="banner-container">
      <div class="banner-main">
        <div class="banner-slider">
          <div
            v-for="(slide, index) in slides"
            :key="index"
            class="banner-slide"
            :class="{ active: currentIndex === index }"
            :style="{ backgroundImage: `linear-gradient(135deg, ${slide.color1}, ${slide.color2})` }"
          >
            <div class="slide-content">
              <h2 class="slide-title">{{ slide.title }}</h2>
              <p class="slide-desc">{{ slide.description }}</p>
              <button class="slide-btn" @click="handleClick(slide)">立即查看</button>
            </div>
          </div>
        </div>
        <div class="banner-dots">
          <span
            v-for="(slide, index) in slides"
            :key="index"
            class="dot"
            :class="{ active: currentIndex === index }"
            @click="currentIndex = index"
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
  }
})

const emit = defineEmits(['slide-click'])

const currentIndex = ref(0)
let timer = null

const handleClick = (slide) => {
  emit('slide-click', slide)
}

const autoPlay = () => {
  timer = setInterval(() => {
    currentIndex.value = (currentIndex.value + 1) % props.slides.length
  }, 4000)
}

onMounted(() => {
  autoPlay()
})

onUnmounted(() => {
  if (timer) {
    clearInterval(timer)
  }
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
}

.banner-slide {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  transition: opacity 0.8s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
}

.banner-slide.active {
  opacity: 1;
}

.slide-content {
  text-align: center;
  z-index: 1;
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

