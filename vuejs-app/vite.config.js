import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(), vueDevTools()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  // ADD THIS SERVER BLOCK BELOW:
  server: {
    host: "0.0.0.0", // Forces Vite to listen to network traffic outside the container
    port: 5173,
    watch: {
      usePolling: true, // Essential for saving changes to update instantly inside Docker
    },
  },
});
