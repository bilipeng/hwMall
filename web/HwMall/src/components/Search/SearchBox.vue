<template>
  <div class="search-box">
    <div class="search-input-wrapper">
      <input
        type="text"
        class="search-input"
        v-model="keyword"
        :placeholder="placeholder"
        @keyup.enter="handleSearch"
        @focus="showHistory = true"
        @blur="handleBlur"
      />
      <button class="search-btn" @click="handleSearch">搜索</button>
    </div>

    <!-- 搜索历史（可选） -->
    <div v-if="showHistory && searchHistory.length > 0" class="search-history">
      <div class="history-header">
        <span>搜索历史</span>
        <button class="clear-history-btn" @click="clearHistory">清空</button>
      </div>
      <div class="history-list">
        <span
          v-for="(item, index) in searchHistory"
          :key="index"
          class="history-item"
          @click="selectHistory(item)"
        >
          {{ item }}
        </span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const props = defineProps({
  placeholder: {
    type: String,
    default: '搜索商品名称，例如：手机、耳机、电脑'
  }
})

const emit = defineEmits(['search'])

const keyword = ref('')
const showHistory = ref(false)
const searchHistory = ref([])

// 从 localStorage 加载搜索历史
const loadHistory = () => {
  const history = localStorage.getItem('searchHistory')
  if (history) {
    try {
      searchHistory.value = JSON.parse(history)
    } catch (e) {
      searchHistory.value = []
    }
  }
}

// 保存搜索历史
const saveHistory = (keyword) => {
  if (!keyword || keyword.trim() === '') return

  // 去重
  let history = searchHistory.value.filter(item => item !== keyword)
  // 添加到开头
  history.unshift(keyword)
  // 限制数量（最多10条）
  history = history.slice(0, 10)
  searchHistory.value = history

  // 保存到 localStorage
  localStorage.setItem('searchHistory', JSON.stringify(history))
}

// 处理搜索
const handleSearch = () => {
  const searchKeyword = keyword.value.trim()
  if (searchKeyword === '') {
    alert('请输入搜索关键词')
    return
  }

  // 保存到历史记录
  saveHistory(searchKeyword)

  // 触发搜索事件
  emit('search', searchKeyword)
  showHistory.value = false
}

// 选择历史记录
const selectHistory = (item) => {
  keyword.value = item
  handleSearch()
}

// 清空历史记录
const clearHistory = () => {
  searchHistory.value = []
  localStorage.removeItem('searchHistory')
}

// 处理失焦事件（延迟隐藏，以便点击历史记录）
const handleBlur = () => {
  setTimeout(() => {
    showHistory.value = false
  }, 200)
}

onMounted(() => {
  loadHistory()
})
</script>

<style scoped>
.search-box {
  position: relative;
  width: 100%;
}

.search-input-wrapper {
  display: flex;
  gap: 8px;
  align-items: center;
}

.search-input {
  flex: 1;
  padding: 10px 16px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.15s ease, box-shadow 0.15s ease;
}

.search-input:focus {
  outline: none;
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.search-btn {
  padding: 10px 24px;
  background-color: #2563eb;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.search-btn:hover {
  background-color: #1d4ed8;
}

.search-history {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  margin-top: 8px;
  background-color: #fff;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  z-index: 100;
  max-height: 300px;
  overflow-y: auto;
}

.history-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  border-bottom: 1px solid #e5e7eb;
  font-size: 14px;
  font-weight: 500;
  color: #6b7280;
}

.clear-history-btn {
  background: none;
  border: none;
  color: #2563eb;
  font-size: 12px;
  cursor: pointer;
  padding: 0;
}

.clear-history-btn:hover {
  text-decoration: underline;
}

.history-list {
  padding: 8px;
}

.history-item {
  display: inline-block;
  padding: 8px 12px;
  margin: 4px;
  background-color: #f3f4f6;
  border-radius: 4px;
  font-size: 13px;
  color: #374151;
  cursor: pointer;
  transition: background-color 0.15s ease;
}

.history-item:hover {
  background-color: #e5e7eb;
}
</style>

