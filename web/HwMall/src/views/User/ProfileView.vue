<template>
  <div class="profile-view">
    <Navbar />
    <main class="profile-content">
      <Profile />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import Profile from '@/components/User/Profile.vue'
import Navbar from '@/components/Layout/Navbar.vue'
import Footer from '@/components/Layout/Footer.vue'
</script>

<style scoped>
.profile-view {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f5f5f5;
}

.profile-content {
  flex: 1;
  padding: 2rem 1rem;
}
</style>