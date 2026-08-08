<template></template>
<script setup>
import { onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { LoadingModal, MessageModal, CloseModal } from "@/functions/swal";
import { apiOAuthExchangeToken } from "@/functions/api/oauth";
import { useUserStore } from "@/stores/user";

const userStore = useUserStore();
const router = useRouter();
const route = useRoute();

onMounted(async () => {
  try {
    LoadingModal("Processing authentication...");
    const error = route.query.error;
    if (error === 'oauth_failed' || error === '_oauth_failed') {
      return MessageModal({ icon: "error", title: "Error", text: "OAuth authentication failed. Please try again." }, () => {
        return router.replace({ name: 'auth.signin' });
      });
    }

    const token = route.query.token;
    if (!token) {
      return MessageModal({ icon: "error", title: "Error", text: "Authentication failed. No token received." }, () => {
        return router.replace({ name: 'auth.signin' });
      });
    }

    const response = await apiOAuthExchangeToken(token);
    userStore.setState(response.data.user);
    userStore.setSanctumToken(response.data.token);
    CloseModal();
    return router.replace({ name: 'dashboard' });
  } catch (e) {
    return MessageModal({ icon: "error", title: "Error", text: "OAuth authentication failed. Please try again." }, () => {
      return router.replace({ name: 'auth.signin' });
    });
  }
});
</script>